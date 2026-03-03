import requests
import sys
import json
from datetime import datetime

class ScriptArcAPITester:
    def __init__(self, base_url="https://mentor-guided-code.preview.emergentagent.com"):
        self.base_url = base_url
        self.token = None
        self.user_id = None
        self.tests_run = 0
        self.tests_passed = 0
        self.failed_tests = []

    def log_result(self, test_name, success, expected_status=None, actual_status=None, error=None):
        """Log test results"""
        self.tests_run += 1
        status = "✅ PASS" if success else "❌ FAIL"
        print(f"{status} - {test_name}")
        
        if success:
            self.tests_passed += 1
        else:
            failure_info = {
                "test": test_name,
                "expected_status": expected_status,
                "actual_status": actual_status,
                "error": str(error) if error else None
            }
            self.failed_tests.append(failure_info)
            if expected_status and actual_status:
                print(f"    Expected: {expected_status}, Got: {actual_status}")
            if error:
                print(f"    Error: {error}")

    def make_request(self, method, endpoint, expected_status=200, data=None, headers=None):
        """Make HTTP request with error handling"""
        url = f"{self.base_url}/api/{endpoint}"
        
        request_headers = {'Content-Type': 'application/json'}
        if self.token:
            request_headers['Authorization'] = f'Bearer {self.token}'
        if headers:
            request_headers.update(headers)

        try:
            if method == 'GET':
                response = requests.get(url, headers=request_headers, timeout=30)
            elif method == 'POST':
                response = requests.post(url, json=data, headers=request_headers, timeout=30)
            elif method == 'PUT':
                response = requests.put(url, json=data, headers=request_headers, timeout=30)
            elif method == 'DELETE':
                response = requests.delete(url, headers=request_headers, timeout=30)
            
            success = response.status_code == expected_status
            return success, response
            
        except Exception as e:
            return False, None

    def test_health_endpoint(self):
        """Test basic health endpoint"""
        print("\n🏥 Testing Health Endpoints...")
        
        # Test root endpoint
        success, response = self.make_request('GET', '', 200)
        self.log_result("Root endpoint (/api/)", success, 200, 
                       response.status_code if response else None)
        
        # Test health endpoint
        success, response = self.make_request('GET', 'health', 200)
        self.log_result("Health endpoint (/api/health)", success, 200, 
                       response.status_code if response else None)

    def test_user_registration(self):
        """Test user registration flow"""
        print("\n👤 Testing User Registration...")
        
        # Create unique test user
        timestamp = datetime.now().strftime('%H%M%S')
        test_user = {
            "name": f"Test User {timestamp}",
            "email": f"test{timestamp}@scriptarc.com",
            "password": "testpass123",
            "role": "student"
        }
        
        success, response = self.make_request('POST', 'auth/register', 200, test_user)
        
        if success and response:
            try:
                data = response.json()
                if 'token' in data and 'user' in data:
                    self.token = data['token']
                    self.user_id = data['user']['id']
                    self.test_user_email = test_user['email']
                    self.test_user_password = test_user['password']
                    self.log_result("User registration", True)
                else:
                    self.log_result("User registration", False, error="Missing token or user in response")
            except Exception as e:
                self.log_result("User registration", False, error=f"JSON parsing error: {e}")
        else:
            self.log_result("User registration", success, 200, 
                           response.status_code if response else None)

    def test_duplicate_registration(self):
        """Test duplicate email registration"""
        print("\n🚫 Testing Duplicate Registration...")
        
        if hasattr(self, 'test_user_email'):
            duplicate_user = {
                "name": "Another User",
                "email": self.test_user_email,
                "password": "anotherpass123",
                "role": "student"
            }
            
            success, response = self.make_request('POST', 'auth/register', 400, duplicate_user)
            self.log_result("Duplicate email registration (should fail)", success, 400, 
                           response.status_code if response else None)
        else:
            self.log_result("Duplicate email registration", False, error="No test user email available")

    def test_user_login(self):
        """Test user login flow"""
        print("\n🔐 Testing User Login...")
        
        if hasattr(self, 'test_user_email') and hasattr(self, 'test_user_password'):
            login_data = {
                "email": self.test_user_email,
                "password": self.test_user_password
            }
            
            success, response = self.make_request('POST', 'auth/login', 200, login_data)
            
            if success and response:
                try:
                    data = response.json()
                    if 'token' in data:
                        self.token = data['token']  # Update token
                        self.log_result("User login", True)
                    else:
                        self.log_result("User login", False, error="Missing token in response")
                except Exception as e:
                    self.log_result("User login", False, error=f"JSON parsing error: {e}")
            else:
                self.log_result("User login", success, 200, 
                               response.status_code if response else None)
        else:
            self.log_result("User login", False, error="No test user credentials available")

    def test_invalid_login(self):
        """Test login with invalid credentials"""
        print("\n🔒 Testing Invalid Login...")
        
        invalid_login = {
            "email": "nonexistent@example.com",
            "password": "wrongpassword"
        }
        
        success, response = self.make_request('POST', 'auth/login', 401, invalid_login)
        self.log_result("Invalid login (should fail)", success, 401, 
                       response.status_code if response else None)

    def test_get_current_user(self):
        """Test get current user endpoint"""
        print("\n👤 Testing Get Current User...")
        
        if not self.token:
            self.log_result("Get current user", False, error="No auth token available")
            return
        
        success, response = self.make_request('GET', 'auth/me', 200)
        self.log_result("Get current user (/api/auth/me)", success, 200, 
                       response.status_code if response else None)

    def test_seed_data(self):
        """Test seed data creation"""
        print("\n🌱 Testing Seed Data...")
        
        success, response = self.make_request('POST', 'seed', 200)
        self.log_result("Create seed data", success, 200, 
                       response.status_code if response else None)

    def test_get_courses(self):
        """Test get all courses"""
        print("\n📚 Testing Get Courses...")
        
        success, response = self.make_request('GET', 'courses', 200)
        
        if success and response:
            try:
                courses = response.json()
                if isinstance(courses, list):
                    self.log_result("Get courses", True)
                    print(f"    Found {len(courses)} courses")
                    if len(courses) > 0:
                        self.test_course_id = courses[0]['id']
                else:
                    self.log_result("Get courses", False, error="Response is not a list")
            except Exception as e:
                self.log_result("Get courses", False, error=f"JSON parsing error: {e}")
        else:
            self.log_result("Get courses", success, 200, 
                           response.status_code if response else None)

    def test_get_single_course(self):
        """Test get single course"""
        print("\n📖 Testing Get Single Course...")
        
        if hasattr(self, 'test_course_id'):
            success, response = self.make_request('GET', f'courses/{self.test_course_id}', 200)
            self.log_result("Get single course", success, 200, 
                           response.status_code if response else None)
        else:
            self.log_result("Get single course", False, error="No course ID available")

    def test_dashboard_data(self):
        """Test dashboard endpoint"""
        print("\n📊 Testing Dashboard...")
        
        if not self.token:
            self.log_result("Get dashboard", False, error="No auth token available")
            return
        
        success, response = self.make_request('GET', 'dashboard', 200)
        
        if success and response:
            try:
                data = response.json()
                required_fields = ['user', 'rank', 'courses_in_progress', 'recent_completions']
                missing_fields = [field for field in required_fields if field not in data]
                
                if not missing_fields:
                    self.log_result("Get dashboard data", True)
                    print(f"    User level: {data['user'].get('level', 1)}")
                    print(f"    Total stars: {data['user'].get('total_stars', 0)}")
                    print(f"    Rank: {data.get('rank', 'N/A')}")
                else:
                    self.log_result("Get dashboard data", False, 
                                   error=f"Missing fields: {missing_fields}")
            except Exception as e:
                self.log_result("Get dashboard data", False, error=f"JSON parsing error: {e}")
        else:
            self.log_result("Get dashboard data", success, 200, 
                           response.status_code if response else None)

    def test_leaderboard(self):
        """Test leaderboard endpoint"""
        print("\n🏆 Testing Leaderboard...")
        
        success, response = self.make_request('GET', 'leaderboard', 200)
        
        if success and response:
            try:
                leaderboard = response.json()
                if isinstance(leaderboard, list):
                    self.log_result("Get leaderboard", True)
                    print(f"    Found {len(leaderboard)} entries")
                else:
                    self.log_result("Get leaderboard", False, error="Response is not a list")
            except Exception as e:
                self.log_result("Get leaderboard", False, error=f"JSON parsing error: {e}")
        else:
            self.log_result("Get leaderboard", success, 200, 
                           response.status_code if response else None)

    def test_unauthorized_access(self):
        """Test endpoints without authentication"""
        print("\n🚫 Testing Unauthorized Access...")
        
        # Temporarily remove token
        original_token = self.token
        self.token = None
        
        # Test protected endpoints
        success, response = self.make_request('GET', 'dashboard', 403)
        self.log_result("Unauthorized access to dashboard", success, 403, 
                       response.status_code if response else None)
        
        success, response = self.make_request('GET', 'auth/me', 403)
        self.log_result("Unauthorized access to auth/me", success, 403, 
                       response.status_code if response else None)
        
        success, response = self.make_request('PUT', 'auth/profile', 403, {})
        self.log_result("Unauthorized access to auth/profile", success, 403, 
                       response.status_code if response else None)
        
        # Restore token
        self.token = original_token

    def run_all_tests(self):
        """Run all API tests"""
        print("🚀 Starting ScriptArc API Tests")
        print("=" * 50)
        
        # Run tests in order
        self.test_health_endpoint()
        self.test_user_registration()
        self.test_duplicate_registration()
        self.test_user_login()
        self.test_invalid_login()
        self.test_get_current_user()
        self.test_unauthorized_access()
        self.test_seed_data()
        self.test_get_courses()
        self.test_get_single_course()
        self.test_dashboard_data()
        self.test_leaderboard()
        
        # Print summary
        print("\n" + "=" * 50)
        print(f"📊 Test Summary: {self.tests_passed}/{self.tests_run} passed")
        
        if self.failed_tests:
            print(f"\n❌ Failed Tests ({len(self.failed_tests)}):")
            for failure in self.failed_tests:
                print(f"  - {failure['test']}")
                if failure['expected_status'] and failure['actual_status']:
                    print(f"    Expected: {failure['expected_status']}, Got: {failure['actual_status']}")
                if failure['error']:
                    print(f"    Error: {failure['error']}")
        
        # Return success status
        return self.tests_passed == self.tests_run

def main():
    print("🎯 ScriptArc Backend API Testing")
    print(f"Testing against: https://mentor-guided-code.preview.emergentagent.com")
    print("=" * 60)
    
    tester = ScriptArcAPITester()
    success = tester.run_all_tests()
    
    if success:
        print("\n🎉 All tests passed!")
        return 0
    else:
        print(f"\n💥 {len(tester.failed_tests)} test(s) failed!")
        return 1

if __name__ == "__main__":
    sys.exit(main())