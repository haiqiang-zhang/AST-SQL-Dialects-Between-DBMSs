--                                                                             #
-- Bug#34063709 Lack of error while revoking nonexistent privilege.            #
--##############################################################################

-- Prepare
CREATE USER rngp_user;
CREATE ROLE rngp_role;
CREATE DATABASE rngp_db;
CREATE TABLE rngp_db.tb1 (x INT);
CREATE TABLE rngp_db.tb2 (no INT, name VARCHAR(20));

-- Revoke non existent, no privileges -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE REFERENCES ON rngp_db.tb1 FROM rngp_role;

-- Grant new privileges -OK
GRANT SELECT, INSERT ON rngp_db.tb1 TO rngp_role;

-- Grant already existing privilege -OK, but no change
GRANT SELECT ON rngp_db.tb1 TO rngp_role;

-- Grant already existing privilege altogether with new one -OK
GRANT SELECT, UPDATE ON rngp_db.tb1 TO rngp_role;

-- Revoke existent, -OK
REVOKE INSERT ON rngp_db.tb1 FROM rngp_role;

-- Revoke both existent and not existent privileges at one time
--error ER_NONEXISTING_TABLE_GRANT
REVOKE SELECT, INSERT ON rngp_db.tb1 FROM rngp_role;

-- Revoke non existent, other privileges exist -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE REFERENCES ON rngp_db.tb1 FROM rngp_role;

-- Same as above, but test compatibility with older version -no error
SET original_server_version := 80200;
SET original_server_version := 80200;

-- Set original_server_version to the current -issue error
SET @current_version := CAST(
   SUBSTRING_INDEX(@@GLOBAL.version, '.', 1)*10000
   +SUBSTRING_INDEX(SUBSTRING_INDEX(@@GLOBAL.version, '.', 2), '.', -1)*100
   +SUBSTRING_INDEX(SUBSTRING_INDEX(@@GLOBAL.version, '-', 1), '.', -1)
   AS UNSIGNED);
SET @@session.original_server_version := @current_version;

-- Check, that none of the above REVOKEs changed grants for rngp_role
SHOW GRANTS FOR rngp_role;

-- Revoke existent -OK
REVOKE UPDATE ON rngp_db.tb1 FROM rngp_role;

-- Revoke existent with IF EXISTS clause -OK with no warnings
REVOKE IF EXISTS SELECT ON rngp_db.tb1 FROM rngp_role;

-- Grant back SELECT
GRANT SELECT ON rngp_db.tb1 TO rngp_role;

-- Revoke non existent and existent with IF EXISTS clause
-- -issue warning, but do remove the other privilege
REVOKE IF EXISTS INSERT, SELECT ON rngp_db.tb1 FROM rngp_role;


-- Grant back INSERT
GRANT INSERT ON rngp_db.tb1 TO rngp_role;

-- Revoke non existent and existent with IF EXISTS clause
-- as above, but in compatibility mode
-- -no warning and do remove the other privilege
SET original_server_version := 80200;
SET original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- Revoke non existent, no privileges -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE UPDATE, REFERENCES (x) ON rngp_db.tb1 FROM rngp_role;

-- Grant new privileges -OK
GRANT INSERT, SELECT (x) ON rngp_db.tb1 TO rngp_role;

-- Grant already existing privilege -OK, but no change
GRANT INSERT, SELECT (x) ON rngp_db.tb1 TO rngp_role;

-- Grant already existing privilege altogether with new one -OK
GRANT UPDATE, INSERT, SELECT (x), REFERENCES (x) ON rngp_db.tb1 TO rngp_role;

-- Revoke existent, -OK
REVOKE INSERT, SELECT (x) ON rngp_db.tb1 FROM rngp_role;

-- Revoke both existent and not existent privileges at one time
--error ER_NONEXISTING_TABLE_GRANT
REVOKE UPDATE, INSERT, SELECT (x), REFERENCES (x) ON rngp_db.tb1 FROM rngp_role;

-- Revoke non existent, other privileges exist -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE INSERT, SELECT (x) ON rngp_db.tb1 FROM rngp_role;

-- Revoke if exist both existent and not existent privileges at one time
REVOKE IF EXISTS UPDATE, INSERT, SELECT (x), REFERENCES (x) ON rngp_db.tb1 FROM rngp_role;

-- Revoke non existent, no privileges -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE REFERENCES ON rngp_db.tb1 FROM rngp_user;

-- Grant new privileges -OK
GRANT SELECT, INSERT ON rngp_db.tb1 TO rngp_user;

-- Grant already existing privilege -OK, but no change
GRANT SELECT ON rngp_db.tb1 TO rngp_user;

-- Grant already existing privilege altogether with new one -OK
GRANT SELECT, UPDATE ON rngp_db.tb1 TO rngp_user;

-- Revoke existent, -OK
REVOKE INSERT ON rngp_db.tb1 FROM rngp_user;

-- Revoke both existent and not existent privileges at one time
--error ER_NONEXISTING_TABLE_GRANT
REVOKE SELECT, INSERT ON rngp_db.tb1 FROM rngp_user;

-- Revoke non existent, other privileges exist -issue error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE REFERENCES ON rngp_db.tb1 FROM rngp_user;

-- Same as above, but test compatibility with older version -no error
SET original_server_version := 80200;
SET original_server_version := 80200;

-- Set original_server_version to the current -issue error
SET @@session.original_server_version := @current_version;

-- Check, that none of the above REVOKEs changed grants for rngp_user
SHOW GRANTS FOR rngp_user;

-- Revoke existent -OK
REVOKE UPDATE ON rngp_db.tb1 FROM rngp_user;

-- Revoke existent with IF EXISTS clause -OK with no warnings
REVOKE IF EXISTS SELECT ON rngp_db.tb1 FROM rngp_user;

-- Grant back SELECT
GRANT SELECT ON rngp_db.tb1 TO rngp_user;

-- Revoke non existent and existent with IF EXISTS clause
-- -issue warning, but do remove the other privilege
REVOKE IF EXISTS INSERT, SELECT ON rngp_db.tb1 FROM rngp_user;

-- Grant back INSERT
GRANT INSERT ON rngp_db.tb1 TO rngp_user;

-- Revoke non existent and existent with IF EXISTS clause
-- as above, but in compatibility mode
-- -no warning and do remove the other privilege
SET original_server_version := 80200;
SET original_server_version := 80200;

SET @@session.original_server_version := @current_version;

-- REVOKE ALL PRIVILEGES ON table, no privileges on on that table -error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE ALL PRIVILEGES ON rngp_db.tb1 FROM rngp_role;

-- Grant new privileges -OK
GRANT SELECT, INSERT ON rngp_db.tb1 TO rngp_role;

-- REVOKE ALL on table, privileges exist and are removed -OK
REVOKE ALL PRIVILEGES ON rngp_db.tb1 FROM rngp_role;

-- REVOKE ALL PRIVILEGES ON table, no privileges on on that table -error
--error ER_NONEXISTING_TABLE_GRANT
REVOKE ALL PRIVILEGES ON rngp_db.tb1 FROM rngp_user;

-- Grant new privileges -OK
GRANT SELECT, INSERT ON rngp_db.tb1 TO rngp_user;

-- REVOKE ALL on table, privileges exist and are removed -OK
REVOKE ALL PRIVILEGES ON rngp_db.tb1 FROM rngp_user;

-- Cleanup
SET @current_version := NULL;
DROP ROLE rngp_role;
DROP USER rngp_user;
DROP TABLE rngp_db.tb1;
DROP TABLE rngp_db.tb2;
DROP DATABASE rngp_db;
