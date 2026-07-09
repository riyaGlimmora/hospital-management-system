import api from './axios';

export function getDoctors({ page = 1, limit = 10, includeInactive = false } = {}) {
  return api.get('/doctors', {
    params: { page, limit, includeInactive },
  });
}

export function searchDoctors({ search, page = 1, limit = 10, includeInactive = false }) {
  return api.get('/doctors/search', {
    params: { search, page, limit, includeInactive },
  });
}

export function getDoctorById(id, { includeInactive = false } = {}) {
  return api.get(`/doctors/${id}`, {
    params: { includeInactive },
  });
}

export function createDoctor(data) {
  return api.post('/doctors', data);
}

export function updateDoctor(id, data) {
  return api.put(`/doctors/${id}`, data);
}

export function deleteDoctor(id) {
  return api.delete(`/doctors/${id}`);
}