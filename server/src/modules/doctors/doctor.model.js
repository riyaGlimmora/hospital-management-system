const db = require('../../config/db');

const DOCTOR_COLUMNS = `
  d.id, d.doctor_id, d.full_name, d.specialization, d.department_id,
  dept.name AS department_name, d.phone, d.email, d.qualification,
  d.experience_years, d.consultation_fee, d.gender,
  d.consult_start_time, d.consult_end_time, d.consult_days,
  d.is_active, d.created_at, d.updated_at
`;

const UPDATABLE_COLUMNS = {
  fullName: 'full_name',
  specialization: 'specialization',
  departmentId: 'department_id',
  phone: 'phone',
  email: 'email',
  qualification: 'qualification',
  experienceYears: 'experience_years',
  consultationFee: 'consultation_fee',
  gender: 'gender',
  consultStartTime: 'consult_start_time',
  consultEndTime: 'consult_end_time',
  consultDays: 'consult_days',
};

function serializeConsultDays(consultDays) {
  if (consultDays === undefined) {
    return undefined;
  }
  if (consultDays === null) {
    return null;
  }
  return Array.isArray(consultDays) ? consultDays.join(',') : consultDays;
}

async function createDoctor({
  fullName,
  specialization,
  departmentId,
  phone,
  email,
  qualification,
  experienceYears,
  consultationFee,
  gender,
  consultStartTime,
  consultEndTime,
  consultDays,
}) {
  const query = `
    INSERT INTO doctors (
      full_name, specialization, department_id, phone, email, qualification,
      experience_years, consultation_fee, gender,
      consult_start_time, consult_end_time, consult_days
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
    RETURNING id
  `;
  const values = [
    fullName,
    specialization,
    departmentId,
    phone,
    email,
    qualification,
    experienceYears,
    consultationFee,
    gender,
    consultStartTime,
    consultEndTime,
    serializeConsultDays(consultDays),
  ];
  const { rows } = await db.query(query, values);
  return getDoctorById(rows[0].id, { includeInactive: true });
}

async function getDoctorById(id, { includeInactive = false } = {}) {
  const conditions = ['d.id = $1'];
  if (!includeInactive) {
    conditions.push('d.is_active = TRUE');
  }
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors d
    LEFT JOIN departments dept ON dept.id = d.department_id
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function getDoctorByDoctorId(doctorId, { includeInactive = false } = {}) {
  const conditions = ['d.doctor_id = $1'];
  if (!includeInactive) {
    conditions.push('d.is_active = TRUE');
  }
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors d
    LEFT JOIN departments dept ON dept.id = d.department_id
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
      const value = key === 'consultDays' ? serializeConsultDays(fields[key]) : fields[key];
      setClauses.push(`${column} = $${paramIndex}`);
      values.push(value);
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
    RETURNING id
  `;
  const { rows } = await db.query(query, values);
  if (!rows[0]) {
    return null;
  }
  return getDoctorById(rows[0].id, { includeInactive: true });
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

async function listDoctors({ limit, offset, includeInactive = false, departmentId }) {
  const conditions = [];
  const values = [];
  let paramIndex = 1;

  if (!includeInactive) {
    conditions.push('d.is_active = TRUE');
  }
  if (departmentId) {
    conditions.push(`d.department_id = $${paramIndex}`);
    values.push(departmentId);
    paramIndex += 1;
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  values.push(limit, offset);
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors d
    LEFT JOIN departments dept ON dept.id = d.department_id
    ${whereClause}
    ORDER BY d.created_at DESC
    LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
  `;
  const { rows } = await db.query(query, values);
  return rows;
}

async function searchDoctors({ searchTerm, limit, offset, includeInactive = false, departmentId }) {
  const conditions = [
    '(d.doctor_id ILIKE $1 OR d.full_name ILIKE $1 OR d.specialization ILIKE $1 OR d.phone ILIKE $1)',
  ];
  const values = [`%${searchTerm}%`];
  let paramIndex = 2;

  if (!includeInactive) {
    conditions.push('d.is_active = TRUE');
  }
  if (departmentId) {
    conditions.push(`d.department_id = $${paramIndex}`);
    values.push(departmentId);
    paramIndex += 1;
  }

  values.push(limit, offset);
  const query = `
    SELECT ${DOCTOR_COLUMNS}
    FROM doctors d
    LEFT JOIN departments dept ON dept.id = d.department_id
    WHERE ${conditions.join(' AND ')}
    ORDER BY d.created_at DESC
    LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
  `;
  const { rows } = await db.query(query, values);
  return rows;
}

async function getDoctorCount({ includeInactive = false, departmentId } = {}) {
  const conditions = [];
  const values = [];
  let paramIndex = 1;

  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  if (departmentId) {
    conditions.push(`department_id = $${paramIndex}`);
    values.push(departmentId);
    paramIndex += 1;
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM doctors
    ${whereClause}
  `;
  const { rows } = await db.query(query, values);
  return rows[0]?.total ?? 0;
}

async function getDoctorSearchCount({ searchTerm, includeInactive = false, departmentId }) {
  const conditions = [
    '(doctor_id ILIKE $1 OR full_name ILIKE $1 OR specialization ILIKE $1 OR phone ILIKE $1)',
  ];
  const values = [`%${searchTerm}%`];
  let paramIndex = 2;

  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  if (departmentId) {
    conditions.push(`department_id = $${paramIndex}`);
    values.push(departmentId);
    paramIndex += 1;
  }

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM doctors
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, values);
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