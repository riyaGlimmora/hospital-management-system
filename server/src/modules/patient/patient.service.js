const patientModel = require('./patient.model');
const AppError = require('../../utils/AppError');

function toPatientDto(row) {
  return {
    id: row.id,
    patientId: row.patient_id,
    fullName: row.full_name,
    gender: row.gender,
    dateOfBirth: row.date_of_birth,
    phone: row.phone,
    email: row.email,
    address: row.address,
    bloodGroup: row.blood_group,
    emergencyContactName: row.emergency_contact_name,
    emergencyContactPhone: row.emergency_contact_phone,
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

async function createPatient(data) {
  const patient = await patientModel.createPatient({
    ...data,
    email: normalizeEmail(data.email),
  });
  return toPatientDto(patient);
}

async function getPatient(id, { includeInactive = false } = {}) {
  const patient = await patientModel.getPatientById(id, { includeInactive });
  if (!patient) {
    throw new AppError('Patient not found', 404);
  }
  return toPatientDto(patient);
}

async function updatePatient(id, fields) {
  if (!fields || Object.keys(fields).length === 0) {
    throw new AppError('No fields provided for update', 400);
  }

  const existing = await patientModel.getPatientById(id, { includeInactive: true });
  if (!existing) {
    throw new AppError('Patient not found', 404);
  }

  const normalizedFields = { ...fields };
  if (Object.prototype.hasOwnProperty.call(normalizedFields, 'email')) {
    normalizedFields.email = normalizeEmail(normalizedFields.email);
  }

  const updated = await patientModel.updatePatient(id, normalizedFields);
  return toPatientDto(updated);
}

async function deletePatient(id) {
  const existing = await patientModel.getPatientById(id, { includeInactive: true });
  if (!existing) {
    throw new AppError('Patient not found', 404);
  }
  if (!existing.is_active) {
    throw new AppError('Patient is already inactive', 409);
  }

  const deleted = await patientModel.softDeletePatient(id);
  return toPatientDto(deleted ? { ...existing, is_active: false } : existing);
}

async function listPatients({ page = 1, limit = 10, includeInactive = false } = {}) {
  const offset = (page - 1) * limit;

  const [rows, total] = await Promise.all([
    patientModel.listPatients({ limit, offset, includeInactive }),
    patientModel.getPatientCount({ includeInactive }),
  ]);

  return {
    patients: rows.map(toPatientDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

async function searchPatients({ searchTerm, page = 1, limit = 10, includeInactive = false }) {
  const offset = (page - 1) * limit;

  const [rows, total] = await Promise.all([
    patientModel.searchPatients({ searchTerm, limit, offset, includeInactive }),
    patientModel.getPatientSearchCount({ searchTerm, includeInactive }),
  ]);

  return {
    patients: rows.map(toPatientDto),
    meta: buildPaginationMeta({ page, limit, total }),
  };
}

module.exports = {
  createPatient,
  getPatient,
  updatePatient,
  deletePatient,
  listPatients,
  searchPatients,
};