CREATE TABLE IF NOT EXISTS departments (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP TRIGGER IF EXISTS trg_departments_updated_at ON departments;
CREATE TRIGGER trg_departments_updated_at
    BEFORE UPDATE ON departments
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

ALTER TABLE doctors
    ADD COLUMN IF NOT EXISTS department_id INTEGER REFERENCES departments(id) ON DELETE RESTRICT,
    ADD COLUMN IF NOT EXISTS consult_start_time TIME,
    ADD COLUMN IF NOT EXISTS consult_end_time TIME,
    ADD COLUMN IF NOT EXISTS consult_days VARCHAR(100);

ALTER TABLE doctors
    ADD CONSTRAINT chk_doctors_consult_hours
    CHECK (
        consult_start_time IS NULL
        OR consult_end_time IS NULL
        OR consult_end_time > consult_start_time
    );

CREATE INDEX IF NOT EXISTS idx_doctors_department_id ON doctors (department_id);
