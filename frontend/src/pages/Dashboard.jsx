import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';
import { dashboardAPI, seedAPI } from '@/lib/api';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'sonner';
import { 
  Star, 
  Flame, 
  Trophy, 
  ArrowRight, 
  BookOpen,
  Award,
  TrendingUp,
  Clock,
  Loader2
} from 'lucide-react';

const BADGE_INFO = {
  'first_try_master': { name: 'First Try Master', icon: '⚡', color: 'text-cyan' },
  'no_hint_hero': { name: 'No Hint Hero', icon: '🧠', color: 'text-accent' },
  '7_day_streak': { name: '7 Day Streak', icon: '🔥', color: 'text-warning' },
  'star_collector_100': { name: 'Star Collector', icon: '⭐', color: 'text-warning' },
  'star_collector_500': { name: 'Star Master', icon: '🌟', color: 'text-primary' },
};

const Dashboard = () => {
  const navigate = useNavigate();
  const { user, updateUser } = useAuth();
  const [loading, setLoading] = useState(true);
  const [dashboardData, setDashboardData] = useState(null);

  useEffect(() => {
    fetchDashboard();
  }, []);

  const fetchDashboard = async () => {
    try {
      // Seed data first (for demo)
      await seedAPI.seed().catch(() => {});
      
      const response = await dashboardAPI.get();
      setDashboardData(response.data);
      updateUser(response.data.user);
    } catch (error) {
      console.error('Failed to fetch dashboard:', error);
      toast.error('Failed to load dashboard');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary" />
      </div>
    );
  }

  const levelProgress = ((user?.total_stars || 0) % 50) / 50 * 100;

  return (
    <div className="min-h-screen bg-background pt-20 pb-12" data-testid="dashboard-page">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Welcome Header */}
        <div className="mb-8">
          <h1 className="text-3xl md:text-4xl font-outfit font-bold text-white mb-2">
            Welcome back, {user?.name?.split(' ')[0]}!
          </h1>
          <p className="text-text-secondary">
            Keep your streak alive and climb the leaderboard
          </p>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
          {/* Level Card */}
          <Card className="card-glass" data-testid="level-card">
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-text-secondary text-sm">Level</span>
                <TrendingUp className="w-4 h-4 text-primary" />
              </div>
              <div className="text-3xl font-outfit font-bold text-white mb-2">
                {user?.level || 1}
              </div>
              <Progress value={levelProgress} className="h-1.5 bg-surface-highlight" />
              <p className="text-xs text-text-secondary mt-2">
                {50 - ((user?.total_stars || 0) % 50)} stars to next level
              </p>
            </CardContent>
          </Card>

          {/* Stars Card */}
          <Card className="card-glass" data-testid="stars-card">
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-text-secondary text-sm">Total Stars</span>
                <Star className="w-4 h-4 star-gold" />
              </div>
              <div className="text-3xl font-outfit font-bold text-warning">
                {user?.total_stars || 0}
              </div>
              <p className="text-xs text-text-secondary mt-2">
                Keep earning more stars!
              </p>
            </CardContent>
          </Card>

          {/* Streak Card */}
          <Card className="card-glass" data-testid="streak-card">
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-text-secondary text-sm">Streak</span>
                <Flame className="w-4 h-4 streak-fire" />
              </div>
              <div className="text-3xl font-outfit font-bold text-warning">
                {dashboardData?.streak_days || 0}
              </div>
              <p className="text-xs text-text-secondary mt-2">
                {dashboardData?.streak_days >= 7 ? 'Amazing streak!' : 'days in a row'}
              </p>
            </CardContent>
          </Card>

          {/* Rank Card */}
          <Card className="card-glass" data-testid="rank-card">
            <CardContent className="pt-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-text-secondary text-sm">Rank</span>
                <Trophy className="w-4 h-4 text-primary" />
              </div>
              <div className="text-3xl font-outfit font-bold text-white">
                #{dashboardData?.rank || '-'}
              </div>
              <p className="text-xs text-text-secondary mt-2">
                Global leaderboard
              </p>
            </CardContent>
          </Card>
        </div>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Continue Learning */}
            <Card className="card-glass" data-testid="continue-learning">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <BookOpen className="w-5 h-5 text-primary" />
                  Continue Learning
                </CardTitle>
              </CardHeader>
              <CardContent>
                {dashboardData?.courses_in_progress?.length > 0 ? (
                  <div className="space-y-4">
                    {dashboardData.courses_in_progress.map((course) => (
                      <div 
                        key={course.id}
                        className="flex items-center gap-4 p-4 bg-surface-highlight rounded-md hover:bg-surface-highlight/80 transition-colors cursor-pointer"
                        onClick={() => navigate(`/courses/${course.id}`)}
                        data-testid={`course-progress-${course.id}`}
                      >
                        <img 
                          src={course.thumbnail_url || 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=100'} 
                          alt={course.title}
                          className="w-16 h-16 rounded-md object-cover"
                        />
                        <div className="flex-1 min-w-0">
                          <h4 className="text-white font-medium truncate">{course.title}</h4>
                          <div className="flex items-center gap-4 mt-1">
                            <span className="text-xs text-text-secondary">
                              {course.progress || 0}% complete
                            </span>
                            <span className="text-xs text-warning flex items-center gap-1">
                              <Star className="w-3 h-3" />
                              {course.stars_earned || 0}
                            </span>
                          </div>
                          <Progress 
                            value={course.progress || 0} 
                            className="h-1.5 mt-2 bg-surface" 
                          />
                        </div>
                        <ArrowRight className="w-5 h-5 text-text-secondary" />
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-8">
                    <BookOpen className="w-12 h-12 text-text-secondary mx-auto mb-3" />
                    <p className="text-text-secondary mb-4">No courses started yet</p>
                    <Button 
                      onClick={() => navigate('/courses')}
                      className="btn-primary"
                      data-testid="browse-courses-btn"
                    >
                      Browse Courses
                    </Button>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Recent Activity */}
            <Card className="card-glass" data-testid="recent-activity">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <Clock className="w-5 h-5 text-primary" />
                  Recent Activity
                </CardTitle>
              </CardHeader>
              <CardContent>
                {dashboardData?.recent_completions?.length > 0 ? (
                  <div className="space-y-3">
                    {dashboardData.recent_completions.map((completion, index) => (
                      <div 
                        key={index}
                        className="flex items-center justify-between p-3 bg-surface-highlight/50 rounded-md"
                      >
                        <div className="flex items-center gap-3">
                          <div className="w-8 h-8 bg-accent/20 rounded-md flex items-center justify-center">
                            <Award className="w-4 h-4 text-accent" />
                          </div>
                          <div>
                            <p className="text-sm text-white">Challenge completed</p>
                            <p className="text-xs text-text-secondary">
                              {new Date(completion.completed_at).toLocaleDateString()}
                            </p>
                          </div>
                        </div>
                        <div className="flex items-center gap-1 text-warning">
                          <Star className="w-4 h-4" />
                          <span className="text-sm font-medium">+{completion.stars_earned}</span>
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p className="text-text-secondary text-center py-4">
                    No recent activity
                  </p>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Badges */}
            <Card className="card-glass" data-testid="badges-card">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <Award className="w-5 h-5 text-primary" />
                  Badges
                </CardTitle>
              </CardHeader>
              <CardContent>
                {dashboardData?.badges?.length > 0 ? (
                  <div className="grid grid-cols-3 gap-3">
                    {dashboardData.badges.map((badge) => {
                      const info = BADGE_INFO[badge] || { name: badge, icon: '🏆', color: 'text-white' };
                      return (
                        <div 
                          key={badge}
                          className="flex flex-col items-center p-3 bg-surface-highlight rounded-md"
                          title={info.name}
                        >
                          <span className="text-2xl mb-1">{info.icon}</span>
                          <span className={`text-xs ${info.color} text-center`}>{info.name}</span>
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <div className="text-center py-4">
                    <p className="text-text-secondary text-sm">
                      Complete challenges to earn badges!
                    </p>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Quick Actions */}
            <Card className="card-glass">
              <CardHeader>
                <CardTitle className="text-white font-outfit">Quick Actions</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <Button 
                  onClick={() => navigate('/courses')}
                  className="w-full btn-primary justify-between"
                  data-testid="explore-courses-action"
                >
                  Explore Courses
                  <ArrowRight className="w-4 h-4" />
                </Button>
                <Button 
                  onClick={() => navigate('/leaderboard')}
                  variant="outline"
                  className="w-full btn-cyber justify-between"
                  data-testid="view-leaderboard-action"
                >
                  View Leaderboard
                  <Trophy className="w-4 h-4" />
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
