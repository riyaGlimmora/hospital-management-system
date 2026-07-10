ALTER TABLE billing
    ADD CONSTRAINT uq_billing_appointment_id UNIQUE (appointment_id);
