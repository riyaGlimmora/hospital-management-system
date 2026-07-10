import api from './axios';

export function getBills({
  page = 1,
  limit = 10,
  patientId,
  doctorId,
  appointmentId,
  paymentStatus,
} = {}) {
  return api.get('/billing', {
    params: { page, limit, patientId, doctorId, appointmentId, paymentStatus },
  });
}

export function getBillById(id) {
  return api.get(`/billing/${id}`);
}

export function createBill(data) {
  return api.post('/billing', data);
}

export function updateBill(id, data) {
  return api.put(`/billing/${id}`, data);
}

export function updatePaymentStatus(id, paymentStatus) {
  return api.patch(`/billing/${id}/payment-status`, { paymentStatus });
}
