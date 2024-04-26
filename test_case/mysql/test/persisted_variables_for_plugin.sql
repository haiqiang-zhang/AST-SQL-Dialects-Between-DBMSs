
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo --
--echo -- WL#8688: Support ability to persist SET GLOBAL settings
--echo --

SET PERSIST server_id=47, @@persist.general_log=0;
SET PERSIST concurrent_insert=NEVER;
SELECT @@global.validate_password_policy, @@global.validate_password_length;
SET PERSIST validate_password_policy= 2;
SET PERSIST validate_password_length= 13;
SELECT @@global.server_id;
SELECT @@global.general_log;
SELECT @@global.concurrent_insert;
SELECT @@global.validate_password_policy;
SELECT @@global.validate_password_length;

-- Turn off reconnect again
--disable_reconnect

--echo -- Search for warnings in error log.
--let $log_file= $MYSQLTEST_VARDIR/log/mysqld.1.err
--let LOGF= $log_file

CALL mtr.add_suppression("currently unknown variable 'validate_password_*");
let $MYSQLD_DATADIR= `select @@datadir`;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST validate_password_policy= 2;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST validate_password_length= 13;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;

-- case 1: Test RESET PERSIST <plugin variable>;
SET @@persist.validate_password_length= 15;
SELECT @@GLOBAL.validate_password_length;
SET PERSIST validate_password_length= 9;
SELECT @@GLOBAL.validate_password_length;
SELECT @@GLOBAL.validate_password_length;
SELECT @@GLOBAL.validate_password_length;

-- case 1: Test RESET PERSIST;
SET @@persist.validate_password_length= 11;
SELECT @@GLOBAL.validate_password_length;
SET PERSIST validate_password_length= 19;
SELECT @@GLOBAL.validate_password_length;
SELECT @@GLOBAL.validate_password_length;
SELECT @@GLOBAL.validate_password_length;

-- Cleanup
RESET PERSIST;
SELECT @@GLOBAL.validate_password_length;
SET @@persist.validate_password_length= 15;
SELECT @@GLOBAL.validate_password_length;

-- Cleanup
RESET PERSIST;
