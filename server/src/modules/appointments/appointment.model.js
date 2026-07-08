const db = require('../../config/db');

const APPOINTMENT_COLUMNS = `
  id, patient_id, doctor_id, appointment_date, start_time, duration_minutes,
  priority, status, notes, created_by, created_at, updated_at
`;

const UPDATABLE_COLUMNS = {
  appointmentDate: 'appointment_date',
  startTime: 'start_time',
  durationMinutes: 'duration_minutes',
  priority: 'priority',
  notes: 'notes',
};

async function createAppointment({
  patientId,
  doctorId,
  appointmentDate,
  startTime,
  durationMinutes,
  priority,
  notes,
  createdBy,
}) {
  const query = `
    INSERT INTO appointments (
      patient_id, doctor_id, appointment_date, start_time,
      duration_minutes, priority, notes, created_by
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING ${APPOINTMENT_COLUMNS}
  `;
  const values = [
    patientId,
    doctorId,
    appointmentDate,
    startTime,
    durationMinutes ?? 30,
    priority ?? 'normal',
    notes ?? null,
    createdBy,
  ];
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function getAppointmentById(id) {
  const query = `
    SELECT ${APPOINTMENT_COLUMNS}
    FROM appointments
    WHERE id = $1
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function updateAppointment(id, fields) {
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
    return getAppointmentById(id);
  }

  values.push(id);

  const query = `
    UPDATE appointments
    SET ${setClauses.join(', ')}
    WHERE id = $${paramIndex}
    RETURNING ${APPOINTMENT_COLUMNS}
  `;
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function updateAppointmentStatus(id, status) {
  const query = `
    UPDATE appointments
    SET status = $2
    WHERE id = $1
    RETURNING ${APPOINTMENT_COLUMNS}
  `;
  const { rows } = await db.query(query, [id, status]);
  return rows[0] ?? null;
}

async function cancelAppointment(id) {
  const query = `
    UPDATE appointments
    SET status = 'cancelled'
    WHERE id = $1
      AND status != 'cancelled'
    RETURNING ${APPOINTMENT_COLUMNS}
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function listAppointments({
  date,
  doctorId,
  patientId,
  status,
  priority,
  limit,
  offset,
}) {
  const conditions = [];
  const values = [];
  let paramIndex = 1;

  if (date) {
    conditions.push(`appointment_date = $${paramIndex}`);
    values.push(date);
    paramIndex += 1;
  }
  if (doctorId) {
    conditions.push(`doctor_id = $${paramIndex}`);
    values.push(doctorId);
    paramIndex += 1;
  }
  if (patientId) {
    conditions.push(`patient_id = $${paramIndex}`);
    values.push(patientId);
    paramIndex += 1;
  }
  if (status) {
    conditions.push(`status = $${paramIndex}`);
    values.push(status);
    paramIndex += 1;
  }
  if (priority) {
    conditions.push(`priority = $${paramIndex}`);
    values.push(priority);
    paramIndex += 1;
  }

  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  values.push(limit, offset);

  const query = `
    SELECT ${APPOINTMENT_COLUMNS}
    FROM appointments
    ${whereClause}
    ORDER BY appointment_date DESC, start_time DESC
    LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
  `;
  const { rows } = await db.query(query, values);
  return rows;
}

async function getAppointmentCount({ date, doctorId, patientId, status, priority }) {
  const conditions = [];
  const values = [];
  let paramIndex = 1;

  if (date) {
    conditions.push(`appointment_date = $${paramIndex}`);
    values.push(date);
    paramIndex += 1;
  }
  if (doctorId) {
    conditions.push(`doctor_id = $${paramIndex}`);
    values.push(doctorId);
    paramIndex += 1;
  }
  if (patientId) {
    conditions.push(`patient_id = $${paramIndex}`);
    values.push(patientId);
    paramIndex += 1;
  }
  if (status) {
    conditions.push(`status = $${paramIndex}`);
    values.push(status);
    paramIndex += 1;
  }
  if (priority) {
    conditions.push(`priority = $${paramIndex}`);
    values.push(priority);
    paramIndex += 1;
  }

  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM appointments
    ${whereClause}
  `;
  const { rows } = await db.query(query, values);
  return rows[0]?.total ?? 0;
}

async function findConflictingAppointments({
  doctorId,
  appointmentDate,
  startTime,
  durationMinutes,
  excludeAppointmentId,
}) {
  const conditions = [
    'doctor_id = $1',
    'appointment_date = $2',
    "status != 'cancelled'",
    'start_time < ($3::TIME + ($4 || \' minutes\')::INTERVAL)',
    "(start_time + (duration_minutes || ' minutes')::INTERVAL) > $3::TIME",
  ];
  const values = [doctorId, appointmentDate, startTime, durationMinutes];

  if (excludeAppointmentId) {
    conditions.push(`id != $${values.length + 1}`);
    values.push(excludeAppointmentId);
  }

  const query = `
    SELECT ${APPOINTMENT_COLUMNS}
    FROM appointments
    WHERE ${conditions.join(' AND ')}
  `;
  const { rows } = await db.query(query, values);
  return rows;
}

module.exports = {
  createAppointment,
  getAppointmentById,
  updateAppointment,
  updateAppointmentStatus,
  cancelAppointment,
  listAppointments,
  getAppointmentCount,
  findConflictingAppointments,
};