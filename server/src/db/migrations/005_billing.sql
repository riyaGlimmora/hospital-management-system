CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS billing (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bill_number         VARCHAR(20) UNIQUE NOT NULL,
    appointment_id      UUID NOT NULL REFERENCES appointments(id) ON DELETE RESTRICT,
    patient_id          UUID NOT NULL REFERENCES patients(id) ON DELETE RESTRICT,
    doctor_id           UUID NOT NULL REFERENCES doctors(id) ON DELETE RESTRICT,
    total_amount        NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    discount_amount     NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
    tax_amount          NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
    final_amount        NUMERIC(10,2) NOT NULL CHECK (final_amount >= 0),
    payment_status      VARCHAR(20) NOT NULL DEFAULT 'pending'
                        CHECK (payment_status IN ('pending', 'paid', 'partially_paid', 'cancelled')),
    payment_method      VARCHAR(20) NULL
                        CHECK (payment_method IN ('cash', 'card', 'upi', 'net_banking')),
    notes               TEXT NULL,
    created_by          UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    created_at          TIMESTAMPTZ DEFAULT NOW(),
    updated_at          TIMESTAMPTZ DEFAULT NOW()
);

CREATE SEQUENCE IF NOT EXISTS billing_bill_number_seq;

CREATE OR REPLACE FUNCTION generate_bill_number()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.bill_number IS NULL THEN
        NEW.bill_number := 'BILL-' || LPAD(nextval('billing_bill_number_seq')::TEXT, 6, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_billing_generate_bill_number ON billing;
CREATE TRIGGER trg_billing_generate_bill_number
    BEFORE INSERT ON billing
    FOR EACH ROW
    EXECUTE FUNCTION generate_bill_number();

DROP TRIGGER IF EXISTS trg_billing_updated_at ON billing;
CREATE TRIGGER trg_billing_updated_at
    BEFORE UPDATE ON billing
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

CREATE INDEX IF NOT EXISTS idx_billing_bill_number ON billing (bill_number);
CREATE INDEX IF NOT EXISTS idx_billing_patient_id ON billing (patient_id);
CREATE INDEX IF NOT EXISTS idx_billing_appointment_id ON billing (appointment_id);
CREATE INDEX IF NOT EXISTS idx_billing_payment_status ON billing (payment_status);