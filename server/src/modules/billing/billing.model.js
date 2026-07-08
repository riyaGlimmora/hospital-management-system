const db = require('../../config/db');

const BILLING_COLUMNS = `
  id, bill_number, appointment_id, patient_id, doctor_id,
  total_amount, discount_amount, tax_amount, final_amount,
  payment_status, payment_method, notes, created_by, created_at, updated_at
`;

const UPDATABLE_COLUMNS = {
  totalAmount: 'total_amount',
  discountAmount: 'discount_amount',
  taxAmount: 'tax_amount',
  finalAmount: 'final_amount',
  paymentMethod: 'payment_method',
  notes: 'notes',
};

async function createBill({
  appointmentId,
  patientId,
  doctorId,
  totalAmount,
  discountAmount,
  taxAmount,
  finalAmount,
  paymentMethod,
  notes,
  createdBy,
}) {
  const query = `
    INSERT INTO billing (
      appointment_id, patient_id, doctor_id, total_amount,
      discount_amount, tax_amount, final_amount, payment_method, notes, created_by
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
    RETURNING ${BILLING_COLUMNS}
  `;
  const values = [
    appointmentId,
    patientId,
    doctorId,
    totalAmount,
    discountAmount ?? 0,
    taxAmount ?? 0,
    finalAmount,
    paymentMethod ?? null,
    notes ?? null,
    createdBy,
  ];
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function getBillById(id) {
  const query = `
    SELECT ${BILLING_COLUMNS}
    FROM billing
    WHERE id = $1
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function getBillByBillNumber(billNumber) {
  const query = `
    SELECT ${BILLING_COLUMNS}
    FROM billing
    WHERE bill_number = $1
  `;
  const { rows } = await db.query(query, [billNumber]);
  return rows[0] ?? null;
}

async function updateBill(id, fields) {
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
    return getBillById(id);
  }

  values.push(id);

  const query = `
    UPDATE billing
    SET ${setClauses.join(', ')}
    WHERE id = $${paramIndex}
    RETURNING ${BILLING_COLUMNS}
  `;
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function updatePaymentStatus(id, paymentStatus) {
  const query = `
    UPDATE billing
    SET payment_status = $2
    WHERE id = $1
    RETURNING ${BILLING_COLUMNS}
  `;
  const { rows } = await db.query(query, [id, paymentStatus]);
  return rows[0] ?? null;
}

function buildFilterConditions({ patientId, doctorId, appointmentId, paymentStatus }) {
  const conditions = [];
  const values = [];
  let paramIndex = 1;

  if (patientId) {
    conditions.push(`patient_id = $${paramIndex}`);
    values.push(patientId);
    paramIndex += 1;
  }
  if (doctorId) {
    conditions.push(`doctor_id = $${paramIndex}`);
    values.push(doctorId);
    paramIndex += 1;
  }
  if (appointmentId) {
    conditions.push(`appointment_id = $${paramIndex}`);
    values.push(appointmentId);
    paramIndex += 1;
  }
  if (paymentStatus) {
    conditions.push(`payment_status = $${paramIndex}`);
    values.push(paymentStatus);
    paramIndex += 1;
  }

  return { conditions, values, nextParamIndex: paramIndex };
}

async function listBills({ patientId, doctorId, appointmentId, paymentStatus, limit, offset }) {
  const { conditions, values, nextParamIndex } = buildFilterConditions({
    patientId,
    doctorId,
    appointmentId,
    paymentStatus,
  });

  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  values.push(limit, offset);

  const query = `
    SELECT ${BILLING_COLUMNS}
    FROM billing
    ${whereClause}
    ORDER BY created_at DESC
    LIMIT $${nextParamIndex} OFFSET $${nextParamIndex + 1}
  `;
  const { rows } = await db.query(query, values);
  return rows;
}

async function getBillCount({ patientId, doctorId, appointmentId, paymentStatus }) {
  const { conditions, values } = buildFilterConditions({
    patientId,
    doctorId,
    appointmentId,
    paymentStatus,
  });

  const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

  const query = `
    SELECT COUNT(*)::INT AS total
    FROM billing
    ${whereClause}
  `;
  const { rows } = await db.query(query, values);
  return rows[0]?.total ?? 0;
}

module.exports = {
  createBill,
  getBillById,
  getBillByBillNumber,
  updateBill,
  updatePaymentStatus,
  listBills,
  getBillCount,
};
