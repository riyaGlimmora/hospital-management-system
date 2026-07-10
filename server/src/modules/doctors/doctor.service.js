const doctorModel = require('./doctor.model');
const appointmentModel = require('../appointments/appointment.model');
const AppError = require('../../utils/AppError');

function toDoctorDto(row) {
  return {
    id: row.id,
    doctorId: row.doctor_id,
    fullName: row.full_name,
    specialization: row.specialization,
    departmentId: row.department_id,
    departmentName: row.department_name ?? null,
    phone: row.phone,
    email: row.email,
    qualification: row.qualification,
    experienceYears: row.experience_years,
    consultationFee: row.consultation_fee,
    gender: row.gender,
    consultStartTime: row.consult_start_time,
    consultEndTime: row.consult_end_time,
    consultDays: row.consult_days ? row.consult_days.split(',') : [],
    isActive: row.is_active,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function normalizeEmail(email) {
  if (email === undefined || email === null || email === '') {
    return email;
  }
  return email.trim().toLowerCase();
}

function buildPaginationMeta({ page, limit, total }) {
  return {
    page,
    limit,
    total,
    totalPages: Math.max(1, Math.ceil(total / limit)),
  };
}

async function createDoctor(data) {
  const doctor = await doctorModel.createDoctor({
    ...data,
    email: normalizeEmail(data.email),
  });
  return toDoctorDto(doctor);
}

async function getDoctor(id, { includeInactive = false } = {}) {
  const doctor = await doctorModel.getDoctorById(id, { includeInactive });
  if (!doctor) {
    throw new AppError('Doctor not found', 404);
  }
  return toDoctorDto(doctor);
}

async function updateDoctor(id, fields) {
  if (!fields || Object.keys(fields).length === 0) {
    throw new AppError('No fields provided for update', 400);
  }

  const existing = await doctorModel.getDoctorById(id, { includeInactive: true });
  if (!existing) {
    throw new AppError('Doctor not found', 404);
  }

  const normalizedFields = { ...fields };
  if (Object.prototype.hasOwnProperty.call(normalizedFields, 'email')) {
    normalizedFields.email = normalizeEmail(normalizedFields.email);
  }

  const updated = await doctorModel.updateDoctor(id, normalizedFields);
  return toDoctorDto(updated);
}

async function deleteDoctor(id) {
  const existing = await doctorModel.getDoctorById(id, { includeInactive: true });
  if (!existing) {
    throw new AppError('Doctor not found', 404);
  }
  if (!existing.is_active) {
    throw new AppError('Doctor is already inactive', 409);
  }

  const hasFutureAppointments = await appointmentModel.hasFutureAppointmentsForDoctor(id);
  if (hasFutureAppointments) {
    throw new AppError(
      'This doctor has upcoming appointments and cannot be deactivated. Cancel or reassign those appointments first.',
      409
    );
  }

  await doctorModel.softDeleteDoctor(id);
  return toDoctorDto({ ...existing, is_active: false });
}

async function listDoctors({ page = 1, limit = 10, includeInactive = false, departmentId } = {}) {
  const offset = (page - 1) * limit;

  const [rows, total] = await Promise.all([
    doctorModel.listDoctors({ limit, offset, includeInactive, departmentId }),
    doctorModel.getDoctorCount({ includeInactive, departmentId }),
  ]);

  return {
    doctors: rows.map(toDoctorDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

async function searchDoctors({ searchTerm, page = 1, limit = 10, includeInactive = false, departmentId }) {
  const offset = (page - 1) * limit;

  const [rows, total] = await Promise.all([
    doctorModel.searchDoctors({ searchTerm, limit, offset, includeInactive, departmentId }),
    doctorModel.getDoctorSearchCount({ searchTerm, includeInactive, departmentId }),
  ]);

  return {
    doctors: rows.map(toDoctorDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

module.exports = {
  createDoctor,
  getDoctor,
  updateDoctor,
  deleteDoctor,
  listDoctors,
  searchDoctors,
};