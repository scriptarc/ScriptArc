import axios from 'axios';

const BACKEND_URL = process.env.REACT_APP_BACKEND_URL;
const API_URL = `${BACKEND_URL}/api`;

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to add auth token
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor for error handling
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// Auth APIs
export const authAPI = {
  register: (data) => api.post('/auth/register', data),
  login: (data) => api.post('/auth/login', data),
  getMe: () => api.get('/auth/me'),
  updateProfile: (data) => api.put('/auth/profile', data),
};

// Course APIs
export const courseAPI = {
  getAll: () => api.get('/courses'),
  getOne: (id) => api.get(`/courses/${id}`),
  create: (data) => api.post('/courses', data),
  enroll: (id) => api.post(`/courses/${id}/enroll`),
  getProgress: (id) => api.get(`/courses/${id}/progress`),
};

// Lesson APIs
export const lessonAPI = {
  getOne: (id) => api.get(`/lessons/${id}`),
  create: (data) => api.post('/lessons', data),
};

// Challenge APIs
export const challengeAPI = {
  getOne: (id) => api.get(`/challenges/${id}`),
  submit: (data) => api.post('/challenges/submit', data),
  getHint: (data) => api.post('/challenges/hint', data),
};

// Dashboard APIs
export const dashboardAPI = {
  get: () => api.get('/dashboard'),
};

// Leaderboard APIs
export const leaderboardAPI = {
  getGlobal: (limit = 20) => api.get(`/leaderboard?limit=${limit}`),
  getCourse: (courseId, limit = 20) => api.get(`/leaderboard/course/${courseId}?limit=${limit}`),
};

// Mentor APIs
export const mentorAPI = {
  getStudents: () => api.get('/mentor/students'),
  assignStudent: (studentId) => api.post(`/mentor/assign/${studentId}`),
  getStudentAnalytics: (studentId) => api.get(`/mentor/student/${studentId}/analytics`),
};

// Certificate APIs
export const certificateAPI = {
  get: (courseId) => api.get(`/certificate/${courseId}`),
};

// Streak APIs
export const streakAPI = {
  update: () => api.post('/streak/update'),
};

// Video APIs
export const videoAPI = {
  upload: (file) => {
    const formData = new FormData();
    formData.append('file', file);
    return api.post('/videos/upload', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
};

// Seed data (for demo)
export const seedAPI = {
  seed: () => api.post('/seed'),
};

export default api;
