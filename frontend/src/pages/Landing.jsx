import { useNavigate } from 'react-router-dom';
import { BackgroundGradientAnimation } from '@/components/ui/background-gradient-animation';
import { Button } from '@/components/ui/button';
import { 
  Code2, 
  Play, 
  Trophy, 
  Users, 
  Star, 
  CheckCircle,
  ArrowRight,
  Zap,
  Target,
  Award,
  BookOpen,
  Flame
} from 'lucide-react';

const Landing = () => {
  const navigate = useNavigate();

  const features = [
    {
      icon: Play,
      title: "Learn by Doing",
      description: "Video lessons pause at key moments for hands-on coding challenges"
    },
    {
      icon: Zap,
      title: "Real-time Evaluation",
      description: "Code is compiled and tested instantly with Judge0"
    },
    {
      icon: Star,
      title: "Star-Based Scoring",
      description: "Earn 1-5 stars based on attempts and hint usage"
    },
    {
      icon: Trophy,
      title: "Compete & Climb",
      description: "Optional leaderboards to compete with peers"
    },
    {
      icon: Users,
      title: "Mentor Tracking",
      description: "Teachers monitor progress and provide guidance"
    },
    {
      icon: Award,
      title: "Skill Certificates",
      description: "Performance-based certificates that prove mastery"
    },
  ];

  const howItWorks = [
    { step: "01", title: "Watch & Learn", desc: "Engaging video lessons explain concepts clearly" },
    { step: "02", title: "Stop & Solve", desc: "Videos pause automatically for coding challenges" },
    { step: "03", title: "Earn Stars", desc: "Solve challenges to earn stars and climb ranks" },
  ];

  const comparisons = [
    { traditional: "Watch and forget", scriptarc: "Learn and solve immediately" },
    { traditional: "Completion certificate", scriptarc: "5-star skill rating" },
    { traditional: "No accountability", scriptarc: "Mentor dashboard tracking" },
    { traditional: "Solo learning", scriptarc: "Peer competition & gamification" },
  ];

  return (
    <BackgroundGradientAnimation containerClassName="min-h-screen">
      <div className="relative z-10">
        {/* Navbar */}
        <nav className="fixed top-0 w-full z-50 bg-background/60 backdrop-blur-xl border-b border-white/5">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex items-center justify-between h-16">
              <div className="flex items-center gap-2 text-xl font-outfit font-bold">
                <div className="p-2 bg-primary/20 rounded-md">
                  <Code2 className="w-5 h-5 text-primary" />
                </div>
                <span className="text-white">Script<span className="text-primary">Arc</span></span>
              </div>
              <div className="flex items-center gap-3">
                <Button 
                  variant="ghost" 
                  onClick={() => navigate('/login')}
                  className="text-text-secondary hover:text-white"
                  data-testid="landing-login-btn"
                >
                  Login
                </Button>
                <Button 
                  onClick={() => navigate('/register')}
                  className="btn-primary px-4 py-2"
                  data-testid="landing-get-started-btn"
                >
                  Get Started
                </Button>
              </div>
            </div>
          </div>
        </nav>

        {/* Hero Section */}
        <section className="min-h-screen flex items-center justify-center px-4 pt-16" data-testid="hero-section">
          <div className="max-w-4xl mx-auto text-center">
            <div className="inline-flex items-center gap-2 px-4 py-2 bg-surface/50 backdrop-blur-sm rounded-full border border-white/10 mb-8">
              <Flame className="w-4 h-4 text-warning" />
              <span className="text-sm text-text-secondary">Level Up Together</span>
            </div>
            
            <h1 className="text-5xl md:text-7xl font-outfit font-bold text-white mb-6 tracking-tight">
              Stop. Solve.{' '}
              <span className="text-primary text-glow">Succeed.</span>
            </h1>
            
            <p className="text-lg md:text-xl text-text-secondary max-w-2xl mx-auto mb-10 leading-relaxed">
              Transform passive video learning into active coding mastery. 
              Challenges at every checkpoint, stars for every solution.
            </p>
            
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Button 
                onClick={() => navigate('/register')}
                className="btn-primary px-8 py-6 text-lg flex items-center gap-2"
                data-testid="hero-cta-btn"
              >
                Start Learning Free
                <ArrowRight className="w-5 h-5" />
              </Button>
              <Button 
                variant="outline"
                onClick={() => navigate('/courses')}
                className="btn-cyber px-8 py-6 text-lg"
                data-testid="explore-courses-btn"
              >
                Explore Courses
              </Button>
            </div>

            <div className="mt-12 flex items-center justify-center gap-8 text-text-secondary">
              <div className="flex items-center gap-2">
                <CheckCircle className="w-5 h-5 text-accent" />
                <span className="text-sm">50+ Languages</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle className="w-5 h-5 text-accent" />
                <span className="text-sm">Real-time Code Execution</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle className="w-5 h-5 text-accent" />
                <span className="text-sm">Mentor Support</span>
              </div>
            </div>
          </div>
        </section>

        {/* How It Works */}
        <section className="py-24 px-4 bg-surface/30" data-testid="how-it-works-section">
          <div className="max-w-6xl mx-auto">
            <div className="text-center mb-16">
              <h2 className="text-4xl md:text-5xl font-outfit font-semibold text-white mb-4">
                How ScriptArc Works
              </h2>
              <p className="text-text-secondary text-lg max-w-2xl mx-auto">
                A proven method that turns watching into mastering
              </p>
            </div>

            <div className="grid md:grid-cols-3 gap-8">
              {howItWorks.map((item, index) => (
                <div 
                  key={index}
                  className="card-glass p-8 rounded-md hover:-translate-y-1 transition-all"
                  data-testid={`how-step-${index + 1}`}
                >
                  <div className="text-6xl font-outfit font-bold text-primary/20 mb-4">
                    {item.step}
                  </div>
                  <h3 className="text-xl font-outfit font-semibold text-white mb-2">
                    {item.title}
                  </h3>
                  <p className="text-text-secondary">
                    {item.desc}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Features Grid */}
        <section className="py-24 px-4" data-testid="features-section">
          <div className="max-w-6xl mx-auto">
            <div className="text-center mb-16">
              <h2 className="text-4xl md:text-5xl font-outfit font-semibold text-white mb-4">
                Everything You Need to Master Code
              </h2>
              <p className="text-text-secondary text-lg max-w-2xl mx-auto">
                Built for serious learners who want measurable results
              </p>
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              {features.map((feature, index) => (
                <div 
                  key={index}
                  className="card-glass p-6 rounded-md group hover:border-primary/50 transition-all"
                  data-testid={`feature-${index}`}
                >
                  <div className="w-12 h-12 bg-primary/10 rounded-md flex items-center justify-center mb-4 group-hover:bg-primary/20 transition-all">
                    <feature.icon className="w-6 h-6 text-primary" />
                  </div>
                  <h3 className="text-lg font-outfit font-semibold text-white mb-2">
                    {feature.title}
                  </h3>
                  <p className="text-text-secondary text-sm">
                    {feature.description}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Comparison Section */}
        <section className="py-24 px-4 bg-surface/30" data-testid="comparison-section">
          <div className="max-w-4xl mx-auto">
            <div className="text-center mb-16">
              <h2 className="text-4xl md:text-5xl font-outfit font-semibold text-white mb-4">
                Why ScriptArc is Different
              </h2>
              <p className="text-text-secondary text-lg">
                Not just another course platform
              </p>
            </div>

            <div className="card-glass rounded-md overflow-hidden">
              <div className="grid grid-cols-2 bg-surface-highlight">
                <div className="p-4 text-center text-text-secondary font-medium border-r border-border">
                  Traditional Platforms
                </div>
                <div className="p-4 text-center text-primary font-medium">
                  ScriptArc
                </div>
              </div>
              {comparisons.map((item, index) => (
                <div key={index} className="grid grid-cols-2 border-t border-border">
                  <div className="p-4 text-text-secondary text-sm border-r border-border">
                    {item.traditional}
                  </div>
                  <div className="p-4 text-white text-sm flex items-center gap-2">
                    <CheckCircle className="w-4 h-4 text-accent flex-shrink-0" />
                    {item.scriptarc}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="py-24 px-4" data-testid="cta-section">
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-4xl md:text-5xl font-outfit font-semibold text-white mb-6">
              Ready to Level Up?
            </h2>
            <p className="text-text-secondary text-lg mb-10 max-w-xl mx-auto">
              Join thousands of learners who prove their skills through action, not just completion.
            </p>
            <Button 
              onClick={() => navigate('/register')}
              className="btn-primary px-10 py-6 text-lg"
              data-testid="final-cta-btn"
            >
              Get Started for Free
            </Button>
          </div>
        </section>

        {/* Footer */}
        <footer className="py-8 px-4 border-t border-border">
          <div className="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
            <div className="flex items-center gap-2 text-lg font-outfit font-bold">
              <Code2 className="w-5 h-5 text-primary" />
              <span className="text-white">Script<span className="text-primary">Arc</span></span>
            </div>
            <p className="text-text-secondary text-sm">
              © 2024 ScriptArc. Learn. Solve. Succeed.
            </p>
          </div>
        </footer>
      </div>
    </BackgroundGradientAnimation>
  );
};

export default Landing;
