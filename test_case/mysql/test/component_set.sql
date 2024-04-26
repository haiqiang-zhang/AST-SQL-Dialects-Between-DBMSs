
-- UBSAN compile removes -fvisibility=hidden from components.
-- This causes failures in instrumented components
--source include/not_ubsan.inc

call mtr.add_suppression("Effective value of validate_password_length is changed. New value is");
SELECT @@global.validate_password.length;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1),(2);
DROP TABLE t1;

SET @gizmo = 32;
SELECT @@global.validate_password.length;
SELECT @@global.validate_password.length = @@global.max_connections;
SELECT @@global.validate_password.length;
SELECT @@global.validate_password.length;
SELECT @@global.validate_password.length;


CREATE FUNCTION test_func () RETURNS INT DETERMINISTIC
  RETURN 12 + 3;
DROP FUNCTION test_func;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
SELECT @@global.validate_password.check_user_name;
  SET GLOBAL validate_password.length = 16;
SELECT @@global.validate_password.length;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME='validate_password.length';
  SET validate_password.length = 16, PERSIST validate_password.number_count = 13;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
  SET validate_password.length = 16;
SELECT @@global.validate_password.number_count;
  SET GLOBAL validate_password.length = 60, validate_password.number_count = 50;
SELECT @@global.validate_password.number_count;
CREATE USER wl10916@localhost;
  SET GLOBAL validate_password.length = 16;
DROP USER wl10916@localhost;

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

--error ER_WRONG_TYPE_FOR_VAR
INSTALL COMPONENT "file://component_validate_password" SET GLOBAL validate_password.length = 'gizmo';
SELECT @@global.validate_password.length;
  SET PERSIST validate_password.number_count = 13, GLOBAL validate_password.length = 'gizmo';
SELECT VARIABLE_VALUE FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME LIKE 'validate_password.%' ORDER BY 1;
