import axiosInstance from './axios';

export const authApi = {
  login: async (credentials) => {
    const response = await axiosInstance.post('/api/v1/auth/login', credentials);
    return response.data;
  },
};