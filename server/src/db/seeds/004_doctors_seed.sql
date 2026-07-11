-- =====================================================================
-- Seed: 004_doctors_seed.sql
-- Purpose  : Seeds a realistic set of doctors across departments
--            with consultation-hour schedules.
-- Idempotent: safe to run multiple times (uses ON CONFLICT DO NOTHING).
-- =====================================================================

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Anil Kulkarni', 'Interventional Cardiologist', d.id, '9810000000', 'anil.kulkarni@hospital.test', 'MD, DM Cardiology',
    14, 900, 'Male', '09:00', '13:00', 'Mon,Tue,Wed,Thu,Fri'
FROM departments d WHERE d.name = 'Cardiology'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Sneha Deshpande', 'Cardiac Electrophysiologist', d.id, '9810000001', 'sneha.deshpande@hospital.test', 'MD, DM Cardiology',
    9, 850, 'Female', '14:00', '18:00', 'Mon,Wed,Fri,Sat'
FROM departments d WHERE d.name = 'Cardiology'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Rajesh Patil', 'Joint Replacement Surgeon', d.id, '9810000002', 'rajesh.patil@hospital.test', 'MS Orthopedics',
    16, 800, 'Male', '10:00', '14:00', 'Mon,Tue,Wed,Thu,Fri,Sat'
FROM departments d WHERE d.name = 'Orthopedics'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Kavita Joshi', 'Sports Medicine Specialist', d.id, '9810000003', 'kavita.joshi@hospital.test', 'MS Orthopedics',
    7, 700, 'Female', '15:00', '19:00', 'Tue,Thu,Sat'
FROM departments d WHERE d.name = 'Orthopedics'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Suresh Rao', 'Pediatrician', d.id, '9810000004', 'suresh.rao@hospital.test', 'MD Pediatrics',
    12, 600, 'Male', '09:00', '13:00', 'Mon,Tue,Wed,Thu,Fri,Sat'
FROM departments d WHERE d.name = 'Pediatrics'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Meera Iyer', 'Neonatologist', d.id, '9810000005', 'meera.iyer@hospital.test', 'MD Pediatrics, Fellowship Neonatology',
    10, 750, 'Female', '11:00', '15:00', 'Mon,Wed,Fri'
FROM departments d WHERE d.name = 'Pediatrics'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Vikram Singh', 'Dermatologist', d.id, '9810000006', 'vikram.singh@hospital.test', 'MD Dermatology',
    8, 650, 'Male', '10:00', '14:00', 'Mon,Tue,Thu,Fri'
FROM departments d WHERE d.name = 'Dermatology'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Ananya Bhat', 'Neurologist', d.id, '9810000007', 'ananya.bhat@hospital.test', 'MD, DM Neurology',
    11, 950, 'Female', '09:30', '13:30', 'Mon,Tue,Wed,Fri'
FROM departments d WHERE d.name = 'Neurology'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Prakash Mehta', 'General Physician', d.id, '9810000008', 'prakash.mehta@hospital.test', 'MBBS, MD Medicine',
    18, 500, 'Male', '09:00', '17:00', 'Mon,Tue,Wed,Thu,Fri,Sat'
FROM departments d WHERE d.name = 'General Medicine'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Divya Nair', 'General Physician', d.id, '9810000009', 'divya.nair@hospital.test', 'MBBS, MD Medicine',
    5, 450, 'Female', '13:00', '17:00', 'Mon,Tue,Wed,Thu,Fri'
FROM departments d WHERE d.name = 'General Medicine'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Arvind Menon', 'ENT Surgeon', d.id, '9810000010', 'arvind.menon@hospital.test', 'MS ENT',
    13, 700, 'Male', '10:00', '14:00', 'Mon,Wed,Fri,Sat'
FROM departments d WHERE d.name = 'ENT'
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (
    full_name, specialization, department_id, phone, email, qualification,
    experience_years, consultation_fee, gender, consult_start_time, consult_end_time, consult_days
)
SELECT 'Pooja Chavan', 'Gynecologist & Obstetrician', d.id, '9810000011', 'pooja.chavan@hospital.test', 'MD Obstetrics & Gynecology',
    15, 850, 'Female', '09:00', '13:00', 'Mon,Tue,Wed,Thu,Fri,Sat'
FROM departments d WHERE d.name = 'Gynecology'
ON CONFLICT (email) DO NOTHING;

