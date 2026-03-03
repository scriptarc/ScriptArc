import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { Toaster } from "sonner";
import { AuthProvider, useAuth } from "@/context/AuthContext";
import Navbar from "@/components/Navbar";
import Landing from "@/pages/Landing";
import Auth from "@/pages/Auth";
import Dashboard from "@/pages/Dashboard";
import Courses from "@/pages/Courses";
import CourseSingle from "@/pages/CourseSingle";
import Learn from "@/pages/Learn";
import Leaderboard from "@/pages/Leaderboard";
import Profile from "@/pages/Profile";
import "@/App.css";

// Protected Route component
const ProtectedRoute = ({ children }) => {
  const { user, loading } = useAuth();
  
  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }
  
  if (!user) {
    return <Navigate to="/login" replace />;
  }
  
  return children;
};

// Public Route - redirects to dashboard if logged in
const PublicRoute = ({ children }) => {
  const { user, loading } = useAuth();
  
  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }
  
  if (user) {
    return <Navigate to="/dashboard" replace />;
  }
  
  return children;
};

// Layout with Navbar
const AppLayout = ({ children, showNavbar = true }) => {
  const { user } = useAuth();
  
  return (
    <>
      {showNavbar && user && <Navbar />}
      {children}
    </>
  );
};

function AppRoutes() {
  return (
    <Routes>
      {/* Public Routes */}
      <Route path="/" element={
        <PublicRoute>
          <Landing />
        </PublicRoute>
      } />
      <Route path="/login" element={
        <PublicRoute>
          <Auth />
        </PublicRoute>
      } />
      <Route path="/register" element={
        <PublicRoute>
          <Auth />
        </PublicRoute>
      } />
      
      {/* Protected Routes */}
      <Route path="/dashboard" element={
        <ProtectedRoute>
          <AppLayout>
            <Dashboard />
          </AppLayout>
        </ProtectedRoute>
      } />
      <Route path="/courses" element={
        <ProtectedRoute>
          <AppLayout>
            <Courses />
          </AppLayout>
        </ProtectedRoute>
      } />
      <Route path="/courses/:id" element={
        <ProtectedRoute>
          <AppLayout>
            <CourseSingle />
          </AppLayout>
        </ProtectedRoute>
      } />
      <Route path="/learn/:lessonId" element={
        <ProtectedRoute>
          <AppLayout>
            <Learn />
          </AppLayout>
        </ProtectedRoute>
      } />
      <Route path="/leaderboard" element={
        <ProtectedRoute>
          <AppLayout>
            <Leaderboard />
          </AppLayout>
        </ProtectedRoute>
      } />
      <Route path="/profile" element={
        <ProtectedRoute>
          <AppLayout>
            <Profile />
          </AppLayout>
        </ProtectedRoute>
      } />
      
      {/* Fallback */}
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}

function App() {
  return (
    <div className="App bg-background min-h-screen">
      <BrowserRouter>
        <AuthProvider>
          <AppRoutes />
          <Toaster 
            position="top-right" 
            toastOptions={{
              style: {
                background: '#0A0A14',
                border: '1px solid #1E293B',
                color: '#fff',
              },
            }}
          />
        </AuthProvider>
      </BrowserRouter>
    </div>
  );
}

export default App;
