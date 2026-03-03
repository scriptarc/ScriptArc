import { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { toast } from 'sonner';
import { Code2, ArrowLeft, Loader2 } from 'lucide-react';
import { Link } from 'react-router-dom';

const Auth = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { login, register } = useAuth();
  
  const isRegisterPage = location.pathname === '/register';
  const [activeTab, setActiveTab] = useState(isRegisterPage ? 'register' : 'login');
  const [loading, setLoading] = useState(false);
  
  const [loginData, setLoginData] = useState({ email: '', password: '' });
  const [registerData, setRegisterData] = useState({ 
    name: '', 
    email: '', 
    password: '', 
    confirmPassword: '',
    role: 'student'
  });

  const handleLogin = async (e) => {
    e.preventDefault();
    if (!loginData.email || !loginData.password) {
      toast.error('Please fill in all fields');
      return;
    }

    setLoading(true);
    try {
      await login(loginData.email, loginData.password);
      toast.success('Welcome back!');
      navigate('/dashboard');
    } catch (error) {
      toast.error(error.response?.data?.detail || 'Login failed');
    } finally {
      setLoading(false);
    }
  };

  const handleRegister = async (e) => {
    e.preventDefault();
    if (!registerData.name || !registerData.email || !registerData.password) {
      toast.error('Please fill in all fields');
      return;
    }
    if (registerData.password !== registerData.confirmPassword) {
      toast.error('Passwords do not match');
      return;
    }
    if (registerData.password.length < 6) {
      toast.error('Password must be at least 6 characters');
      return;
    }

    setLoading(true);
    try {
      await register(registerData.name, registerData.email, registerData.password, registerData.role);
      toast.success('Account created successfully!');
      navigate('/dashboard');
    } catch (error) {
      toast.error(error.response?.data?.detail || 'Registration failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div 
      className="min-h-screen flex items-center justify-center px-4 py-12 bg-cover bg-center"
      style={{ 
        backgroundImage: 'linear-gradient(rgba(5, 5, 15, 0.9), rgba(5, 5, 15, 0.95)), url(https://images.unsplash.com/photo-1771875802933-96402f31a45a?w=1920)',
      }}
      data-testid="auth-page"
    >
      <div className="w-full max-w-md">
        {/* Back Button */}
        <Link 
          to="/" 
          className="inline-flex items-center gap-2 text-text-secondary hover:text-white mb-8 transition-colors"
          data-testid="back-to-home"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to home
        </Link>

        {/* Logo */}
        <div className="flex items-center gap-2 text-2xl font-outfit font-bold mb-8">
          <div className="p-2 bg-primary/20 rounded-md">
            <Code2 className="w-6 h-6 text-primary" />
          </div>
          <span className="text-white">Script<span className="text-primary">Arc</span></span>
        </div>

        <Card className="bg-surface/80 backdrop-blur-xl border-white/10">
          <Tabs value={activeTab} onValueChange={setActiveTab}>
            <TabsList className="grid w-full grid-cols-2 bg-surface-highlight">
              <TabsTrigger 
                value="login"
                className="data-[state=active]:bg-primary data-[state=active]:text-white"
                data-testid="login-tab"
              >
                Login
              </TabsTrigger>
              <TabsTrigger 
                value="register"
                className="data-[state=active]:bg-primary data-[state=active]:text-white"
                data-testid="register-tab"
              >
                Register
              </TabsTrigger>
            </TabsList>

            {/* Login Form */}
            <TabsContent value="login">
              <form onSubmit={handleLogin}>
                <CardHeader>
                  <CardTitle className="text-white font-outfit">Welcome back</CardTitle>
                  <CardDescription className="text-text-secondary">
                    Enter your credentials to continue learning
                  </CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="login-email" className="text-text-secondary">Email</Label>
                    <Input
                      id="login-email"
                      type="email"
                      placeholder="you@example.com"
                      value={loginData.email}
                      onChange={(e) => setLoginData({ ...loginData, email: e.target.value })}
                      className="input-dark"
                      data-testid="login-email"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="login-password" className="text-text-secondary">Password</Label>
                    <Input
                      id="login-password"
                      type="password"
                      placeholder="••••••••"
                      value={loginData.password}
                      onChange={(e) => setLoginData({ ...loginData, password: e.target.value })}
                      className="input-dark"
                      data-testid="login-password"
                    />
                  </div>
                  <Button 
                    type="submit" 
                    className="w-full btn-primary py-5"
                    disabled={loading}
                    data-testid="login-submit"
                  >
                    {loading ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      'Login'
                    )}
                  </Button>
                </CardContent>
              </form>
            </TabsContent>

            {/* Register Form */}
            <TabsContent value="register">
              <form onSubmit={handleRegister}>
                <CardHeader>
                  <CardTitle className="text-white font-outfit">Create account</CardTitle>
                  <CardDescription className="text-text-secondary">
                    Start your coding journey today
                  </CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="register-name" className="text-text-secondary">Name</Label>
                    <Input
                      id="register-name"
                      type="text"
                      placeholder="John Doe"
                      value={registerData.name}
                      onChange={(e) => setRegisterData({ ...registerData, name: e.target.value })}
                      className="input-dark"
                      data-testid="register-name"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="register-email" className="text-text-secondary">Email</Label>
                    <Input
                      id="register-email"
                      type="email"
                      placeholder="you@example.com"
                      value={registerData.email}
                      onChange={(e) => setRegisterData({ ...registerData, email: e.target.value })}
                      className="input-dark"
                      data-testid="register-email"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="register-password" className="text-text-secondary">Password</Label>
                    <Input
                      id="register-password"
                      type="password"
                      placeholder="••••••••"
                      value={registerData.password}
                      onChange={(e) => setRegisterData({ ...registerData, password: e.target.value })}
                      className="input-dark"
                      data-testid="register-password"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="register-confirm" className="text-text-secondary">Confirm Password</Label>
                    <Input
                      id="register-confirm"
                      type="password"
                      placeholder="••••••••"
                      value={registerData.confirmPassword}
                      onChange={(e) => setRegisterData({ ...registerData, confirmPassword: e.target.value })}
                      className="input-dark"
                      data-testid="register-confirm"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-text-secondary">I am a</Label>
                    <div className="grid grid-cols-2 gap-3">
                      <button
                        type="button"
                        onClick={() => setRegisterData({ ...registerData, role: 'student' })}
                        className={`p-3 rounded-md border text-sm font-medium transition-all ${
                          registerData.role === 'student'
                            ? 'bg-primary/20 border-primary text-primary'
                            : 'bg-surface-highlight border-border text-text-secondary hover:border-white/20'
                        }`}
                        data-testid="role-student"
                      >
                        Student
                      </button>
                      <button
                        type="button"
                        onClick={() => setRegisterData({ ...registerData, role: 'mentor' })}
                        className={`p-3 rounded-md border text-sm font-medium transition-all ${
                          registerData.role === 'mentor'
                            ? 'bg-primary/20 border-primary text-primary'
                            : 'bg-surface-highlight border-border text-text-secondary hover:border-white/20'
                        }`}
                        data-testid="role-mentor"
                      >
                        Mentor
                      </button>
                    </div>
                  </div>
                  <Button 
                    type="submit" 
                    className="w-full btn-primary py-5"
                    disabled={loading}
                    data-testid="register-submit"
                  >
                    {loading ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      'Create Account'
                    )}
                  </Button>
                </CardContent>
              </form>
            </TabsContent>
          </Tabs>
        </Card>
      </div>
    </div>
  );
};

export default Auth;
