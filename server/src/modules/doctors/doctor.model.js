const db = require('../../config/db');

const DOCTOR_COLUMNS = `
  id, doctor_id, full_name, specialization, phone, email, qualification,
  experience_years, consultation_fee, gender, is_active, created_at, updated_at
`;

const UPDATABLE_COLUMNS = {
  fullName: 'full_name',
  specialization: 'specialization',
  phone: 'phone',
  email: 'email',
  qualification: 'qualification',
  experienceYears: 'experience_years',
  consultationFee: 'consultation_fee',
  gender: 'gender',
};

async function createDoctor({
  fullName,
  specialization,
  phone,
  email,
  qualification,
  experienceYears,
  consultationFee,
  gender,
}) {
  const query = `
    INSERT INTO doctors (
      full_name, specialization, phone, email, qualification,
      experience_years, consultation_fee, gender
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING ${DOCTOR_COLUMNS}
  `;
  const values = [
    fullName,
    specialization,
    phone,
    email,
    qualification,
    experienceYears,
    consultationFee,
    gender,
  ];
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function getDoctorById(id, { includeInactive = false } = {}) {
  const conditions = ['id = $1'];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function getDoctorByDoctorId(doctorId, { includeInactive = false } = {}) {
  const conditions = ['doctor_id = $1'];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [doctorId]);
  return rows[0] ?? null;
}

async function updateDoctor(id, fields) {
  const setClauses = [];
  const values = [];
  let paramIndex = 1;

  for (const [key, column] of Object.entries(UPDATABLE_COLUMNS)) {
    if (Object.prototype.hasOwnProperty.call(fields, key)) {
      setClauses.push(`${column} = $${paramIndex}`);
      values.push(fields[key]);
      paramIndex += 1;
    }
  }

  if (setClauses.length === 0) {
    return getDoctorById(id, { includeInactive: true });
  }

  values.push(id);

  const query = `
    UPDATE doctors
    SET ${setClauses.join(', ')}
    WHERE id = $${paramIndex}
    RETURNING ${DOCTOR_COLUMNS}
  `;
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function softDeleteDoctor(id) {
  const query = `
    UPDATE doctors
    SET is_active = FALSE
    WHERE id = $1
      AND is_active = TRUE
    RETURNING id, is_active
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function listDoctors({ limit, offset, includeInactive = false }) {
  const conditions = [];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors
    ${whereClause}
    ORDER BY created_at DESC
    LIMIT $1 OFFSET $2
  `;
  const { rows } = await db.query(query, [limit, offset]);
  return rows;
}

async function searchDoctors({ searchTerm, limit, offset, includeInactive = false }) {
  const conditions = [
    '(doctor_id ILIKE $1 OR full_name ILIKE $1 OR specialization ILIKE $1 OR phone ILIKE $1)',
  ];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }

  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors
    WHERE ${conditions.join(' AND ')}
    ORDER BY created_at DESC
    LIMIT $2 OFFSET $3
  `;
  const values = [`%${searchTerm}%`, limit, offset];
  const { rows } = await db.query(query, values);
  return rows;
}

async function getDoctorCount({ includeInactive = false } = {}) {
  const conditions = [];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM doctors
    ${whereClause}
  `;
  const { rows } = await db.query(query);
  return rows[0]?.total ?? 0;
}

async function getDoctorSearchCount({ searchTerm, includeInactive = false }) {
  const conditions = [
    '(doctor_id ILIKE $1 OR full_name ILIKE $1 OR specialization ILIKE $1 OR phone ILIKE $1)',
  ];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM doctors
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [`%${searchTerm}%`]);
  return rows[0]?.total ?? 0;
}

module.exports = {
  createDoctor,
  getDoctorById,
  getDoctorByDoctorId,
  updateDoctor,
  softDeleteDoctor,
  listDoctors,
  searchDoctors,
  getDoctorCount,
  getDoctorSearchCount,
};