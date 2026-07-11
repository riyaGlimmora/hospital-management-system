-- =====================================================================
-- Seed: 003_departments_seed.sql
-- Purpose  : Seeds a controlled list of hospital departments.
-- Idempotent: safe to run multiple times (uses ON CONFLICT DO NOTHING).
-- =====================================================================

INSERT INTO departments (name)
VALUES
    ('Cardiology'),
    ('Orthopedics'),
    ('Pediatrics'),
    ('Dermatology'),
    ('Neurology'),
    ('General Medicine'),
    ('ENT'),
    ('Gynecology')
ON CONFLICT (name) DO NOTHING;
