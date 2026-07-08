CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS patients (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id                  VARCHAR(20) NOT NULL UNIQUE,
    full_name                   VARCHAR(150) NOT NULL,
    gender                      VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')),
    date_of_birth               DATE NOT NULL,
    phone                       VARCHAR(20) NOT NULL,
    email                       VARCHAR(255) NULL,
    address                     TEXT NOT NULL,
    blood_group                 VARCHAR(5) NULL CHECK (blood_group IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    emergency_contact_name      VARCHAR(150) NOT NULL,
    emergency_contact_phone     VARCHAR(20) NOT NULL,
    is_active                   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE patients IS 'Registered hospital patients.';
COMMENT ON COLUMN patients.patient_id IS 'Auto-generated business identifier, e.g. PAT-000001.';

CREATE SEQUENCE IF NOT EXISTS patients_patient_id_seq;

CREATE OR REPLACE FUNCTION generate_patient_id()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.patient_id IS NULL THEN
        NEW.patient_id := 'PAT-' || LPAD(nextval('patients_patient_id_seq')::TEXT, 6, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_patients_generate_patient_id ON patients;
CREATE TRIGGER trg_patients_generate_patient_id
    BEFORE INSERT ON patients
    FOR EACH ROW
    EXECUTE FUNCTION generate_patient_id();

DROP TRIGGER IF EXISTS trg_patients_updated_at ON patients;
CREATE TRIGGER trg_patients_updated_at
    BEFORE UPDATE ON patients
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

CREATE INDEX IF NOT EXISTS idx_patients_patient_id ON patients (patient_id);
CREATE INDEX IF NOT EXISTS idx_patients_full_name ON patients (full_name);
CREATE INDEX IF NOT EXISTS idx_patients_phone ON patients (phone);