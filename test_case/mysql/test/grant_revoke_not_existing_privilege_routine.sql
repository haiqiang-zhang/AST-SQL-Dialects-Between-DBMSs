--                                                                             #
-- Bug #33897859 Unexpected behaviour seen with revoking a privilege from role.#
--##############################################################################

-- Prepare
CREATE USER rngp_user;
CREATE ROLE rngp_role;
CREATE DATABASE rngp_db;
CREATE TABLE rngp_db.tb (x INT);
CREATE PROCEDURE rngp_db.rngp_proc() SELECT * FROM rngp_db.tb;

-- Revoke non existent, no privileges -issue error
--error ER_NONEXISTING_PROC_GRANT
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Grant new privileges -OK
GRANT EXECUTE, GRANT OPTION ON PROCEDURE rngp_db.rngp_proc TO rngp_role;

-- Grant already existing privilege -OK, but no change
GRANT EXECUTE ON PROCEDURE rngp_db.rngp_proc TO rngp_role;

-- Grant already existing privilege altogether with new one -OK
GRANT EXECUTE, ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc TO rngp_role;

-- Revoke existent, -OK
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Revoke both existent and not existent privileges at one time
--error ER_NONEXISTING_PROC_GRANT
REVOKE EXECUTE, GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Revoke non existent, other privileges exist -issue error
--error ER_NONEXISTING_PROC_GRANT
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Same as above, but test compatibility with older version -no error
SET @@session.original_server_version := 80200;

-- SET original_server_version to the current -issue error
SET @current_version := CAST(
   SUBSTRING_INDEX(@@GLOBAL.version, '.', 1)*10000
   +SUBSTRING_INDEX(SUBSTRING_INDEX(@@GLOBAL.version, '.', 2), '.', -1)*100
   +SUBSTRING_INDEX(SUBSTRING_INDEX(@@GLOBAL.version, '-', 1), '.', -1)
   AS UNSIGNED);
SET @@session.original_server_version := @current_version;

-- Check, that none of the above REVOKEs changed grants for rngp_role
SHOW GRANTS FOR rngp_role;

-- Revoke existent -OK
REVOKE ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Revoke non existent with IF EXISTS clause - warnings issued
REVOKE IF EXISTS GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Same as above, test compatibility with older version - no warnings issued
SET @@session.original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- Revoke non existent and existent with IF EXISTS clause
-- -issue warning, but do remove the other privilege
REVOKE IF EXISTS ALTER ROUTINE, EXECUTE ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Grant back EXECUTE
GRANT EXECUTE ON PROCEDURE rngp_db.rngp_proc TO rngp_role;

-- Same as previous REVOKE, but in compatibility mode
-- -no warning, but do remove the other privilege
SET @@session.original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- Revoke non existent, no privileges -issue error
--error ER_NONEXISTING_PROC_GRANT
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Grant new privileges -OK
GRANT EXECUTE, GRANT OPTION ON PROCEDURE rngp_db.rngp_proc TO rngp_user;

-- Grant already existing privilege -OK, but no change
GRANT EXECUTE ON PROCEDURE rngp_db.rngp_proc TO rngp_user;

-- Grant already existing privilege altogether with new one -OK
GRANT EXECUTE, ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc TO rngp_user;

-- Revoke existent, -OK
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Revoke both existent and not existent privileges at one time
--error ER_NONEXISTING_PROC_GRANT
REVOKE EXECUTE, GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Revoke non existent, other privileges exist -issue error
--error ER_NONEXISTING_PROC_GRANT
REVOKE GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Same as above, but test compatibility with older version -no error
SET @@session.original_server_version := 80200;

-- SET original_server_version to the current -issue error
SET @@session.original_server_version := @current_version;

-- Check, that none of the above REVOKEs changed grants for rngp_user
SHOW GRANTS FOR rngp_user;

-- Revoke existent -OK
REVOKE ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Revoke non existent with IF EXISTS clause - warnings issued
REVOKE IF EXISTS GRANT OPTION ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Same as above, test compatibility with older version - no warnings issued
SET @@session.original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- Grant back EXECUTE
GRANT EXECUTE ON PROCEDURE rngp_db.rngp_proc TO rngp_user;

-- Same as previous REVOKE, but in compatibility mode
-- -no warning, but do remove the other privilege
SET @@session.original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- REVOKE ALL PRIVILEGES ON routine, no privileges on on that routine -error
--error ER_NONEXISTING_PROC_GRANT
REVOKE ALL PRIVILEGES ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- Grant new privileges -OK
GRANT EXECUTE, ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc TO rngp_role;

-- REVOKE ALL on routine, privileges exist and are removed -OK
REVOKE ALL PRIVILEGES ON PROCEDURE rngp_db.rngp_proc FROM rngp_role;

-- REVOKE ALL PRIVILEGES ON routine, no privileges on on that routine -error
--error ER_NONEXISTING_PROC_GRANT
REVOKE ALL PRIVILEGES ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Grant new privileges -OK
GRANT EXECUTE, ALTER ROUTINE ON PROCEDURE rngp_db.rngp_proc TO rngp_user;

-- REVOKE ALL on routine, privileges exist and are removed -OK
REVOKE ALL PRIVILEGES ON PROCEDURE rngp_db.rngp_proc FROM rngp_user;

-- Cleanup
SET @current_version := NULL;
DROP ROLE rngp_role;
DROP USER rngp_user;
DROP PROCEDURE rngp_db.rngp_proc;
DROP TABLE rngp_db.tb;
DROP DATABASE rngp_db;
