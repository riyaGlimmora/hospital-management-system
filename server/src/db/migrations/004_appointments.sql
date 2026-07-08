CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS appointments (
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id         UUID NOT NULL REFERENCES patients(id) ON DELETE RESTRICT,
    doctor_id          UUID NOT NULL REFERENCES doctors(id) ON DELETE RESTRICT,
    appointment_date   DATE NOT NULL,
    start_time         TIME NOT NULL,
    duration_minutes   INTEGER NOT NULL DEFAULT 30 CHECK (duration_minutes IN (15, 30, 45, 60)),
    priority           VARCHAR(10) NOT NULL DEFAULT 'normal' CHECK (priority IN ('normal', 'urgent', 'emergency')),
    status             VARCHAR(15) NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'checked_in', 'completed', 'cancelled')),
    notes              TEXT NULL,
    created_by         UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_appointments_doctor_date_time ON appointments (doctor_id, appointment_date, start_time);
CREATE INDEX IF NOT EXISTS idx_appointments_patient_id ON appointments (patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_status ON appointments (status);
CREATE INDEX IF NOT EXISTS idx_appointments_appointment_date ON appointments (appointment_date);

DROP TRIGGER IF EXISTS trg_appointments_updated_at ON appointments;
CREATE TRIGGER trg_appointments_updated_at
    BEFORE UPDATE ON appointments
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();