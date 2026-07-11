-- =====================================================================
-- Seed: 005_patients_seed.sql
-- Purpose  : Seeds a realistic set of patients for demo/testing.
-- Idempotent-ish: guarded by phone number, which this seed keeps unique.
-- =====================================================================

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Rohan Deshpande', 'Male', '2022-01-01', '9710000000', 'rohan.deshpande0@example.test', '100, MG Road, Pune, Maharashtra',
    'B+', 'Kavya Deshpande', '9620000000'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000000');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Neha Patil', 'Female', '2015-02-02', '9710000001', 'neha.patil1@example.test', '101, FC Road, Pune, Maharashtra',
    'B-', 'Rahul Patil', '9620000001'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000001');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Vivek Joshi', 'Male', '2008-03-03', '9710000002', 'vivek.joshi2@example.test', '102, Karve Nagar, Pune, Maharashtra',
    'AB+', 'Aarti Joshi', '9620000002'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000002');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sunita Kale', 'Female', '2001-04-04', '9710000003', 'sunita.kale3@example.test', '103, Kothrud, Pune, Maharashtra',
    'AB-', 'Sanjay Kale', '9620000003'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000003');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sameer More', 'Male', '1994-05-05', '9710000004', 'sameer.more4@example.test', '104, Baner Road, Pune, Maharashtra',
    'O+', 'Swati More', '9620000004'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000004');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Kavya Shinde', 'Female', '1987-06-06', '9710000005', 'kavya.shinde5@example.test', '105, Aundh, Pune, Maharashtra',
    'O-', 'Deepak Shinde', '9620000005'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000005');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Rahul Gaikwad', 'Male', '1980-07-07', '9710000006', 'rahul.gaikwad6@example.test', '106, Viman Nagar, Pune, Maharashtra',
    'A+', 'Radha Gaikwad', '9620000006'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000006');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Aarti Pawar', 'Female', '1973-08-08', '9710000007', 'aarti.pawar7@example.test', '107, Hadapsar, Pune, Maharashtra',
    'A-', 'Ganesh Pawar', '9620000007'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000007');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sanjay Jadhav', 'Male', '1966-09-09', '9710000008', 'sanjay.jadhav8@example.test', '108, Wakad, Pune, Maharashtra',
    'B+', 'Vaishali Jadhav', '9620000008'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000008');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Swati Kadam', 'Female', '1959-10-10', '9710000009', 'swati.kadam9@example.test', '109, Hinjewadi, Pune, Maharashtra',
    'B-', 'Sunil Kadam', '9620000009'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000009');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Deepak Chavan', 'Male', '1952-11-11', '9710000010', 'deepak.chavan10@example.test', '110, Kharadi, Pune, Maharashtra',
    'AB+', 'Madhuri Chavan', '9620000010'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000010');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Radha Bhosale', 'Female', '1945-12-12', '9710000011', 'radha.bhosale11@example.test', '111, Shivaji Nagar, Pune, Maharashtra',
    'AB-', 'Yash Bhosale', '9620000011'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000011');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Ganesh Wagh', 'Male', '2017-01-13', '9710000012', 'ganesh.wagh12@example.test', '112, MG Road, Pune, Maharashtra',
    'O+', 'Riya Wagh', '9620000012'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000012');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Vaishali Naik', 'Female', '2010-02-14', '9710000013', 'vaishali.naik13@example.test', '113, FC Road, Pune, Maharashtra',
    'O-', 'Rohan Naik', '9620000013'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000013');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sunil Salunkhe', 'Male', '2003-03-15', '9710000014', 'sunil.salunkhe14@example.test', '114, Karve Nagar, Pune, Maharashtra',
    'A+', 'Neha Salunkhe', '9620000014'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000014');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Madhuri Sharma', 'Female', '1996-04-16', '9710000015', 'madhuri.sharma15@example.test', '115, Kothrud, Pune, Maharashtra',
    'A-', 'Vivek Sharma', '9620000015'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000015');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Yash Verma', 'Male', '1989-05-17', '9710000016', 'yash.verma16@example.test', '116, Baner Road, Pune, Maharashtra',
    'B+', 'Sunita Verma', '9620000016'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000016');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Riya Kulkarni', 'Female', '1982-06-18', '9710000017', 'riya.kulkarni17@example.test', '117, Aundh, Pune, Maharashtra',
    'B-', 'Sameer Kulkarni', '9620000017'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000017');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Rohan Deshpande', 'Male', '1975-07-19', '9710000018', 'rohan.deshpande18@example.test', '118, Viman Nagar, Pune, Maharashtra',
    'AB+', 'Kavya Deshpande', '9620000018'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000018');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Neha Patil', 'Female', '1968-08-20', '9710000019', 'neha.patil19@example.test', '119, Hadapsar, Pune, Maharashtra',
    'AB-', 'Rahul Patil', '9620000019'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000019');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Vivek Joshi', 'Male', '1961-09-21', '9710000020', 'vivek.joshi20@example.test', '120, Wakad, Pune, Maharashtra',
    'O+', 'Aarti Joshi', '9620000020'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000020');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sunita Kale', 'Female', '1954-10-22', '9710000021', 'sunita.kale21@example.test', '121, Hinjewadi, Pune, Maharashtra',
    'O-', 'Sanjay Kale', '9620000021'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000021');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sameer More', 'Male', '1947-11-23', '9710000022', 'sameer.more22@example.test', '122, Kharadi, Pune, Maharashtra',
    'A+', 'Swati More', '9620000022'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000022');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Kavya Shinde', 'Female', '2019-12-24', '9710000023', 'kavya.shinde23@example.test', '123, Shivaji Nagar, Pune, Maharashtra',
    'A-', 'Deepak Shinde', '9620000023'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000023');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Rahul Gaikwad', 'Male', '2012-01-25', '9710000024', 'rahul.gaikwad24@example.test', '124, MG Road, Pune, Maharashtra',
    'B+', 'Radha Gaikwad', '9620000024'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000024');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Aarti Pawar', 'Female', '2005-02-26', '9710000025', 'aarti.pawar25@example.test', '125, FC Road, Pune, Maharashtra',
    'B-', 'Ganesh Pawar', '9620000025'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000025');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sanjay Jadhav', 'Male', '1998-03-27', '9710000026', 'sanjay.jadhav26@example.test', '126, Karve Nagar, Pune, Maharashtra',
    'AB+', 'Vaishali Jadhav', '9620000026'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000026');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Swati Kadam', 'Female', '1991-04-01', '9710000027', 'swati.kadam27@example.test', '127, Kothrud, Pune, Maharashtra',
    'AB-', 'Sunil Kadam', '9620000027'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000027');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Deepak Chavan', 'Male', '1984-05-02', '9710000028', 'deepak.chavan28@example.test', '128, Baner Road, Pune, Maharashtra',
    'O+', 'Madhuri Chavan', '9620000028'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000028');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Radha Bhosale', 'Female', '1977-06-03', '9710000029', 'radha.bhosale29@example.test', '129, Aundh, Pune, Maharashtra',
    'O-', 'Yash Bhosale', '9620000029'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000029');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Ganesh Wagh', 'Male', '1970-07-04', '9710000030', 'ganesh.wagh30@example.test', '130, Viman Nagar, Pune, Maharashtra',
    'A+', 'Riya Wagh', '9620000030'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000030');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Vaishali Naik', 'Female', '1963-08-05', '9710000031', 'vaishali.naik31@example.test', '131, Hadapsar, Pune, Maharashtra',
    'A-', 'Rohan Naik', '9620000031'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000031');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Sunil Salunkhe', 'Male', '1956-09-06', '9710000032', 'sunil.salunkhe32@example.test', '132, Wakad, Pune, Maharashtra',
    'B+', 'Neha Salunkhe', '9620000032'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000032');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Madhuri Sharma', 'Female', '1949-10-07', '9710000033', 'madhuri.sharma33@example.test', '133, Hinjewadi, Pune, Maharashtra',
    'B-', 'Vivek Sharma', '9620000033'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000033');

INSERT INTO patients (
    full_name, gender, date_of_birth, phone, email, address,
    blood_group, emergency_contact_name, emergency_contact_phone
)
SELECT 'Yash Verma', 'Male', '2021-11-08', '9710000034', 'yash.verma34@example.test', '134, Kharadi, Pune, Maharashtra',
    'AB+', 'Sunita Verma', '9620000034'
WHERE NOT EXISTS (SELECT 1 FROM patients WHERE phone = '9710000034');

