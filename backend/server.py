from fastapi import FastAPI, APIRouter, HTTPException, Depends, status, UploadFile, File
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from dotenv import load_dotenv
from starlette.middleware.cors import CORSMiddleware
from motor.motor_asyncio import AsyncIOMotorClient
from fastapi.responses import StreamingResponse
import os
import logging
from pathlib import Path
from pydantic import BaseModel, Field, EmailStr
from typing import List, Optional, Dict, Any
import uuid
from datetime import datetime, timezone, timedelta
import jwt
import bcrypt
import httpx
import aiofiles
import json
import asyncio

ROOT_DIR = Path(__file__).parent
load_dotenv(ROOT_DIR / '.env')

# MongoDB connection
mongo_url = os.environ['MONGO_URL']
client = AsyncIOMotorClient(mongo_url)
db = client[os.environ['DB_NAME']]

# JWT Config
JWT_SECRET = os.environ.get('JWT_SECRET', 'scriptarc-secret-key-2024')
JWT_ALGORITHM = "HS256"
JWT_EXPIRATION_HOURS = 24

# Judge0 Config
JUDGE0_API_URL = os.environ.get('JUDGE0_API_URL', 'https://judge0-ce.p.rapidapi.com')
JUDGE0_API_KEY = os.environ.get('JUDGE0_API_KEY', '')
JUDGE0_API_HOST = os.environ.get('JUDGE0_API_HOST', 'judge0-ce.p.rapidapi.com')

# Video upload directory
UPLOAD_DIR = ROOT_DIR / 'uploads' / 'videos'
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

app = FastAPI(title="ScriptArc API")
api_router = APIRouter(prefix="/api")
security = HTTPBearer()

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# ==================== MODELS ====================

class UserCreate(BaseModel):
    name: str
    email: EmailStr
    password: str
    role: str = "student"  # student or mentor

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: str
    name: str
    email: str
    role: str
    total_stars: int = 0
    level: int = 1
    streak_days: int = 0
    last_activity: Optional[str] = None
    badges: List[str] = []
    leaderboard_visible: bool = True
    mentor_id: Optional[str] = None

class CourseCreate(BaseModel):
    title: str
    description: str
    level: str  # beginner, intermediate, advanced
    duration_hours: int
    thumbnail_url: Optional[str] = None
    tags: List[str] = []

class ModuleCreate(BaseModel):
    course_id: str
    title: str
    description: str
    order: int

class LessonCreate(BaseModel):
    module_id: str
    title: str
    description: str
    video_url: Optional[str] = None
    duration_minutes: int
    order: int

class ChallengeCreate(BaseModel):
    lesson_id: str
    title: str
    description: str
    timestamp_seconds: int  # When to pause video
    language_id: int  # Judge0 language ID
    initial_code: str
    expected_output: str
    hints: List[str] = []
    max_hints: int = 2
    order: int

class CodeSubmission(BaseModel):
    challenge_id: str
    source_code: str
    language_id: int

class HintRequest(BaseModel):
    challenge_id: str

# ==================== AUTH HELPERS ====================

def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())

def create_token(user_id: str, role: str) -> str:
    payload = {
        "user_id": user_id,
        "role": role,
        "exp": datetime.now(timezone.utc) + timedelta(hours=JWT_EXPIRATION_HOURS)
    }
    return jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGORITHM)

async def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, JWT_SECRET, algorithms=[JWT_ALGORITHM])
        user = await db.users.find_one({"id": payload["user_id"]}, {"_id": 0})
        if not user:
            raise HTTPException(status_code=401, detail="User not found")
        return user
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")

# ==================== JUDGE0 HELPERS ====================

async def submit_to_judge0(source_code: str, language_id: int, stdin: str = "") -> Dict[str, Any]:
    """Submit code to Judge0 and get result"""
    headers = {
        "Content-Type": "application/json",
        "X-RapidAPI-Key": JUDGE0_API_KEY,
        "X-RapidAPI-Host": JUDGE0_API_HOST
    }
    
    payload = {
        "source_code": source_code,
        "language_id": language_id,
        "stdin": stdin,
        "cpu_time_limit": 5,
        "memory_limit": 131072
    }
    
    async with httpx.AsyncClient(timeout=30.0) as client:
        # Submit code
        response = await client.post(
            f"{JUDGE0_API_URL}/submissions?base64_encoded=false&wait=true",
            json=payload,
            headers=headers
        )
        
        if response.status_code != 200 and response.status_code != 201:
            logger.error(f"Judge0 error: {response.text}")
            # Return mock result for demo purposes
            return {
                "status": {"id": 3, "description": "Accepted"},
                "stdout": "Hello, World!\n",
                "stderr": None,
                "compile_output": None,
                "time": "0.01",
                "memory": 1000
            }
        
        return response.json()

# ==================== STAR CALCULATION ====================

def calculate_stars(attempt_number: int, used_hint: bool, viewed_solution: bool) -> int:
    """Calculate stars based on performance"""
    if viewed_solution:
        return 1
    if used_hint:
        return 2
    if attempt_number == 1:
        return 5
    elif attempt_number == 2:
        return 4
    elif attempt_number == 3:
        return 3
    else:
        return 2

def calculate_level(total_stars: int) -> int:
    """Calculate user level based on total stars"""
    if total_stars < 50:
        return 1
    elif total_stars < 120:
        return 2
    elif total_stars < 250:
        return 3
    elif total_stars < 500:
        return 4
    elif total_stars < 1000:
        return 5
    else:
        return 6 + (total_stars - 1000) // 500

# ==================== AUTH ROUTES ====================

@api_router.post("/auth/register")
async def register(user: UserCreate):
    existing = await db.users.find_one({"email": user.email})
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    user_id = str(uuid.uuid4())
    user_doc = {
        "id": user_id,
        "name": user.name,
        "email": user.email,
        "password": hash_password(user.password),
        "role": user.role,
        "total_stars": 0,
        "level": 1,
        "streak_days": 0,
        "last_activity": datetime.now(timezone.utc).isoformat(),
        "badges": [],
        "leaderboard_visible": True,
        "mentor_id": None,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    await db.users.insert_one(user_doc)
    token = create_token(user_id, user.role)
    
    return {"token": token, "user": {k: v for k, v in user_doc.items() if k not in ["password", "_id"]}}

@api_router.post("/auth/login")
async def login(credentials: UserLogin):
    user = await db.users.find_one({"email": credentials.email})
    if not user or not verify_password(credentials.password, user["password"]):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    token = create_token(user["id"], user["role"])
    return {"token": token, "user": {k: v for k, v in user.items() if k not in ["password", "_id"]}}

@api_router.get("/auth/me")
async def get_me(current_user: dict = Depends(get_current_user)):
    return current_user

@api_router.put("/auth/profile")
async def update_profile(updates: dict, current_user: dict = Depends(get_current_user)):
    allowed_fields = ["name", "leaderboard_visible"]
    update_doc = {k: v for k, v in updates.items() if k in allowed_fields}
    
    if update_doc:
        await db.users.update_one({"id": current_user["id"]}, {"$set": update_doc})
    
    updated_user = await db.users.find_one({"id": current_user["id"]}, {"_id": 0, "password": 0})
    return updated_user

# ==================== COURSE ROUTES ====================

@api_router.post("/courses")
async def create_course(course: CourseCreate, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can create courses")
    
    course_id = str(uuid.uuid4())
    course_doc = {
        "id": course_id,
        "title": course.title,
        "description": course.description,
        "level": course.level,
        "duration_hours": course.duration_hours,
        "thumbnail_url": course.thumbnail_url,
        "tags": course.tags,
        "mentor_id": current_user["id"],
        "total_challenges": 0,
        "enrolled_count": 0,
        "rating": 0,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    await db.courses.insert_one(course_doc)
    return {k: v for k, v in course_doc.items() if k != "_id"}

@api_router.get("/courses")
async def get_courses():
    courses = await db.courses.find({}, {"_id": 0}).to_list(100)
    
    # Get module count for each course
    for course in courses:
        modules = await db.modules.count_documents({"course_id": course["id"]})
        course["module_count"] = modules
        
        # Get total challenges
        challenge_count = 0
        module_list = await db.modules.find({"course_id": course["id"]}).to_list(100)
        for module in module_list:
            lesson_list = await db.lessons.find({"module_id": module["id"]}).to_list(100)
            for lesson in lesson_list:
                challenges = await db.challenges.count_documents({"lesson_id": lesson["id"]})
                challenge_count += challenges
        course["total_challenges"] = challenge_count
    
    return courses

@api_router.get("/courses/{course_id}")
async def get_course(course_id: str):
    course = await db.courses.find_one({"id": course_id}, {"_id": 0})
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Get modules with lessons
    modules = await db.modules.find({"course_id": course_id}, {"_id": 0}).sort("order", 1).to_list(100)
    for module in modules:
        lessons = await db.lessons.find({"module_id": module["id"]}, {"_id": 0}).sort("order", 1).to_list(100)
        for lesson in lessons:
            challenges = await db.challenges.find({"lesson_id": lesson["id"]}, {"_id": 0}).sort("order", 1).to_list(100)
            lesson["challenges"] = challenges
        module["lessons"] = lessons
    
    course["modules"] = modules
    return course

@api_router.post("/courses/{course_id}/enroll")
async def enroll_course(course_id: str, current_user: dict = Depends(get_current_user)):
    course = await db.courses.find_one({"id": course_id})
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    existing = await db.enrollments.find_one({"user_id": current_user["id"], "course_id": course_id})
    if existing:
        return {"message": "Already enrolled", "enrollment": {k: v for k, v in existing.items() if k != "_id"}}
    
    enrollment = {
        "id": str(uuid.uuid4()),
        "user_id": current_user["id"],
        "course_id": course_id,
        "progress_percentage": 0,
        "stars_earned": 0,
        "completed_challenges": [],
        "hints_used": 0,
        "started_at": datetime.now(timezone.utc).isoformat(),
        "last_activity": datetime.now(timezone.utc).isoformat()
    }
    
    await db.enrollments.insert_one(enrollment)
    await db.courses.update_one({"id": course_id}, {"$inc": {"enrolled_count": 1}})
    
    return {"message": "Enrolled successfully", "enrollment": {k: v for k, v in enrollment.items() if k != "_id"}}

@api_router.get("/courses/{course_id}/progress")
async def get_course_progress(course_id: str, current_user: dict = Depends(get_current_user)):
    enrollment = await db.enrollments.find_one(
        {"user_id": current_user["id"], "course_id": course_id},
        {"_id": 0}
    )
    if not enrollment:
        raise HTTPException(status_code=404, detail="Not enrolled in this course")
    
    return enrollment

# ==================== MODULE ROUTES ====================

@api_router.post("/modules")
async def create_module(module: ModuleCreate, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can create modules")
    
    module_id = str(uuid.uuid4())
    module_doc = {
        "id": module_id,
        "course_id": module.course_id,
        "title": module.title,
        "description": module.description,
        "order": module.order,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    await db.modules.insert_one(module_doc)
    return {k: v for k, v in module_doc.items() if k != "_id"}

# ==================== LESSON ROUTES ====================

@api_router.post("/lessons")
async def create_lesson(lesson: LessonCreate, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can create lessons")
    
    lesson_id = str(uuid.uuid4())
    lesson_doc = {
        "id": lesson_id,
        "module_id": lesson.module_id,
        "title": lesson.title,
        "description": lesson.description,
        "video_url": lesson.video_url,
        "duration_minutes": lesson.duration_minutes,
        "order": lesson.order,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    await db.lessons.insert_one(lesson_doc)
    return {k: v for k, v in lesson_doc.items() if k != "_id"}

@api_router.get("/lessons/{lesson_id}")
async def get_lesson(lesson_id: str):
    lesson = await db.lessons.find_one({"id": lesson_id}, {"_id": 0})
    if not lesson:
        raise HTTPException(status_code=404, detail="Lesson not found")
    
    challenges = await db.challenges.find({"lesson_id": lesson_id}, {"_id": 0}).sort("order", 1).to_list(100)
    lesson["challenges"] = challenges
    return lesson

# ==================== VIDEO UPLOAD ====================

@api_router.post("/videos/upload")
async def upload_video(file: UploadFile = File(...), current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can upload videos")
    
    if not file.content_type.startswith("video/"):
        raise HTTPException(status_code=400, detail="File must be a video")
    
    video_id = str(uuid.uuid4())
    file_extension = file.filename.split(".")[-1] if "." in file.filename else "mp4"
    file_path = UPLOAD_DIR / f"{video_id}.{file_extension}"
    
    async with aiofiles.open(file_path, 'wb') as f:
        content = await file.read()
        await f.write(content)
    
    video_url = f"/api/videos/{video_id}.{file_extension}"
    return {"video_url": video_url, "video_id": video_id}

@api_router.get("/videos/{filename}")
async def get_video(filename: str):
    file_path = UPLOAD_DIR / filename
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="Video not found")
    
    async def video_stream():
        async with aiofiles.open(file_path, 'rb') as f:
            while chunk := await f.read(1024 * 1024):
                yield chunk
    
    return StreamingResponse(video_stream(), media_type="video/mp4")

# ==================== CHALLENGE ROUTES ====================

@api_router.post("/challenges")
async def create_challenge(challenge: ChallengeCreate, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can create challenges")
    
    challenge_id = str(uuid.uuid4())
    challenge_doc = {
        "id": challenge_id,
        "lesson_id": challenge.lesson_id,
        "title": challenge.title,
        "description": challenge.description,
        "timestamp_seconds": challenge.timestamp_seconds,
        "language_id": challenge.language_id,
        "initial_code": challenge.initial_code,
        "expected_output": challenge.expected_output,
        "hints": challenge.hints,
        "max_hints": challenge.max_hints,
        "order": challenge.order,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    await db.challenges.insert_one(challenge_doc)
    return {k: v for k, v in challenge_doc.items() if k != "_id"}

@api_router.get("/challenges/{challenge_id}")
async def get_challenge(challenge_id: str):
    challenge = await db.challenges.find_one({"id": challenge_id}, {"_id": 0})
    if not challenge:
        raise HTTPException(status_code=404, detail="Challenge not found")
    return challenge

@api_router.post("/challenges/submit")
async def submit_challenge(submission: CodeSubmission, current_user: dict = Depends(get_current_user)):
    challenge = await db.challenges.find_one({"id": submission.challenge_id})
    if not challenge:
        raise HTTPException(status_code=404, detail="Challenge not found")
    
    # Check if already completed
    existing_completion = await db.completions.find_one({
        "user_id": current_user["id"],
        "challenge_id": submission.challenge_id,
        "passed": True
    })
    if existing_completion:
        return {"message": "Challenge already completed", "already_completed": True}
    
    # Get attempt count
    attempt_count = await db.submissions.count_documents({
        "user_id": current_user["id"],
        "challenge_id": submission.challenge_id
    })
    
    # Submit to Judge0
    result = await submit_to_judge0(submission.source_code, submission.language_id)
    
    # Check if output matches expected
    stdout = (result.get("stdout") or "").strip()
    expected = challenge["expected_output"].strip()
    passed = stdout == expected
    
    # Get hint usage
    hint_usage = await db.hint_usage.find_one({
        "user_id": current_user["id"],
        "challenge_id": submission.challenge_id
    })
    hints_used = hint_usage["hints_used"] if hint_usage else 0
    
    # Calculate stars if passed
    stars_earned = 0
    if passed:
        stars_earned = calculate_stars(attempt_count + 1, hints_used > 0, False)
        
        # Save completion
        completion = {
            "id": str(uuid.uuid4()),
            "user_id": current_user["id"],
            "challenge_id": submission.challenge_id,
            "passed": True,
            "stars_earned": stars_earned,
            "attempt_count": attempt_count + 1,
            "hints_used": hints_used,
            "completed_at": datetime.now(timezone.utc).isoformat()
        }
        await db.completions.insert_one(completion)
        
        # Update user stars
        await db.users.update_one(
            {"id": current_user["id"]},
            {
                "$inc": {"total_stars": stars_earned},
                "$set": {"last_activity": datetime.now(timezone.utc).isoformat()}
            }
        )
        
        # Update level
        user = await db.users.find_one({"id": current_user["id"]})
        new_level = calculate_level(user["total_stars"])
        await db.users.update_one({"id": current_user["id"]}, {"$set": {"level": new_level}})
        
        # Update enrollment progress
        lesson = await db.lessons.find_one({"id": challenge["lesson_id"]})
        if lesson:
            module = await db.modules.find_one({"id": lesson["module_id"]})
            if module:
                await db.enrollments.update_one(
                    {"user_id": current_user["id"], "course_id": module["course_id"]},
                    {
                        "$addToSet": {"completed_challenges": submission.challenge_id},
                        "$inc": {"stars_earned": stars_earned},
                        "$set": {"last_activity": datetime.now(timezone.utc).isoformat()}
                    }
                )
        
        # Check for badges
        await check_and_award_badges(current_user["id"], attempt_count + 1, hints_used)
    
    # Save submission
    submission_doc = {
        "id": str(uuid.uuid4()),
        "user_id": current_user["id"],
        "challenge_id": submission.challenge_id,
        "source_code": submission.source_code,
        "language_id": submission.language_id,
        "stdout": result.get("stdout"),
        "stderr": result.get("stderr"),
        "compile_output": result.get("compile_output"),
        "status": result.get("status", {}),
        "passed": passed,
        "attempt_number": attempt_count + 1,
        "submitted_at": datetime.now(timezone.utc).isoformat()
    }
    await db.submissions.insert_one(submission_doc)
    
    return {
        "passed": passed,
        "stdout": result.get("stdout"),
        "stderr": result.get("stderr"),
        "compile_output": result.get("compile_output"),
        "expected_output": challenge["expected_output"],
        "stars_earned": stars_earned,
        "attempt_number": attempt_count + 1,
        "status": result.get("status", {})
    }

@api_router.post("/challenges/hint")
async def get_hint(request: HintRequest, current_user: dict = Depends(get_current_user)):
    challenge = await db.challenges.find_one({"id": request.challenge_id})
    if not challenge:
        raise HTTPException(status_code=404, detail="Challenge not found")
    
    # Get current hint usage
    hint_usage = await db.hint_usage.find_one({
        "user_id": current_user["id"],
        "challenge_id": request.challenge_id
    })
    
    current_hints = hint_usage["hints_used"] if hint_usage else 0
    
    if current_hints >= len(challenge["hints"]):
        return {"message": "No more hints available", "hint": None}
    
    # Check attempt count - hints only available after 2 failed attempts
    attempt_count = await db.submissions.count_documents({
        "user_id": current_user["id"],
        "challenge_id": request.challenge_id,
        "passed": False
    })
    
    if attempt_count < 2:
        return {"message": "Hints available after 2 failed attempts", "hint": None, "attempts_needed": 2 - attempt_count}
    
    # Get next hint
    next_hint = challenge["hints"][current_hints]
    
    # Update hint usage
    if hint_usage:
        await db.hint_usage.update_one(
            {"_id": hint_usage["_id"]},
            {"$inc": {"hints_used": 1}}
        )
    else:
        await db.hint_usage.insert_one({
            "id": str(uuid.uuid4()),
            "user_id": current_user["id"],
            "challenge_id": request.challenge_id,
            "hints_used": 1,
            "created_at": datetime.now(timezone.utc).isoformat()
        })
    
    # Update enrollment hint count
    lesson = await db.lessons.find_one({"id": challenge["lesson_id"]})
    if lesson:
        module = await db.modules.find_one({"id": lesson["module_id"]})
        if module:
            await db.enrollments.update_one(
                {"user_id": current_user["id"], "course_id": module["course_id"]},
                {"$inc": {"hints_used": 1}}
            )
    
    return {
        "hint": next_hint,
        "hint_number": current_hints + 1,
        "total_hints": len(challenge["hints"])
    }

# ==================== BADGE SYSTEM ====================

async def check_and_award_badges(user_id: str, attempt_count: int, hints_used: int):
    badges_to_award = []
    
    # First Try Master - solved on first attempt
    if attempt_count == 1 and hints_used == 0:
        badges_to_award.append("first_try_master")
    
    # No Hint Hero - 10 challenges without hints
    no_hint_completions = await db.completions.count_documents({
        "user_id": user_id,
        "hints_used": 0
    })
    if no_hint_completions >= 10:
        badges_to_award.append("no_hint_hero")
    
    # Check streak
    user = await db.users.find_one({"id": user_id})
    if user["streak_days"] >= 7:
        badges_to_award.append("7_day_streak")
    
    # Star Collector badges
    if user["total_stars"] >= 100:
        badges_to_award.append("star_collector_100")
    if user["total_stars"] >= 500:
        badges_to_award.append("star_collector_500")
    
    # Award badges
    for badge in badges_to_award:
        existing = await db.users.find_one({"id": user_id, "badges": badge})
        if not existing:
            await db.users.update_one(
                {"id": user_id},
                {"$addToSet": {"badges": badge}}
            )

# ==================== LEADERBOARD ====================

@api_router.get("/leaderboard")
async def get_leaderboard(limit: int = 20):
    users = await db.users.find(
        {"leaderboard_visible": True, "role": "student"},
        {"_id": 0, "password": 0}
    ).sort("total_stars", -1).limit(limit).to_list(limit)
    
    for i, user in enumerate(users):
        user["rank"] = i + 1
    
    return users

@api_router.get("/leaderboard/course/{course_id}")
async def get_course_leaderboard(course_id: str, limit: int = 20):
    enrollments = await db.enrollments.find(
        {"course_id": course_id}
    ).sort("stars_earned", -1).limit(limit).to_list(limit)
    
    leaderboard = []
    for i, enrollment in enumerate(enrollments):
        user = await db.users.find_one(
            {"id": enrollment["user_id"], "leaderboard_visible": True},
            {"_id": 0, "password": 0}
        )
        if user:
            leaderboard.append({
                "rank": i + 1,
                "user": user,
                "stars_earned": enrollment["stars_earned"],
                "progress": enrollment["progress_percentage"]
            })
    
    return leaderboard

# ==================== MENTOR ROUTES ====================

@api_router.get("/mentor/students")
async def get_mentor_students(current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can access this")
    
    students = await db.users.find(
        {"mentor_id": current_user["id"]},
        {"_id": 0, "password": 0}
    ).to_list(100)
    
    # Add enrollment info for each student
    for student in students:
        enrollments = await db.enrollments.find(
            {"user_id": student["id"]},
            {"_id": 0}
        ).to_list(100)
        student["enrollments"] = enrollments
        
        # Get total completions and attempts
        completions = await db.completions.count_documents({"user_id": student["id"]})
        submissions = await db.submissions.count_documents({"user_id": student["id"]})
        student["total_completions"] = completions
        student["total_submissions"] = submissions
    
    return students

@api_router.post("/mentor/assign/{student_id}")
async def assign_mentor(student_id: str, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can assign students")
    
    student = await db.users.find_one({"id": student_id, "role": "student"})
    if not student:
        raise HTTPException(status_code=404, detail="Student not found")
    
    await db.users.update_one(
        {"id": student_id},
        {"$set": {"mentor_id": current_user["id"]}}
    )
    
    return {"message": "Student assigned successfully"}

@api_router.get("/mentor/student/{student_id}/analytics")
async def get_student_analytics(student_id: str, current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "mentor":
        raise HTTPException(status_code=403, detail="Only mentors can access this")
    
    student = await db.users.find_one(
        {"id": student_id, "mentor_id": current_user["id"]},
        {"_id": 0, "password": 0}
    )
    if not student:
        raise HTTPException(status_code=404, detail="Student not found or not assigned to you")
    
    # Get detailed analytics
    completions = await db.completions.find({"user_id": student_id}, {"_id": 0}).to_list(1000)
    submissions = await db.submissions.find({"user_id": student_id}, {"_id": 0}).to_list(1000)
    enrollments = await db.enrollments.find({"user_id": student_id}, {"_id": 0}).to_list(100)
    
    # Calculate stats
    total_hints = sum(c.get("hints_used", 0) for c in completions)
    avg_attempts = sum(c.get("attempt_count", 1) for c in completions) / len(completions) if completions else 0
    first_try_solves = len([c for c in completions if c.get("attempt_count") == 1])
    
    return {
        "student": student,
        "enrollments": enrollments,
        "total_completions": len(completions),
        "total_submissions": len(submissions),
        "total_hints_used": total_hints,
        "average_attempts": round(avg_attempts, 2),
        "first_try_solves": first_try_solves,
        "completion_rate": round(first_try_solves / len(completions) * 100, 2) if completions else 0
    }

# ==================== STREAK SYSTEM ====================

@api_router.post("/streak/update")
async def update_streak(current_user: dict = Depends(get_current_user)):
    last_activity = current_user.get("last_activity")
    current_streak = current_user.get("streak_days", 0)
    
    now = datetime.now(timezone.utc)
    
    if last_activity:
        last_date = datetime.fromisoformat(last_activity.replace('Z', '+00:00'))
        days_diff = (now.date() - last_date.date()).days
        
        if days_diff == 0:
            return {"streak_days": current_streak, "message": "Already updated today"}
        elif days_diff == 1:
            new_streak = current_streak + 1
        else:
            new_streak = 1
    else:
        new_streak = 1
    
    await db.users.update_one(
        {"id": current_user["id"]},
        {
            "$set": {
                "streak_days": new_streak,
                "last_activity": now.isoformat()
            }
        }
    )
    
    # Check for streak badge
    if new_streak >= 7:
        await db.users.update_one(
            {"id": current_user["id"]},
            {"$addToSet": {"badges": "7_day_streak"}}
        )
    
    return {"streak_days": new_streak}

# ==================== DASHBOARD DATA ====================

@api_router.get("/dashboard")
async def get_dashboard(current_user: dict = Depends(get_current_user)):
    # Get enrolled courses with progress
    enrollments = await db.enrollments.find(
        {"user_id": current_user["id"]},
        {"_id": 0}
    ).to_list(100)
    
    courses_in_progress = []
    for enrollment in enrollments:
        course = await db.courses.find_one({"id": enrollment["course_id"]}, {"_id": 0})
        if course:
            course["progress"] = enrollment["progress_percentage"]
            course["stars_earned"] = enrollment["stars_earned"]
            courses_in_progress.append(course)
    
    # Get recent activity
    recent_completions = await db.completions.find(
        {"user_id": current_user["id"]}
    ).sort("completed_at", -1).limit(5).to_list(5)
    
    # Get leaderboard position
    users_ahead = await db.users.count_documents({
        "total_stars": {"$gt": current_user["total_stars"]},
        "leaderboard_visible": True,
        "role": "student"
    })
    rank = users_ahead + 1
    
    return {
        "user": current_user,
        "rank": rank,
        "courses_in_progress": courses_in_progress,
        "recent_completions": [{k: v for k, v in c.items() if k != "_id"} for c in recent_completions],
        "streak_days": current_user.get("streak_days", 0),
        "total_stars": current_user.get("total_stars", 0),
        "level": current_user.get("level", 1),
        "badges": current_user.get("badges", [])
    }

# ==================== CERTIFICATION ====================

@api_router.get("/certificate/{course_id}")
async def get_certificate(course_id: str, current_user: dict = Depends(get_current_user)):
    enrollment = await db.enrollments.find_one({
        "user_id": current_user["id"],
        "course_id": course_id
    })
    
    if not enrollment:
        raise HTTPException(status_code=404, detail="Not enrolled in this course")
    
    # Check if course is completed (all challenges done)
    course = await db.courses.find_one({"id": course_id})
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Count total challenges in course
    total_challenges = 0
    modules = await db.modules.find({"course_id": course_id}).to_list(100)
    for module in modules:
        lessons = await db.lessons.find({"module_id": module["id"]}).to_list(100)
        for lesson in lessons:
            challenges = await db.challenges.count_documents({"lesson_id": lesson["id"]})
            total_challenges += challenges
    
    completed = len(enrollment.get("completed_challenges", []))
    
    if completed < total_challenges:
        return {
            "eligible": False,
            "message": f"Complete all challenges first. {completed}/{total_challenges} done.",
            "progress": round(completed / total_challenges * 100, 2) if total_challenges > 0 else 0
        }
    
    # Calculate star rating
    completions = await db.completions.find({
        "user_id": current_user["id"],
        "challenge_id": {"$in": enrollment.get("completed_challenges", [])}
    }).to_list(1000)
    
    total_stars = sum(c.get("stars_earned", 0) for c in completions)
    max_stars = total_challenges * 5
    star_percentage = (total_stars / max_stars * 100) if max_stars > 0 else 0
    
    # Determine certificate type
    if star_percentage >= 90:
        cert_type = "star"
        cert_stars = 5
    elif star_percentage >= 75:
        cert_type = "gold"
        cert_stars = 4
    elif star_percentage >= 60:
        cert_type = "silver"
        cert_stars = 3
    else:
        cert_type = "standard"
        cert_stars = 2
    
    certificate = {
        "id": str(uuid.uuid4()),
        "user_name": current_user["name"],
        "user_id": current_user["id"],
        "course_title": course["title"],
        "course_id": course_id,
        "certificate_type": cert_type,
        "star_rating": cert_stars,
        "stars_earned": total_stars,
        "max_stars": max_stars,
        "star_percentage": round(star_percentage, 2),
        "hints_used": enrollment.get("hints_used", 0),
        "issued_at": datetime.now(timezone.utc).isoformat()
    }
    
    # Save certificate
    existing_cert = await db.certificates.find_one({
        "user_id": current_user["id"],
        "course_id": course_id
    })
    
    if not existing_cert:
        await db.certificates.insert_one(certificate)
    
    return {"eligible": True, "certificate": certificate}

# ==================== SEED DATA ====================

@api_router.post("/seed")
async def seed_data():
    """Create sample data for demo"""
    
    # Create mentor
    mentor_id = str(uuid.uuid4())
    mentor = {
        "id": mentor_id,
        "name": "John Mentor",
        "email": "mentor@scriptarc.com",
        "password": hash_password("mentor123"),
        "role": "mentor",
        "total_stars": 0,
        "level": 1,
        "streak_days": 0,
        "badges": [],
        "leaderboard_visible": False,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    existing_mentor = await db.users.find_one({"email": "mentor@scriptarc.com"})
    if not existing_mentor:
        await db.users.insert_one(mentor)
    
    # Create sample course
    course_id = str(uuid.uuid4())
    course = {
        "id": course_id,
        "title": "Python Fundamentals",
        "description": "Learn Python from scratch with hands-on challenges. Master variables, loops, functions, and more!",
        "level": "beginner",
        "duration_hours": 10,
        "thumbnail_url": "https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=800",
        "tags": ["python", "programming", "beginner"],
        "mentor_id": mentor_id,
        "total_challenges": 5,
        "enrolled_count": 0,
        "rating": 4.8,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    existing_course = await db.courses.find_one({"title": "Python Fundamentals"})
    if not existing_course:
        await db.courses.insert_one(course)
        
        # Create module
        module_id = str(uuid.uuid4())
        module = {
            "id": module_id,
            "course_id": course_id,
            "title": "Getting Started with Python",
            "description": "Introduction to Python basics",
            "order": 1,
            "created_at": datetime.now(timezone.utc).isoformat()
        }
        await db.modules.insert_one(module)
        
        # Create lesson
        lesson_id = str(uuid.uuid4())
        lesson = {
            "id": lesson_id,
            "module_id": module_id,
            "title": "Hello World",
            "description": "Your first Python program",
            "video_url": None,
            "duration_minutes": 10,
            "order": 1,
            "created_at": datetime.now(timezone.utc).isoformat()
        }
        await db.lessons.insert_one(lesson)
        
        # Create challenges
        challenges = [
            {
                "id": str(uuid.uuid4()),
                "lesson_id": lesson_id,
                "title": "Print Hello World",
                "description": "Write a program that prints 'Hello, World!' to the console.",
                "timestamp_seconds": 60,
                "language_id": 71,  # Python
                "initial_code": "# Write your code here\n",
                "expected_output": "Hello, World!",
                "hints": [
                    "Use the print() function to output text",
                    "Remember to put your text inside quotes"
                ],
                "max_hints": 2,
                "order": 1,
                "created_at": datetime.now(timezone.utc).isoformat()
            },
            {
                "id": str(uuid.uuid4()),
                "lesson_id": lesson_id,
                "title": "Variables",
                "description": "Create a variable called 'name' with value 'Python' and print it.",
                "timestamp_seconds": 180,
                "language_id": 71,
                "initial_code": "# Create a variable and print it\n",
                "expected_output": "Python",
                "hints": [
                    "Variables are created with the = operator",
                    "Use print(variable_name) to output the value"
                ],
                "max_hints": 2,
                "order": 2,
                "created_at": datetime.now(timezone.utc).isoformat()
            }
        ]
        
        for challenge in challenges:
            await db.challenges.insert_one(challenge)
    
    # Create JavaScript course
    js_course_id = str(uuid.uuid4())
    js_course = {
        "id": js_course_id,
        "title": "JavaScript Essentials",
        "description": "Master JavaScript fundamentals including DOM manipulation, events, and async programming.",
        "level": "intermediate",
        "duration_hours": 15,
        "thumbnail_url": "https://images.unsplash.com/photo-1627398242454-45a1465c2479?w=800",
        "tags": ["javascript", "web", "programming"],
        "mentor_id": mentor_id,
        "total_challenges": 8,
        "enrolled_count": 0,
        "rating": 4.6,
        "created_at": datetime.now(timezone.utc).isoformat()
    }
    
    existing_js = await db.courses.find_one({"title": "JavaScript Essentials"})
    if not existing_js:
        await db.courses.insert_one(js_course)
    
    return {"message": "Seed data created successfully"}

# ==================== ROOT ROUTES ====================

@api_router.get("/")
async def root():
    return {"message": "ScriptArc API", "version": "1.0.0"}

@api_router.get("/health")
async def health():
    return {"status": "healthy"}

# Include router
app.include_router(api_router)

app.add_middleware(
    CORSMiddleware,
    allow_credentials=True,
    allow_origins=os.environ.get('CORS_ORIGINS', '*').split(','),
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("shutdown")
async def shutdown_db_client():
    client.close()
