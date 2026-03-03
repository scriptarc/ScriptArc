import { useState, useEffect } from 'react';
import { leaderboardAPI } from '@/lib/api';
import { useAuth } from '@/context/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { 
  Trophy, 
  Star, 
  Flame, 
  Medal,
  Crown,
  Loader2
} from 'lucide-react';

const Leaderboard = () => {
  const { user } = useAuth();
  const [leaderboard, setLeaderboard] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchLeaderboard();
  }, []);

  const fetchLeaderboard = async () => {
    try {
      const response = await leaderboardAPI.getGlobal(50);
      setLeaderboard(response.data);
    } catch (error) {
      console.error('Failed to fetch leaderboard:', error);
    } finally {
      setLoading(false);
    }
  };

  const getRankIcon = (rank) => {
    switch (rank) {
      case 1:
        return <Crown className="w-6 h-6 text-yellow-400" />;
      case 2:
        return <Medal className="w-6 h-6 text-gray-300" />;
      case 3:
        return <Medal className="w-6 h-6 text-amber-600" />;
      default:
        return <span className="text-lg font-mono text-text-secondary">#{rank}</span>;
    }
  };

  const getRankStyle = (rank) => {
    switch (rank) {
      case 1:
        return 'bg-gradient-to-r from-yellow-500/20 to-yellow-600/10 border-yellow-500/30';
      case 2:
        return 'bg-gradient-to-r from-gray-400/20 to-gray-500/10 border-gray-400/30';
      case 3:
        return 'bg-gradient-to-r from-amber-600/20 to-amber-700/10 border-amber-600/30';
      default:
        return 'bg-surface-highlight/50 border-transparent';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pt-20 pb-12" data-testid="leaderboard-page">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="text-center mb-12">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-primary/20 rounded-md mb-4">
            <Trophy className="w-8 h-8 text-primary" />
          </div>
          <h1 className="text-3xl md:text-4xl font-outfit font-bold text-white mb-2">
            Global Leaderboard
          </h1>
          <p className="text-text-secondary">
            Top performers earning stars across all courses
          </p>
        </div>

        {/* Top 3 Podium */}
        {leaderboard.length >= 3 && (
          <div className="grid grid-cols-3 gap-4 mb-8">
            {/* 2nd Place */}
            <div className="pt-8">
              <Card className="card-glass border-gray-400/30 text-center">
                <CardContent className="pt-6 pb-4">
                  <div className="relative inline-block mb-3">
                    <Avatar className="w-16 h-16 border-2 border-gray-400">
                      <AvatarFallback className="bg-gradient-to-br from-gray-500 to-gray-600 text-white text-xl">
                        {leaderboard[1]?.name?.charAt(0).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-gray-400 rounded-full flex items-center justify-center text-black font-bold text-sm">
                      2
                    </div>
                  </div>
                  <h3 className="font-medium text-white truncate">{leaderboard[1]?.name}</h3>
                  <div className="flex items-center justify-center gap-1 text-warning mt-1">
                    <Star className="w-4 h-4 fill-current" />
                    <span className="font-mono">{leaderboard[1]?.total_stars}</span>
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* 1st Place */}
            <div>
              <Card className="card-glass border-yellow-500/30 text-center relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-b from-yellow-500/10 to-transparent" />
                <CardContent className="pt-6 pb-4 relative">
                  <Crown className="w-8 h-8 text-yellow-400 mx-auto mb-2" />
                  <div className="relative inline-block mb-3">
                    <Avatar className="w-20 h-20 border-2 border-yellow-400">
                      <AvatarFallback className="bg-gradient-to-br from-yellow-500 to-amber-600 text-white text-2xl">
                        {leaderboard[0]?.name?.charAt(0).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <div className="absolute -bottom-1 -right-1 w-7 h-7 bg-yellow-400 rounded-full flex items-center justify-center text-black font-bold">
                      1
                    </div>
                  </div>
                  <h3 className="font-semibold text-white truncate">{leaderboard[0]?.name}</h3>
                  <div className="flex items-center justify-center gap-1 text-warning mt-1">
                    <Star className="w-5 h-5 fill-current" />
                    <span className="font-mono text-lg">{leaderboard[0]?.total_stars}</span>
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* 3rd Place */}
            <div className="pt-12">
              <Card className="card-glass border-amber-600/30 text-center">
                <CardContent className="pt-6 pb-4">
                  <div className="relative inline-block mb-3">
                    <Avatar className="w-14 h-14 border-2 border-amber-600">
                      <AvatarFallback className="bg-gradient-to-br from-amber-600 to-amber-700 text-white text-lg">
                        {leaderboard[2]?.name?.charAt(0).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-amber-600 rounded-full flex items-center justify-center text-white font-bold text-xs">
                      3
                    </div>
                  </div>
                  <h3 className="font-medium text-white truncate text-sm">{leaderboard[2]?.name}</h3>
                  <div className="flex items-center justify-center gap-1 text-warning mt-1">
                    <Star className="w-3 h-3 fill-current" />
                    <span className="font-mono text-sm">{leaderboard[2]?.total_stars}</span>
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        )}

        {/* Full Leaderboard */}
        <Card className="card-glass" data-testid="leaderboard-list">
          <CardHeader>
            <CardTitle className="text-white font-outfit">All Rankings</CardTitle>
          </CardHeader>
          <CardContent>
            {leaderboard.length > 0 ? (
              <div className="space-y-2">
                {leaderboard.map((player) => (
                  <div
                    key={player.id}
                    className={`flex items-center gap-4 p-4 rounded-md border ${getRankStyle(player.rank)} ${
                      player.id === user?.id ? 'ring-2 ring-primary' : ''
                    }`}
                    data-testid={`leaderboard-row-${player.rank}`}
                  >
                    {/* Rank */}
                    <div className="w-12 flex justify-center">
                      {getRankIcon(player.rank)}
                    </div>

                    {/* Avatar & Name */}
                    <div className="flex items-center gap-3 flex-1 min-w-0">
                      <Avatar className="w-10 h-10">
                        <AvatarFallback className="bg-gradient-to-br from-primary to-secondary text-white">
                          {player.name?.charAt(0).toUpperCase()}
                        </AvatarFallback>
                      </Avatar>
                      <div className="min-w-0">
                        <div className="flex items-center gap-2">
                          <span className="font-medium text-white truncate">
                            {player.name}
                          </span>
                          {player.id === user?.id && (
                            <Badge className="bg-primary/20 text-primary text-xs">You</Badge>
                          )}
                        </div>
                        <span className="text-xs text-text-secondary">
                          Level {player.level || 1}
                        </span>
                      </div>
                    </div>

                    {/* Stats */}
                    <div className="flex items-center gap-6">
                      <div className="flex items-center gap-1 text-warning" title="Streak">
                        <Flame className="w-4 h-4" />
                        <span className="text-sm font-mono">{player.streak_days || 0}</span>
                      </div>
                      <div className="flex items-center gap-1 text-warning" title="Stars">
                        <Star className="w-4 h-4 fill-current" />
                        <span className="font-mono font-medium">{player.total_stars || 0}</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-12">
                <Trophy className="w-12 h-12 text-text-secondary mx-auto mb-3" />
                <p className="text-text-secondary">No rankings yet. Be the first!</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Leaderboard;
