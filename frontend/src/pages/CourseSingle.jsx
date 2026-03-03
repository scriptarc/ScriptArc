import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';
import { courseAPI } from '@/lib/api';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion';
import { toast } from 'sonner';
import { 
  Play, 
  Clock, 
  Star, 
  Code2, 
  ChevronRight, 
  CheckCircle,
  Lock,
  Users,
  Award,
  Loader2,
  ArrowLeft
} from 'lucide-react';

const levelColors = {
  beginner: 'bg-accent/20 text-accent border-accent/30',
  intermediate: 'bg-primary/20 text-primary border-primary/30',
  advanced: 'bg-secondary/20 text-secondary border-secondary/30',
};

const CourseSingle = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useAuth();
  const [course, setCourse] = useState(null);
  const [enrollment, setEnrollment] = useState(null);
  const [loading, setLoading] = useState(true);
  const [enrolling, setEnrolling] = useState(false);

  useEffect(() => {
    fetchCourse();
  }, [id]);

  const fetchCourse = async () => {
    try {
      const [courseRes, progressRes] = await Promise.all([
        courseAPI.getOne(id),
        courseAPI.getProgress(id).catch(() => null)
      ]);
      setCourse(courseRes.data);
      if (progressRes) {
        setEnrollment(progressRes.data);
      }
    } catch (error) {
      console.error('Failed to fetch course:', error);
      toast.error('Failed to load course');
    } finally {
      setLoading(false);
    }
  };

  const handleEnroll = async () => {
    if (!user) {
      navigate('/login');
      return;
    }

    setEnrolling(true);
    try {
      const response = await courseAPI.enroll(id);
      setEnrollment(response.data.enrollment);
      toast.success('Successfully enrolled!');
    } catch (error) {
      toast.error(error.response?.data?.detail || 'Failed to enroll');
    } finally {
      setEnrolling(false);
    }
  };

  const startLesson = (lessonId) => {
    if (!enrollment) {
      toast.error('Please enroll first');
      return;
    }
    navigate(`/learn/${lessonId}`);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!course) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-outfit text-white mb-4">Course not found</h2>
          <Button onClick={() => navigate('/courses')} className="btn-primary">
            Browse Courses
          </Button>
        </div>
      </div>
    );
  }

  const totalLessons = course.modules?.reduce((acc, m) => acc + (m.lessons?.length || 0), 0) || 0;
  const totalChallenges = course.modules?.reduce((acc, m) => 
    acc + (m.lessons?.reduce((a, l) => a + (l.challenges?.length || 0), 0) || 0), 0) || 0;

  return (
    <div className="min-h-screen bg-background pt-20 pb-12" data-testid="course-single-page">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Back Button */}
        <button 
          onClick={() => navigate('/courses')}
          className="flex items-center gap-2 text-text-secondary hover:text-white mb-6 transition-colors"
          data-testid="back-to-courses"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to courses
        </button>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Course Header */}
            <div className="relative rounded-md overflow-hidden">
              <img 
                src={course.thumbnail_url || 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=1200'} 
                alt={course.title}
                className="w-full h-64 object-cover"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-background via-background/50 to-transparent" />
              <div className="absolute bottom-0 left-0 right-0 p-6">
                <Badge className={`${levelColors[course.level]} border mb-3`}>
                  {course.level}
                </Badge>
                <h1 className="text-3xl md:text-4xl font-outfit font-bold text-white mb-2">
                  {course.title}
                </h1>
                <p className="text-text-secondary">{course.description}</p>
              </div>
            </div>

            {/* Course Stats */}
            <div className="grid grid-cols-4 gap-4">
              <div className="card-glass p-4 text-center rounded-md">
                <Clock className="w-5 h-5 text-primary mx-auto mb-2" />
                <div className="text-lg font-semibold text-white">{course.duration_hours}h</div>
                <div className="text-xs text-text-secondary">Duration</div>
              </div>
              <div className="card-glass p-4 text-center rounded-md">
                <Code2 className="w-5 h-5 text-primary mx-auto mb-2" />
                <div className="text-lg font-semibold text-white">{totalChallenges}</div>
                <div className="text-xs text-text-secondary">Challenges</div>
              </div>
              <div className="card-glass p-4 text-center rounded-md">
                <Users className="w-5 h-5 text-primary mx-auto mb-2" />
                <div className="text-lg font-semibold text-white">{course.enrolled_count || 0}</div>
                <div className="text-xs text-text-secondary">Enrolled</div>
              </div>
              <div className="card-glass p-4 text-center rounded-md">
                <Star className="w-5 h-5 star-gold mx-auto mb-2" />
                <div className="text-lg font-semibold text-warning">{course.rating || 0}</div>
                <div className="text-xs text-text-secondary">Rating</div>
              </div>
            </div>

            {/* Curriculum */}
            <Card className="card-glass" data-testid="curriculum">
              <CardHeader>
                <CardTitle className="text-white font-outfit">Course Curriculum</CardTitle>
              </CardHeader>
              <CardContent>
                {course.modules?.length > 0 ? (
                  <Accordion type="single" collapsible className="space-y-2">
                    {course.modules.map((module, moduleIndex) => (
                      <AccordionItem 
                        key={module.id} 
                        value={module.id}
                        className="border border-border rounded-md overflow-hidden"
                      >
                        <AccordionTrigger className="px-4 py-3 hover:bg-surface-highlight/50 hover:no-underline">
                          <div className="flex items-center gap-3 text-left">
                            <div className="w-8 h-8 bg-primary/20 rounded-md flex items-center justify-center text-primary font-mono text-sm">
                              {moduleIndex + 1}
                            </div>
                            <div>
                              <h4 className="font-medium text-white">{module.title}</h4>
                              <p className="text-xs text-text-secondary">
                                {module.lessons?.length || 0} lessons
                              </p>
                            </div>
                          </div>
                        </AccordionTrigger>
                        <AccordionContent className="bg-surface/50">
                          <div className="px-4 py-2 space-y-1">
                            {module.lessons?.map((lesson, lessonIndex) => (
                              <div 
                                key={lesson.id}
                                className="flex items-center justify-between p-3 rounded-md hover:bg-surface-highlight/50 cursor-pointer transition-colors"
                                onClick={() => startLesson(lesson.id)}
                                data-testid={`lesson-${lesson.id}`}
                              >
                                <div className="flex items-center gap-3">
                                  {enrollment?.completed_challenges?.some(
                                    c => lesson.challenges?.some(ch => ch.id === c)
                                  ) ? (
                                    <CheckCircle className="w-4 h-4 text-accent" />
                                  ) : enrollment ? (
                                    <Play className="w-4 h-4 text-primary" />
                                  ) : (
                                    <Lock className="w-4 h-4 text-text-secondary" />
                                  )}
                                  <div>
                                    <span className="text-sm text-white">{lesson.title}</span>
                                    <span className="text-xs text-text-secondary ml-2">
                                      {lesson.duration_minutes} min
                                    </span>
                                  </div>
                                </div>
                                <div className="flex items-center gap-2">
                                  {lesson.challenges?.length > 0 && (
                                    <Badge variant="outline" className="text-xs border-primary/30 text-primary">
                                      {lesson.challenges.length} challenges
                                    </Badge>
                                  )}
                                  <ChevronRight className="w-4 h-4 text-text-secondary" />
                                </div>
                              </div>
                            ))}
                          </div>
                        </AccordionContent>
                      </AccordionItem>
                    ))}
                  </Accordion>
                ) : (
                  <p className="text-text-secondary text-center py-8">
                    No modules available yet
                  </p>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Enrollment Card */}
            <Card className="card-glass sticky top-24" data-testid="enrollment-card">
              <CardContent className="p-6">
                {enrollment ? (
                  <>
                    <div className="mb-6">
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-sm text-text-secondary">Your Progress</span>
                        <span className="text-sm font-medium text-white">
                          {enrollment.progress_percentage || 0}%
                        </span>
                      </div>
                      <Progress 
                        value={enrollment.progress_percentage || 0} 
                        className="h-2 bg-surface-highlight" 
                      />
                    </div>
                    
                    <div className="grid grid-cols-2 gap-4 mb-6">
                      <div className="text-center p-3 bg-surface-highlight rounded-md">
                        <Star className="w-5 h-5 star-gold mx-auto mb-1" />
                        <div className="text-lg font-semibold text-warning">
                          {enrollment.stars_earned || 0}
                        </div>
                        <div className="text-xs text-text-secondary">Stars Earned</div>
                      </div>
                      <div className="text-center p-3 bg-surface-highlight rounded-md">
                        <CheckCircle className="w-5 h-5 text-accent mx-auto mb-1" />
                        <div className="text-lg font-semibold text-white">
                          {enrollment.completed_challenges?.length || 0}
                        </div>
                        <div className="text-xs text-text-secondary">Completed</div>
                      </div>
                    </div>

                    <Button 
                      onClick={() => {
                        // Find first incomplete lesson
                        const firstLesson = course.modules?.[0]?.lessons?.[0];
                        if (firstLesson) startLesson(firstLesson.id);
                      }}
                      className="w-full btn-primary"
                      data-testid="continue-learning-btn"
                    >
                      <Play className="w-4 h-4 mr-2" />
                      Continue Learning
                    </Button>
                  </>
                ) : (
                  <>
                    <div className="text-center mb-6">
                      <Award className="w-12 h-12 text-primary mx-auto mb-3" />
                      <h3 className="text-lg font-outfit font-semibold text-white mb-1">
                        Start Learning
                      </h3>
                      <p className="text-sm text-text-secondary">
                        Earn stars, compete, and get certified
                      </p>
                    </div>
                    
                    <Button 
                      onClick={handleEnroll}
                      disabled={enrolling}
                      className="w-full btn-primary py-6"
                      data-testid="enroll-btn"
                    >
                      {enrolling ? (
                        <Loader2 className="w-4 h-4 animate-spin" />
                      ) : (
                        <>
                          Enroll Now - Free
                          <ChevronRight className="w-4 h-4 ml-2" />
                        </>
                      )}
                    </Button>
                  </>
                )}
              </CardContent>
            </Card>

            {/* Tags */}
            {course.tags?.length > 0 && (
              <Card className="card-glass">
                <CardHeader>
                  <CardTitle className="text-white font-outfit text-sm">Tags</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex flex-wrap gap-2">
                    {course.tags.map((tag) => (
                      <Badge key={tag} variant="outline" className="border-border text-text-secondary">
                        {tag}
                      </Badge>
                    ))}
                  </div>
                </CardContent>
              </Card>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseSingle;
