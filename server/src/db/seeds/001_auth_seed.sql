-- =====================================================================
-- Seed: 001_seed_roles_and_admin.sql
-- Purpose  : Seeds the `roles` lookup table and creates a default
--            admin user for initial system access.
--
-- IMPORTANT: The password hash below is a bcrypt hash (cost factor 10)
-- of the plaintext password "Admin@123", generated with:
--     bcrypt.hash('Admin@123', 10)
-- Change this password immediately after first login in any real
-- deployment. This seed is intended for local/dev/demo environments.
--
-- Idempotent: safe to run multiple times (uses ON CONFLICT DO NOTHING).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Seed roles
-- ---------------------------------------------------------------------
INSERT INTO roles (name)
VALUES
    ('admin'),
    ('receptionist'),
    ('doctor')
ON CONFLICT (name) DO NOTHING;

-- ---------------------------------------------------------------------
-- Seed default admin user
-- Email    : admin@hospital.test
-- Password : Admin@123  (bcrypt-hashed below, cost factor 10)
-- ---------------------------------------------------------------------
INSERT INTO users (full_name, email, password_hash, role_id, is_active)
SELECT
    'System Administrator',
    'admin@hospital.test',
    '$2b$10$GN8skcU7nD0WJ5CVObypZOMqVhMn2.GQdTgl.pwfhmB10et016BJO',
    r.id,
    TRUE
FROM roles r
WHERE r.name = 'admin'
ON CONFLICT (email) DO NOTHING;