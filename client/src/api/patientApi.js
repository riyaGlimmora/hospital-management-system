import api from './axios';

export function getPatients({ page = 1, limit = 10, includeInactive = false } = {}) {
  return api.get('/patients', {
    params: { page, limit, includeInactive },
  });
}

export function searchPatients({ search, page = 1, limit = 10, includeInactive = false }) {
  return api.get('/patients/search', {
    params: { search, page, limit, includeInactive },
  });
}

export function getPatientById(id, { includeInactive = false } = {}) {
  return api.get(`/patients/${id}`, {
    params: { includeInactive },
  });
}

export function createPatient(data) {
  return api.post('/patients', data);
}

export function updatePatient(id, data) {
  return api.put(`/patients/${id}`, data);
}

export function deletePatient(id) {
  return api.delete(`/patients/${id}`);
}