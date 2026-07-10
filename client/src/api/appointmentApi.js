import api from './axios';

export function getAppointments({
  page = 1,
  limit = 10,
  date,
  doctorId,
  patientId,
  status,
  priority,
} = {}) {
  return api.get('/appointments', {
    params: { page, limit, date, doctorId, patientId, status, priority },
  });
}

export function getAppointmentById(id) {
  return api.get(`/appointments/${id}`);
}

export function createAppointment(data) {
  return api.post('/appointments', data);
}

export function updateAppointment(id, data) {
  return api.put(`/appointments/${id}`, data);
}

export function updateAppointmentStatus(id, status) {
  return api.patch(`/appointments/${id}/status`, { status });
}

export function cancelAppointment(id) {
  return api.delete(`/appointments/${id}`);
}
