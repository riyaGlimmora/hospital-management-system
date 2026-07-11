-- =====================================================================
-- Seed: 006_appointments_seed.sql
-- Purpose  : Seeds a week's worth of appointments (3 days back through
--            3 days ahead) across all seeded doctors, with a realistic
--            mix of statuses and priorities. Dates are relative to
--            CURRENT_DATE so this stays meaningful whenever it runs.
-- Idempotent-ish: guarded by a doctor+patient+date+time uniqueness check.
-- =====================================================================

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:30', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:30', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:30', 30,
    'normal', 'cancelled', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:00', 30,
    'urgent', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:45', 30,
    'normal', 'cancelled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'anil.kulkarni@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '14:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '14:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '15:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '14:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '14:45', 30,
    'urgent', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '15:30', 30,
    'normal', 'cancelled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '14:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '14:45', 30,
    'emergency', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '15:30', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '14:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '14:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '15:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '14:00', 30,
    'normal', 'cancelled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '14:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '15:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '14:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '14:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '15:30', 30,
    'urgent', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '14:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '14:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '14:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '14:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '15:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'sneha.deshpande@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '15:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:30', 30,
    'normal', 'cancelled', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:30', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:00', 30,
    'urgent', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:00', 30,
    'emergency', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'rajesh.patil@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '15:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '15:45', 30,
    'urgent', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '16:30', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '15:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '15:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '16:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '15:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '15:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '16:30', 30,
    'normal', 'cancelled', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '15:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '15:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '16:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '15:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '15:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '16:30', 30,
    'urgent', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '15:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '15:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '16:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '15:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '15:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '15:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '15:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '16:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'kavita.joshi@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '16:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:30', 30,
    'emergency', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:30', 30,
    'normal', 'cancelled', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:00', 30,
    'urgent', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:30', 30,
    'normal', 'cancelled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:45', 30,
    'urgent', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'suresh.rao@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '12:30', 30,
    'normal', 'cancelled', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '12:30', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '12:30', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:45', 30,
    'emergency', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '12:30', 30,
    'urgent', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:45', 30,
    'normal', 'cancelled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '12:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '12:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '12:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'meera.iyer@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '12:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:00', 30,
    'urgent', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:30', 30,
    'normal', 'cancelled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:45', 30,
    'urgent', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:00', 30,
    'emergency', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'vikram.singh@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:15', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:30', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:15', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:00', 30,
    'normal', 'cancelled', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:30', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:15', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:00', 30,
    'urgent', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:30', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:15', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:00', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:30', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:15', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:00', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:30', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:15', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:00', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:30', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:15', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:15'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:00', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'ananya.bhat@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:00', 30,
    'urgent', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:30', 30,
    'normal', 'cancelled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:30', 30,
    'emergency', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:45', 30,
    'urgent', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:00', 30,
    'normal', 'cancelled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'prakash.mehta@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '13:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '13:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '14:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '13:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '13:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '14:30', 30,
    'urgent', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '13:00', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '13:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '14:30', 30,
    'normal', 'cancelled', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '13:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '13:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '14:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '13:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '13:45', 30,
    'emergency', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '14:30', 30,
    'normal', 'cancelled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '13:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '13:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '14:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '13:00', 30,
    'urgent', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '13:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '13:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '13:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '14:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'divya.nair@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '14:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '11:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '11:30', 30,
    'normal', 'cancelled', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:00', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:45', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000007' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '11:30', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000008' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000009' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:45', 30,
    'urgent', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000010' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000011' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000012' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000013' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000014' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000015' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000016' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000017' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000018' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000019' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '11:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000020' AND d.email = 'arvind.menon@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '11:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:00', 30,
    'emergency', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000021' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '09:45', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000022' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-3), '10:30', 30,
    'urgent', 'cancelled', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000023' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-3) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:00', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000024' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '09:45', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000025' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-2), '10:30', 30,
    'normal', 'completed', 'Reported mild symptoms', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000026' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:00', 30,
    'normal', 'completed', 'Prescribed medication and rest', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000027' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '09:45', 30,
    'normal', 'completed', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000028' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (-1), '10:30', 30,
    'normal', 'completed', 'Routine follow-up', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000029' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (-1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:00', 30,
    'normal', 'completed', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000030' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '09:45', 30,
    'normal', 'checked_in', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000031' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (0), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000032' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (0) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000033' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000034' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (1), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000000' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (1) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:00', 30,
    'urgent', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000001' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000002' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (2), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000003' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (2) AND existing.start_time = '10:30'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:00', 30,
    'normal', 'scheduled', 'First visit', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000004' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:00'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '09:45', 30,
    'normal', 'scheduled', 'Follow-up consultation', u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000005' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '09:45'
);

INSERT INTO appointments (
    patient_id, doctor_id, appointment_date, start_time, duration_minutes,
    priority, status, notes, created_by
)
SELECT p.id, d.id, CURRENT_DATE + (3), '10:30', 30,
    'normal', 'scheduled', NULL, u.id
FROM patients p, doctors d, users u
WHERE p.phone = '9710000006' AND d.email = 'pooja.chavan@hospital.test' AND u.email = 'admin@hospital.test'
AND NOT EXISTS (
    SELECT 1 FROM appointments existing
    WHERE existing.doctor_id = d.id AND existing.patient_id = p.id
    AND existing.appointment_date = CURRENT_DATE + (3) AND existing.start_time = '10:30'
);

