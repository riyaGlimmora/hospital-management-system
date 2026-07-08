const appointmentModel = require('./appointment.model');
const AppError = require('../../utils/AppError');

function toAppointmentDto(row) {
  return {
    id: row.id,
    patientId: row.patient_id,
    doctorId: row.doctor_id,
    appointmentDate: row.appointment_date,
    startTime: row.start_time,
    durationMinutes: row.duration_minutes,
    priority: row.priority,
    status: row.status,
    notes: row.notes,
    createdBy: row.created_by,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function buildPaginationMeta({ page, limit, total }) {
  return {
    page,
    limit,
    total,
    totalPages: Math.max(1, Math.ceil(total / limit)),
  };
}

async function ensureNoConflict({
  doctorId,
  appointmentDate,
  startTime,
  durationMinutes,
  excludeAppointmentId,
}) {
  const conflicts = await appointmentModel.findConflictingAppointments({
    doctorId,
    appointmentDate,
    startTime,
    durationMinutes,
    excludeAppointmentId,
  });

  if (conflicts.length > 0) {
    throw new AppError('This doctor already has an appointment during the requested time', 409);
  }
}

async function createAppointment(data) {
  await ensureNoConflict({
    doctorId: data.doctorId,
    appointmentDate: data.appointmentDate,
    startTime: data.startTime,
    durationMinutes: data.durationMinutes ?? 30,
  });

  const appointment = await appointmentModel.createAppointment(data);
  return toAppointmentDto(appointment);
}

async function getAppointment(id) {
  const appointment = await appointmentModel.getAppointmentById(id);
  if (!appointment) {
    throw new AppError('Appointment not found', 404);
  }
  return toAppointmentDto(appointment);
}

async function updateAppointment(id, fields) {
  if (!fields || Object.keys(fields).length === 0) {
    throw new AppError('No fields provided for update', 400);
  }

  const existing = await appointmentModel.getAppointmentById(id);
  if (!existing) {
    throw new AppError('Appointment not found', 404);
  }

  const effectiveDoctorId = existing.doctor_id;
  const effectiveDate = fields.appointmentDate ?? existing.appointment_date;
  const effectiveStartTime = fields.startTime ?? existing.start_time;
  const effectiveDuration = fields.durationMinutes ?? existing.duration_minutes;

  await ensureNoConflict({
    doctorId: effectiveDoctorId,
    appointmentDate: effectiveDate,
    startTime: effectiveStartTime,
    durationMinutes: effectiveDuration,
    excludeAppointmentId: id,
  });

  const updated = await appointmentModel.updateAppointment(id, fields);
  return toAppointmentDto(updated);
}

async function updateAppointmentStatus(id, status) {
  const existing = await appointmentModel.getAppointmentById(id);
  if (!existing) {
    throw new AppError('Appointment not found', 404);
  }

  const updated = await appointmentModel.updateAppointmentStatus(id, status);
  return toAppointmentDto(updated);
}

async function cancelAppointment(id) {
  const existing = await appointmentModel.getAppointmentById(id);
  if (!existing) {
    throw new AppError('Appointment not found', 404);
  }
  if (existing.status === 'cancelled') {
    throw new AppError('Appointment is already cancelled', 409);
  }

  const cancelled = await appointmentModel.cancelAppointment(id);
  return toAppointmentDto(cancelled);
}

async function listAppointments({
  page = 1,
  limit = 10,
  date,
  doctorId,
  patientId,
  status,
  priority,
} = {}) {
  const offset = (page - 1) * limit;
  const filters = { date, doctorId, patientId, status, priority };

  const [rows, total] = await Promise.all([
    appointmentModel.listAppointments({ ...filters, limit, offset }),
    appointmentModel.getAppointmentCount(filters),
  ]);

  return {
    appointments: rows.map(toAppointmentDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

module.exports = {
  createAppointment,
  getAppointment,
  updateAppointment,
  updateAppointmentStatus,
  cancelAppointment,
  listAppointments,
};