import { useState } from 'react';
import { useAuth } from '@/context/AuthContext';
import { authAPI } from '@/lib/api';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { toast } from 'sonner';
import { 
  User, 
  Star, 
  Flame, 
  Trophy,
  Award,
  Eye,
  EyeOff,
  Save,
  TrendingUp,
  Loader2
} from 'lucide-react';

const BADGE_INFO = {
  'first_try_master': { name: 'First Try Master', icon: '⚡', description: 'Solved on first attempt', color: 'text-cyan' },
  'no_hint_hero': { name: 'No Hint Hero', icon: '🧠', description: '10 challenges without hints', color: 'text-accent' },
  '7_day_streak': { name: '7 Day Streak', icon: '🔥', description: '7 days learning streak', color: 'text-warning' },
  'star_collector_100': { name: 'Star Collector', icon: '⭐', description: 'Earned 100 stars', color: 'text-warning' },
  'star_collector_500': { name: 'Star Master', icon: '🌟', description: 'Earned 500 stars', color: 'text-primary' },
};

const Profile = () => {
  const { user, updateUser } = useAuth();
  const [saving, setSaving] = useState(false);
  const [name, setName] = useState(user?.name || '');
  const [leaderboardVisible, setLeaderboardVisible] = useState(user?.leaderboard_visible ?? true);

  const handleSave = async () => {
    setSaving(true);
    try {
      const response = await authAPI.updateProfile({
        name,
        leaderboard_visible: leaderboardVisible
      });
      updateUser(response.data);
      toast.success('Profile updated successfully');
    } catch (error) {
      toast.error('Failed to update profile');
    } finally {
      setSaving(false);
    }
  };

  const levelProgress = ((user?.total_stars || 0) % 50) / 50 * 100;
  const starsToNextLevel = 50 - ((user?.total_stars || 0) % 50);

  return (
    <div className="min-h-screen bg-background pt-20 pb-12" data-testid="profile-page">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Profile Header */}
        <div className="mb-8">
          <div className="flex items-start gap-6">
            <div className="w-24 h-24 rounded-md bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white text-4xl font-outfit font-bold">
              {user?.name?.charAt(0).toUpperCase()}
            </div>
            <div className="flex-1">
              <h1 className="text-3xl font-outfit font-bold text-white mb-1">
                {user?.name}
              </h1>
              <p className="text-text-secondary mb-2">{user?.email}</p>
              <div className="flex items-center gap-4 text-sm">
                <span className="px-3 py-1 bg-primary/20 text-primary rounded-md capitalize">
                  {user?.role}
                </span>
                <span className="text-text-secondary">
                  Member since {new Date(user?.created_at || Date.now()).toLocaleDateString()}
                </span>
              </div>
            </div>
          </div>
        </div>

        <div className="grid lg:grid-cols-3 gap-6">
          {/* Stats Column */}
          <div className="lg:col-span-2 space-y-6">
            {/* Level Progress */}
            <Card className="card-glass" data-testid="level-progress-card">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <TrendingUp className="w-5 h-5 text-primary" />
                  Level Progress
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center gap-6 mb-4">
                  <div className="w-20 h-20 rounded-md bg-gradient-to-br from-primary/20 to-secondary/20 border border-primary/30 flex items-center justify-center">
                    <span className="text-3xl font-outfit font-bold text-primary">
                      {user?.level || 1}
                    </span>
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-sm text-text-secondary">Progress to Level {(user?.level || 1) + 1}</span>
                      <span className="text-sm text-white font-mono">{Math.round(levelProgress)}%</span>
                    </div>
                    <Progress value={levelProgress} className="h-3 bg-surface-highlight" />
                    <p className="text-xs text-text-secondary mt-2">
                      {starsToNextLevel} more stars to level up
                    </p>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Stats Grid */}
            <div className="grid grid-cols-3 gap-4">
              <Card className="card-glass">
                <CardContent className="pt-6 text-center">
                  <Star className="w-8 h-8 star-gold mx-auto mb-2" />
                  <div className="text-3xl font-outfit font-bold text-warning">
                    {user?.total_stars || 0}
                  </div>
                  <div className="text-sm text-text-secondary">Total Stars</div>
                </CardContent>
              </Card>
              <Card className="card-glass">
                <CardContent className="pt-6 text-center">
                  <Flame className="w-8 h-8 streak-fire mx-auto mb-2" />
                  <div className="text-3xl font-outfit font-bold text-warning">
                    {user?.streak_days || 0}
                  </div>
                  <div className="text-sm text-text-secondary">Day Streak</div>
                </CardContent>
              </Card>
              <Card className="card-glass">
                <CardContent className="pt-6 text-center">
                  <Award className="w-8 h-8 text-secondary mx-auto mb-2" />
                  <div className="text-3xl font-outfit font-bold text-white">
                    {user?.badges?.length || 0}
                  </div>
                  <div className="text-sm text-text-secondary">Badges</div>
                </CardContent>
              </Card>
            </div>

            {/* Badges */}
            <Card className="card-glass" data-testid="badges-section">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <Award className="w-5 h-5 text-secondary" />
                  Badges Earned
                </CardTitle>
                <CardDescription className="text-text-secondary">
                  Achievements unlocked through your learning journey
                </CardDescription>
              </CardHeader>
              <CardContent>
                {user?.badges?.length > 0 ? (
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                    {user.badges.map((badge) => {
                      const info = BADGE_INFO[badge] || { name: badge, icon: '🏆', description: '', color: 'text-white' };
                      return (
                        <div 
                          key={badge}
                          className="p-4 bg-surface-highlight rounded-md text-center hover:bg-surface-highlight/80 transition-colors"
                        >
                          <span className="text-4xl mb-2 block">{info.icon}</span>
                          <h4 className={`font-medium ${info.color}`}>{info.name}</h4>
                          <p className="text-xs text-text-secondary mt-1">{info.description}</p>
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <div className="text-center py-8">
                    <Award className="w-12 h-12 text-text-secondary mx-auto mb-3" />
                    <p className="text-text-secondary">
                      Complete challenges to earn badges!
                    </p>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Settings Column */}
          <div className="space-y-6">
            <Card className="card-glass" data-testid="settings-card">
              <CardHeader>
                <CardTitle className="text-white font-outfit flex items-center gap-2">
                  <User className="w-5 h-5 text-primary" />
                  Profile Settings
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="name" className="text-text-secondary">Display Name</Label>
                  <Input
                    id="name"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    className="input-dark"
                    data-testid="name-input"
                  />
                </div>

                <div className="flex items-center justify-between p-4 bg-surface-highlight rounded-md">
                  <div className="flex items-center gap-3">
                    {leaderboardVisible ? (
                      <Eye className="w-5 h-5 text-primary" />
                    ) : (
                      <EyeOff className="w-5 h-5 text-text-secondary" />
                    )}
                    <div>
                      <p className="text-sm text-white">Leaderboard Visibility</p>
                      <p className="text-xs text-text-secondary">
                        {leaderboardVisible ? 'Visible to others' : 'Hidden from others'}
                      </p>
                    </div>
                  </div>
                  <Switch
                    checked={leaderboardVisible}
                    onCheckedChange={setLeaderboardVisible}
                    data-testid="leaderboard-toggle"
                  />
                </div>

                <Button 
                  onClick={handleSave}
                  disabled={saving}
                  className="w-full btn-primary"
                  data-testid="save-profile-btn"
                >
                  {saving ? (
                    <Loader2 className="w-4 h-4 animate-spin mr-2" />
                  ) : (
                    <Save className="w-4 h-4 mr-2" />
                  )}
                  Save Changes
                </Button>
              </CardContent>
            </Card>

            {/* Quick Stats */}
            <Card className="card-glass">
              <CardHeader>
                <CardTitle className="text-white font-outfit text-sm">Account Info</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3 text-sm">
                <div className="flex justify-between">
                  <span className="text-text-secondary">Email</span>
                  <span className="text-white truncate ml-2">{user?.email}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-text-secondary">Role</span>
                  <span className="text-white capitalize">{user?.role}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-text-secondary">User ID</span>
                  <span className="text-text-secondary font-mono text-xs truncate ml-2">
                    {user?.id?.slice(0, 8)}...
                  </span>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Profile;
