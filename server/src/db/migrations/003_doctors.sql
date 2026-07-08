CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS doctors (
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id            VARCHAR(20) UNIQUE NOT NULL,
    full_name            VARCHAR(150) NOT NULL,
    specialization       VARCHAR(100) NOT NULL,
    phone                VARCHAR(20) NOT NULL,
    email                VARCHAR(255) NOT NULL UNIQUE,
    qualification        VARCHAR(150) NOT NULL,
    experience_years     INTEGER NOT NULL CHECK (experience_years >= 0),
    consultation_fee     NUMERIC(10,2) NOT NULL CHECK (consultation_fee >= 0),
    gender               VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')),
    is_active            BOOLEAN NOT NULL DEFAULT TRUE,
    created_at           TIMESTAMPTZ DEFAULT NOW(),
    updated_at           TIMESTAMPTZ DEFAULT NOW()
);

CREATE SEQUENCE IF NOT EXISTS doctors_doctor_id_seq;

CREATE OR REPLACE FUNCTION generate_doctor_id()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.doctor_id IS NULL THEN
        NEW.doctor_id := 'DOC-' || LPAD(nextval('doctors_doctor_id_seq')::TEXT, 6, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_doctors_generate_doctor_id ON doctors;
CREATE TRIGGER trg_doctors_generate_doctor_id
    BEFORE INSERT ON doctors
    FOR EACH ROW
    EXECUTE FUNCTION generate_doctor_id();

DROP TRIGGER IF EXISTS trg_doctors_updated_at ON doctors;
CREATE TRIGGER trg_doctors_updated_at
    BEFORE UPDATE ON doctors
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

CREATE INDEX IF NOT EXISTS idx_doctors_doctor_id ON doctors (doctor_id);
CREATE INDEX IF NOT EXISTS idx_doctors_full_name ON doctors (full_name);
CREATE INDEX IF NOT EXISTS idx_doctors_specialization ON doctors (specialization);