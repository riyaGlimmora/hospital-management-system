const billingModel = require('./billing.model');
const appointmentModel = require('../appointments/appointment.model');
const AppError = require('../../utils/AppError');

const BILLABLE_APPOINTMENT_STATUSES = ['checked_in', 'completed'];

function toBillDto(row) {
  return {
    id: row.id,
    billNumber: row.bill_number,
    appointmentId: row.appointment_id,
    patientId: row.patient_id,
    doctorId: row.doctor_id,
    totalAmount: row.total_amount,
    discountAmount: row.discount_amount,
    taxAmount: row.tax_amount,
    finalAmount: row.final_amount,
    paymentStatus: row.payment_status,
    paymentMethod: row.payment_method,
    notes: row.notes,
    createdBy: row.created_by,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function normalizePaymentMethod(paymentMethod) {
  if (paymentMethod === undefined) {
    return undefined;
  }
  if (paymentMethod === '') {
    return null;
  }
  return paymentMethod;
}

function buildPaginationMeta({ page, limit, total }) {
  return {
    page,
    limit,
    total,
    totalPages: Math.max(1, Math.ceil(total / limit)),
  };
}

async function createBill(data) {
  const appointment = await appointmentModel.getAppointmentById(data.appointmentId);
  if (!appointment) {
    throw new AppError('Appointment not found', 404);
  }

  if (!BILLABLE_APPOINTMENT_STATUSES.includes(appointment.status)) {
    throw new AppError(
      'A bill can only be generated once the appointment is checked-in or completed',
      409
    );
  }

  const existingBill = await billingModel.getBillByAppointmentId(data.appointmentId);
  if (existingBill) {
    throw new AppError('A bill has already been generated for this appointment', 409);
  }

  try {
    const bill = await billingModel.createBill({
      ...data,
      paymentMethod: normalizePaymentMethod(data.paymentMethod),
    });
    return toBillDto(bill);
  } catch (error) {
    if (error.code === '23505') {
      throw new AppError('A bill has already been generated for this appointment', 409);
    }
    throw error;
  }
}

async function getBill(id) {
  const bill = await billingModel.getBillById(id);
  if (!bill) {
    throw new AppError('Bill not found', 404);
  }
  return toBillDto(bill);
}

async function updateBill(id, fields) {
  if (!fields || Object.keys(fields).length === 0) {
    throw new AppError('No fields provided for update', 400);
  }

  const existing = await billingModel.getBillById(id);
  if (!existing) {
    throw new AppError('Bill not found', 404);
  }

  const normalizedFields = { ...fields };
  if (Object.prototype.hasOwnProperty.call(normalizedFields, 'paymentMethod')) {
    normalizedFields.paymentMethod = normalizePaymentMethod(normalizedFields.paymentMethod);
  }

  const updated = await billingModel.updateBill(id, normalizedFields);
  return toBillDto(updated);
}

async function updatePaymentStatus(id, paymentStatus) {
  const existing = await billingModel.getBillById(id);
  if (!existing) {
    throw new AppError('Bill not found', 404);
  }

  const updated = await billingModel.updatePaymentStatus(id, paymentStatus);
  return toBillDto(updated);
}

async function listBills({
  page = 1,
  limit = 10,
  patientId,
  doctorId,
  appointmentId,
  paymentStatus,
} = {}) {
  const offset = (page - 1) * limit;
  const filters = { patientId, doctorId, appointmentId, paymentStatus };

  const [rows, total] = await Promise.all([
    billingModel.listBills({ ...filters, limit, offset }),
    billingModel.getBillCount(filters),
  ]);

  return {
    bills: rows.map(toBillDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

module.exports = {
  createBill,
  getBill,
  updateBill,
  updatePaymentStatus,
  listBills,
};