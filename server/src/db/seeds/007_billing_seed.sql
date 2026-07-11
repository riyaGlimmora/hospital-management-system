-- =====================================================================
-- Seed: 007_billing_seed.sql
-- Purpose  : Seeds bills for completed appointments, consistent with
--            the app's own rule that only checked-in/completed
--            appointments can be billed, and one bill per appointment.
-- Idempotent-ish: guarded by NOT EXISTS on billing.appointment_id.
-- =====================================================================

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 90,
    41, 851, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000000' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000001' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000002' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000003' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000004' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000005' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000006' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 90,
    41, 851, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000007' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 900, 0,
    45, 945, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000009' AND d.email = 'anil.kulkarni@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000021' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '14:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000022' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '14:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000023' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '15:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000024' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '14:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000025' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '14:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 85,
    38, 803, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000027' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '14:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000028' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '14:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000029' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '15:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000030' AND d.email = 'sneha.deshpande@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '14:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000007' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000008' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000010' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 80,
    36, 756, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000011' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000012' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000013' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000014' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000015' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 800, 0,
    40, 840, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000016' AND d.email = 'rajesh.patil@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000028' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '15:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 70,
    32, 662, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000029' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '15:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000030' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '16:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000031' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '15:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000032' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '15:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000033' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '16:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000034' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '15:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000000' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '15:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 70,
    32, 662, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000002' AND d.email = 'kavita.joshi@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '15:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000014' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000015' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000016' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000017' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000018' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000020' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 60,
    27, 567, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000021' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000022' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 600, 0,
    30, 630, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000023' AND d.email = 'suresh.rao@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000000' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000001' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '11:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000003' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000004' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '11:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 75,
    34, 709, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000005' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '12:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000006' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000007' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '11:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000008' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '12:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 750, 0,
    38, 788, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000009' AND d.email = 'meera.iyer@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000021' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000022' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 65,
    29, 614, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000023' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000024' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000025' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000026' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000027' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000028' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 650, 0,
    33, 683, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000030' AND d.email = 'vikram.singh@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 95,
    43, 898, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000007' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000008' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:15'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000009' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000010' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000011' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:15'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000013' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000014' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:15'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 95,
    43, 898, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000015' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '11:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 950, 0,
    48, 998, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000016' AND d.email = 'ananya.bhat@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '09:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000028' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000029' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000031' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000032' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000033' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 50,
    23, 473, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000034' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000000' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000001' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 500, 0,
    25, 525, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000002' AND d.email = 'prakash.mehta@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000014' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '13:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000015' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '13:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000016' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '14:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 45,
    20, 425, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000017' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '13:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000018' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '13:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000019' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '14:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000020' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '13:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000021' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '13:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 450, 0,
    23, 473, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000023' AND d.email = 'divya.nair@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '13:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000000' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 70,
    32, 662, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000001' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000002' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000003' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000004' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000006' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000007' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 0,
    35, 735, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000008' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '11:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 700, 70,
    32, 662, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000009' AND d.email = 'arvind.menon@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '10:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000021' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000022' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-3) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000024' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'cash', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000025' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000026' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-2) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000027' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 85,
    38, 803, 'pending', NULL, u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000028' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '09:45'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'card', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000029' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (-1) AND a.start_time = '10:30'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

INSERT INTO billing (
    appointment_id, patient_id, doctor_id, total_amount, discount_amount,
    tax_amount, final_amount, payment_status, payment_method, created_by
)
SELECT a.id, a.patient_id, a.doctor_id, 850, 0,
    43, 893, 'paid', 'upi', u.id
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN users u ON u.email = 'admin@hospital.test'
WHERE p.phone = '9710000030' AND d.email = 'pooja.chavan@hospital.test'
  AND a.appointment_date = CURRENT_DATE + (0) AND a.start_time = '09:00'
  AND NOT EXISTS (SELECT 1 FROM billing b WHERE b.appointment_id = a.id);

