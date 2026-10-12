-- Logical databases for Labs MYG (ER: docs/domain-er-model.md).
-- MySQL entrypoint runs scripts in /docker-entrypoint-initdb.d only on first boot.

CREATE DATABASE IF NOT EXISTS labsmyg CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS labsmyg_audit CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MYSQL_USER from compose already has grants on MYSQL_DATABASE (labsmyg).
-- Extend the same app user to the audit schema for local dual-URL wiring.
GRANT ALL PRIVILEGES ON labsmyg.* TO 'labsmyg'@'%';
GRANT ALL PRIVILEGES ON labsmyg_audit.* TO 'labsmyg'@'%';
FLUSH PRIVILEGES;
