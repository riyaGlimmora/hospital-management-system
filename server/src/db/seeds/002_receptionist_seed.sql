-- =====================================================================
-- Seed: 002_receptionist_seed.sql
-- Purpose  : Seeds a default receptionist user for local/dev/demo login.
--
-- IMPORTANT: The password hash below is a bcrypt hash (cost factor 10)
-- of the plaintext password "Reception@123", generated with:
--     bcrypt.hash('Reception@123', 10)
-- Change this password immediately after first login in any real
-- deployment. This seed is intended for local/dev/demo environments.
--
-- Idempotent: safe to run multiple times (uses ON CONFLICT DO NOTHING).
-- =====================================================================

INSERT INTO users (full_name, email, password_hash, role_id, is_active)
SELECT
    'Priya Nair',
    'receptionist@hospital.test',
    '$2b$10$ENkRUR9CacSzUJ3Z5SYapesZZoGdZQNcyXlkC3WIHRMdls3DbR4hO',
    r.id,
    TRUE
FROM roles r
WHERE r.name = 'receptionist'
ON CONFLICT (email) DO NOTHING;
