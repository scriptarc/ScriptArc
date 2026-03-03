import { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { lessonAPI, challengeAPI } from '@/lib/api';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { toast } from 'sonner';
import Editor from '@monaco-editor/react';
import { 
  Play, 
  Pause, 
  SkipForward, 
  Volume2, 
  VolumeX,
  Maximize,
  ChevronRight,
  Star,
  Lightbulb,
  CheckCircle,
  XCircle,
  Loader2,
  ArrowLeft,
  Code2,
  AlertTriangle
} from 'lucide-react';

const LANGUAGE_MAP = {
  71: { name: 'Python', monaco: 'python' },
  63: { name: 'JavaScript', monaco: 'javascript' },
  62: { name: 'Java', monaco: 'java' },
  54: { name: 'C++', monaco: 'cpp' },
  50: { name: 'C', monaco: 'c' },
};

const Learn = () => {
  const { lessonId } = useParams();
  const navigate = useNavigate();
  const videoRef = useRef(null);
  
  const [lesson, setLesson] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);
  const [isMuted, setIsMuted] = useState(false);
  
  // Challenge state
  const [activeChallenge, setActiveChallenge] = useState(null);
  const [showChallenge, setShowChallenge] = useState(false);
  const [code, setCode] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [result, setResult] = useState(null);
  const [attemptCount, setAttemptCount] = useState(0);
  const [hintsUsed, setHintsUsed] = useState(0);
  const [currentHint, setCurrentHint] = useState(null);
  const [showHintOption, setShowHintOption] = useState(false);
  const [completedChallenges, setCompletedChallenges] = useState(new Set());

  useEffect(() => {
    fetchLesson();
  }, [lessonId]);

  const fetchLesson = async () => {
    try {
      const response = await lessonAPI.getOne(lessonId);
      setLesson(response.data);
    } catch (error) {
      console.error('Failed to fetch lesson:', error);
      toast.error('Failed to load lesson');
    } finally {
      setLoading(false);
    }
  };

  // Video controls
  const togglePlay = () => {
    if (videoRef.current) {
      if (isPlaying) {
        videoRef.current.pause();
      } else {
        videoRef.current.play();
      }
      setIsPlaying(!isPlaying);
    }
  };

  const toggleMute = () => {
    if (videoRef.current) {
      videoRef.current.muted = !isMuted;
      setIsMuted(!isMuted);
    }
  };

  const handleTimeUpdate = () => {
    if (videoRef.current) {
      setCurrentTime(videoRef.current.currentTime);
      
      // Check for challenge timestamps
      if (lesson?.challenges && !showChallenge) {
        for (const challenge of lesson.challenges) {
          if (
            !completedChallenges.has(challenge.id) &&
            Math.abs(videoRef.current.currentTime - challenge.timestamp_seconds) < 1
          ) {
            videoRef.current.pause();
            setIsPlaying(false);
            openChallenge(challenge);
            break;
          }
        }
      }
    }
  };

  const handleLoadedMetadata = () => {
    if (videoRef.current) {
      setDuration(videoRef.current.duration);
    }
  };

  const handleSeek = (e) => {
    if (videoRef.current) {
      const rect = e.currentTarget.getBoundingClientRect();
      const percent = (e.clientX - rect.left) / rect.width;
      videoRef.current.currentTime = percent * duration;
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // Challenge functions
  const openChallenge = (challenge) => {
    setActiveChallenge(challenge);
    setCode(challenge.initial_code || '');
    setShowChallenge(true);
    setResult(null);
    setAttemptCount(0);
    setHintsUsed(0);
    setCurrentHint(null);
    setShowHintOption(false);
  };

  const closeChallenge = (skipped = false) => {
    if (skipped && !completedChallenges.has(activeChallenge?.id)) {
      toast.warning('Challenge skipped. You can retry later.');
    }
    setShowChallenge(false);
    setActiveChallenge(null);
    setResult(null);
    
    // Resume video
    if (videoRef.current && !skipped) {
      videoRef.current.play();
      setIsPlaying(true);
    }
  };

  const submitCode = async () => {
    if (!activeChallenge) return;
    
    setSubmitting(true);
    setResult(null);
    
    try {
      const response = await challengeAPI.submit({
        challenge_id: activeChallenge.id,
        source_code: code,
        language_id: activeChallenge.language_id
      });
      
      setResult(response.data);
      setAttemptCount(response.data.attempt_number);
      
      if (response.data.passed) {
        setCompletedChallenges(prev => new Set([...prev, activeChallenge.id]));
        toast.success(`Challenge completed! +${response.data.stars_earned} stars`);
        
        // Auto close after success
        setTimeout(() => closeChallenge(), 2000);
      } else {
        // Show hint option after 2 failed attempts
        if (response.data.attempt_number >= 2) {
          setShowHintOption(true);
        }
      }
    } catch (error) {
      toast.error(error.response?.data?.detail || 'Submission failed');
    } finally {
      setSubmitting(false);
    }
  };

  const requestHint = async () => {
    if (!activeChallenge) return;
    
    try {
      const response = await challengeAPI.getHint({
        challenge_id: activeChallenge.id
      });
      
      if (response.data.hint) {
        setCurrentHint(response.data.hint);
        setHintsUsed(response.data.hint_number);
        toast.info('Hint unlocked! Note: Using hints reduces your star potential.');
      } else {
        toast.info(response.data.message);
      }
    } catch (error) {
      toast.error('Failed to get hint');
    }
  };

  // Calculate stars preview
  const getStarsPreview = () => {
    if (attemptCount === 0) return 5;
    if (hintsUsed > 0) return 2;
    if (attemptCount === 1) return 5;
    if (attemptCount === 2) return 4;
    if (attemptCount === 3) return 3;
    return 2;
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="min-h-screen bg-background pt-20 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-outfit text-white mb-4">Lesson not found</h2>
          <Button onClick={() => navigate('/courses')} className="btn-primary">
            Browse Courses
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pt-16" data-testid="learn-page">
      <div className="flex flex-col lg:flex-row min-h-[calc(100vh-4rem)]">
        {/* Video Section */}
        <div className="lg:w-2/3 flex flex-col">
          {/* Back Button */}
          <div className="p-4">
            <button 
              onClick={() => navigate(-1)}
              className="flex items-center gap-2 text-text-secondary hover:text-white transition-colors"
              data-testid="back-btn"
            >
              <ArrowLeft className="w-4 h-4" />
              Back
            </button>
          </div>

          {/* Video Player */}
          <div className="flex-1 flex flex-col">
            <div className="relative bg-black aspect-video">
              {lesson.video_url ? (
                <video
                  ref={videoRef}
                  src={`${process.env.REACT_APP_BACKEND_URL}${lesson.video_url}`}
                  className="w-full h-full"
                  onTimeUpdate={handleTimeUpdate}
                  onLoadedMetadata={handleLoadedMetadata}
                  onPlay={() => setIsPlaying(true)}
                  onPause={() => setIsPlaying(false)}
                  data-testid="video-player"
                />
              ) : (
                <div className="w-full h-full flex items-center justify-center bg-surface">
                  <div className="text-center">
                    <Code2 className="w-16 h-16 text-text-secondary mx-auto mb-4" />
                    <p className="text-text-secondary mb-2">No video available for this lesson</p>
                    <p className="text-sm text-text-secondary">Start the challenge below</p>
                  </div>
                </div>
              )}

              {/* Challenge Markers on Timeline */}
              {lesson.challenges?.map((challenge) => (
                <div
                  key={challenge.id}
                  className="absolute bottom-12 w-3 h-3 transform -translate-x-1/2"
                  style={{ left: `${(challenge.timestamp_seconds / (duration || 1)) * 100}%` }}
                >
                  <div 
                    className={`w-3 h-3 rotate-45 ${
                      completedChallenges.has(challenge.id) 
                        ? 'bg-accent' 
                        : 'bg-primary animate-pulse'
                    }`}
                    title={challenge.title}
                  />
                </div>
              ))}
            </div>

            {/* Custom Video Controls */}
            <div className="bg-surface-highlight p-4">
              {/* Progress Bar */}
              <div 
                className="h-1 bg-surface rounded-full cursor-pointer mb-4"
                onClick={handleSeek}
                data-testid="video-progress"
              >
                <div 
                  className="h-full bg-primary rounded-full transition-all"
                  style={{ width: `${(currentTime / (duration || 1)) * 100}%` }}
                />
              </div>

              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <button 
                    onClick={togglePlay}
                    className="p-2 hover:bg-white/10 rounded-md transition-colors"
                    data-testid="play-pause-btn"
                  >
                    {isPlaying ? (
                      <Pause className="w-5 h-5 text-white" />
                    ) : (
                      <Play className="w-5 h-5 text-white" />
                    )}
                  </button>
                  <button 
                    onClick={toggleMute}
                    className="p-2 hover:bg-white/10 rounded-md transition-colors"
                  >
                    {isMuted ? (
                      <VolumeX className="w-5 h-5 text-white" />
                    ) : (
                      <Volume2 className="w-5 h-5 text-white" />
                    )}
                  </button>
                  <span className="text-sm text-text-secondary font-mono">
                    {formatTime(currentTime)} / {formatTime(duration)}
                  </span>
                </div>

                <div className="flex items-center gap-2">
                  <span className="text-sm text-white font-medium">{lesson.title}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Challenges Panel */}
        <div className="lg:w-1/3 bg-surface border-l border-border p-6 overflow-y-auto">
          <h2 className="text-xl font-outfit font-semibold text-white mb-4">
            Lesson Challenges
          </h2>
          
          {lesson.challenges?.length > 0 ? (
            <div className="space-y-3">
              {lesson.challenges.map((challenge, index) => (
                <Card 
                  key={challenge.id}
                  className={`card-glass cursor-pointer transition-all ${
                    completedChallenges.has(challenge.id) 
                      ? 'border-accent/50' 
                      : 'hover:border-primary/50'
                  }`}
                  onClick={() => openChallenge(challenge)}
                  data-testid={`challenge-card-${challenge.id}`}
                >
                  <CardContent className="p-4">
                    <div className="flex items-start gap-3">
                      <div className={`w-8 h-8 rounded-md flex items-center justify-center ${
                        completedChallenges.has(challenge.id) 
                          ? 'bg-accent/20 text-accent' 
                          : 'bg-primary/20 text-primary'
                      }`}>
                        {completedChallenges.has(challenge.id) ? (
                          <CheckCircle className="w-4 h-4" />
                        ) : (
                          <span className="text-sm font-mono">{index + 1}</span>
                        )}
                      </div>
                      <div className="flex-1">
                        <h4 className="text-sm font-medium text-white mb-1">
                          {challenge.title}
                        </h4>
                        <div className="flex items-center gap-2 text-xs text-text-secondary">
                          <Badge variant="outline" className="border-primary/30 text-primary">
                            {LANGUAGE_MAP[challenge.language_id]?.name || 'Code'}
                          </Badge>
                          <span>@{formatTime(challenge.timestamp_seconds)}</span>
                        </div>
                      </div>
                      <ChevronRight className="w-4 h-4 text-text-secondary" />
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          ) : (
            <div className="text-center py-8">
              <Code2 className="w-12 h-12 text-text-secondary mx-auto mb-3" />
              <p className="text-text-secondary">No challenges in this lesson</p>
            </div>
          )}
        </div>
      </div>

      {/* Challenge Dialog */}
      <Dialog open={showChallenge} onOpenChange={(open) => !open && closeChallenge(true)}>
        <DialogContent className="max-w-4xl max-h-[90vh] overflow-hidden bg-surface border-border p-0">
          <DialogHeader className="p-6 pb-0">
            <DialogTitle className="text-white font-outfit flex items-center gap-2">
              <Code2 className="w-5 h-5 text-primary" />
              {activeChallenge?.title}
            </DialogTitle>
            <DialogDescription className="text-text-secondary">
              {activeChallenge?.description}
            </DialogDescription>
          </DialogHeader>

          <div className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-200px)]">
            {/* Stars Preview */}
            <div className="flex items-center justify-between p-3 bg-surface-highlight rounded-md">
              <span className="text-sm text-text-secondary">Potential Stars:</span>
              <div className="flex items-center gap-1">
                {[1, 2, 3, 4, 5].map((star) => (
                  <Star 
                    key={star}
                    className={`w-4 h-4 ${
                      star <= getStarsPreview() ? 'text-warning fill-warning' : 'text-gray-600'
                    }`}
                  />
                ))}
              </div>
            </div>

            {/* Code Editor */}
            <div className="border border-border rounded-md overflow-hidden">
              <div className="bg-[#1e1e1e] p-2 border-b border-border flex items-center justify-between">
                <Badge className="bg-primary/20 text-primary border-0">
                  {LANGUAGE_MAP[activeChallenge?.language_id]?.name || 'Code'}
                </Badge>
                <span className="text-xs text-text-secondary">
                  Attempt #{attemptCount + 1}
                </span>
              </div>
              <Editor
                height="300px"
                language={LANGUAGE_MAP[activeChallenge?.language_id]?.monaco || 'python'}
                theme="vs-dark"
                value={code}
                onChange={(value) => setCode(value || '')}
                options={{
                  minimap: { enabled: false },
                  fontSize: 14,
                  fontFamily: 'JetBrains Mono, monospace',
                  padding: { top: 16 },
                  scrollBeyondLastLine: false,
                }}
                data-testid="code-editor"
              />
            </div>

            {/* Hint Section */}
            {showHintOption && activeChallenge?.hints?.length > 0 && !currentHint && (
              <div className="flex items-center justify-between p-3 bg-warning/10 border border-warning/30 rounded-md">
                <div className="flex items-center gap-2">
                  <AlertTriangle className="w-4 h-4 text-warning" />
                  <span className="text-sm text-warning">Struggling? Get a hint (reduces stars)</span>
                </div>
                <Button 
                  size="sm" 
                  variant="outline"
                  onClick={requestHint}
                  className="border-warning text-warning hover:bg-warning/10"
                  data-testid="request-hint-btn"
                >
                  <Lightbulb className="w-4 h-4 mr-1" />
                  Get Hint
                </Button>
              </div>
            )}

            {currentHint && (
              <div className="p-4 bg-primary/10 border border-primary/30 rounded-md">
                <div className="flex items-center gap-2 mb-2">
                  <Lightbulb className="w-4 h-4 text-primary" />
                  <span className="text-sm font-medium text-primary">Hint {hintsUsed}</span>
                </div>
                <p className="text-sm text-text-secondary">{currentHint}</p>
              </div>
            )}

            {/* Result */}
            {result && (
              <div className={`p-4 rounded-md ${
                result.passed 
                  ? 'bg-accent/10 border border-accent/30' 
                  : 'bg-destructive/10 border border-destructive/30'
              }`}>
                <div className="flex items-center gap-2 mb-2">
                  {result.passed ? (
                    <CheckCircle className="w-5 h-5 text-accent" />
                  ) : (
                    <XCircle className="w-5 h-5 text-destructive" />
                  )}
                  <span className={`font-medium ${result.passed ? 'text-accent' : 'text-destructive'}`}>
                    {result.passed ? `Passed! +${result.stars_earned} stars` : 'Not quite right'}
                  </span>
                </div>
                
                {result.stdout && (
                  <div className="mt-2">
                    <span className="text-xs text-text-secondary">Your output:</span>
                    <pre className="mt-1 p-2 bg-black/30 rounded text-sm font-mono text-white overflow-x-auto">
                      {result.stdout}
                    </pre>
                  </div>
                )}
                
                {result.stderr && (
                  <div className="mt-2">
                    <span className="text-xs text-destructive">Error:</span>
                    <pre className="mt-1 p-2 bg-black/30 rounded text-sm font-mono text-destructive overflow-x-auto">
                      {result.stderr}
                    </pre>
                  </div>
                )}

                {!result.passed && (
                  <div className="mt-2">
                    <span className="text-xs text-text-secondary">Expected output:</span>
                    <pre className="mt-1 p-2 bg-black/30 rounded text-sm font-mono text-accent overflow-x-auto">
                      {result.expected_output}
                    </pre>
                  </div>
                )}
              </div>
            )}

            {/* Actions */}
            <div className="flex items-center justify-between pt-4 border-t border-border">
              <Button 
                variant="ghost" 
                onClick={() => closeChallenge(true)}
                className="text-text-secondary"
              >
                Skip for now
              </Button>
              <Button 
                onClick={submitCode}
                disabled={submitting || result?.passed}
                className="btn-primary"
                data-testid="submit-code-btn"
              >
                {submitting ? (
                  <Loader2 className="w-4 h-4 animate-spin mr-2" />
                ) : (
                  <Play className="w-4 h-4 mr-2" />
                )}
                Run Code
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default Learn;
