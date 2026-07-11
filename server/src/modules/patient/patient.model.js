const db = require('../../config/db');

const PATIENT_COLUMNS = `
  id, patient_id, full_name, gender, date_of_birth, phone, email,
  address, blood_group, emergency_contact_name, emergency_contact_phone,
  is_active, created_at, updated_at
`;

const UPDATABLE_COLUMNS = {
  fullName: 'full_name',
  gender: 'gender',
  dateOfBirth: 'date_of_birth',
  phone: 'phone',
  email: 'email',
  address: 'address',
  bloodGroup: 'blood_group',
  emergencyContactName: 'emergency_contact_name',
  emergencyContactPhone: 'emergency_contact_phone',
};

async function findPotentialDuplicate({ fullName, phone, dateOfBirth }) {
  const query = `
    SELECT ${PATIENT_COLUMNS}
    FROM patients
    WHERE is_active = TRUE
      AND LOWER(full_name) = LOWER($1)
      AND (phone = $2 OR date_of_birth = $3)
    LIMIT 1
  `;
  const { rows } = await db.query(query, [fullName, phone, dateOfBirth ?? null]);
  return rows[0] ?? null;
}

async function createPatient({
  fullName,
  gender,
  dateOfBirth,
  phone,
  email,
  address,
  bloodGroup,
  emergencyContactName,
  emergencyContactPhone,
}) {
  const query = `
    INSERT INTO patients (
      full_name, gender, date_of_birth, phone, email,
      address, blood_group, emergency_contact_name, emergency_contact_phone
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    RETURNING ${PATIENT_COLUMNS}
  `;
  const values = [
    fullName,
    gender,
    dateOfBirth,
    phone,
    email ?? null,
    address,
    bloodGroup ?? null,
    emergencyContactName,
    emergencyContactPhone,
  ];
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function getPatientById(id, { includeInactive = false } = {}) {
  const conditions = ['id = $1'];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const query = `
    SELECT ${PATIENT_COLUMNS}
    FROM patients
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function getPatientByPatientId(patientId, { includeInactive = false } = {}) {
  const conditions = ['patient_id = $1'];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const query = `
    SELECT ${PATIENT_COLUMNS}
    FROM patients
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [patientId]);
  return rows[0] ?? null;
}

async function updatePatient(id, fields) {
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
    return getPatientById(id, { includeInactive: true });
  }

  values.push(id);

  const query = `
    UPDATE patients
    SET ${setClauses.join(', ')}
    WHERE id = $${paramIndex}
    RETURNING ${PATIENT_COLUMNS}
  `;
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function softDeletePatient(id) {
  const query = `
    UPDATE patients
    SET is_active = FALSE
    WHERE id = $1
      AND is_active = TRUE
    RETURNING id, is_active
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function listPatients({ limit, offset, includeInactive = false }) {
  const conditions = [];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT ${PATIENT_COLUMNS}
    FROM patients
    ${whereClause}
    ORDER BY created_at DESC
    LIMIT $1 OFFSET $2
  `;
  const { rows } = await db.query(query, [limit, offset]);
  return rows;
}

async function searchPatients({ searchTerm, limit, offset, includeInactive = false }) {
  const conditions = [
    '(patient_id ILIKE $1 OR full_name ILIKE $1 OR phone ILIKE $1)',
  ];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }

  const query = `
    SELECT ${PATIENT_COLUMNS}
    FROM patients
    WHERE ${conditions.join(' AND ')}
    ORDER BY created_at DESC
    LIMIT $2 OFFSET $3
  `;
  const values = [`%${searchTerm}%`, limit, offset];
  const { rows } = await db.query(query, values);
  return rows;
}

async function getPatientCount({ includeInactive = false } = {}) {
  const conditions = [];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }
  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM patients
    ${whereClause}
  `;
  const { rows } = await db.query(query);
  return rows[0]?.total ?? 0;
}

async function getPatientSearchCount({ searchTerm, includeInactive = false }) {
  const conditions = [
    '(patient_id ILIKE $1 OR full_name ILIKE $1 OR phone ILIKE $1)',
  ];
  if (!includeInactive) {
    conditions.push('is_active = TRUE');
  }

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM patients
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, [`%${searchTerm}%`]);
  return rows[0]?.total ?? 0;
}

module.exports = {
  createPatient,
  findPotentialDuplicate,
  getPatientById,
  getPatientByPatientId,
  updatePatient,
  softDeletePatient,
  listPatients,
  searchPatients,
  getPatientCount,
  getPatientSearchCount,
};