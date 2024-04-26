
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo --
--echo -- WL#8688: Support ability to persist SET GLOBAL settings
--echo --

SET PERSIST server_id=47, @@persist.general_log=0;
SET PERSIST concurrent_insert=NEVER;
SELECT @@global.validate_password.policy, @@global.validate_password.length;
SET PERSIST validate_password.policy= 2;
SET PERSIST validate_password.length= 13;
SELECT @@global.server_id;
SELECT @@global.general_log;
SELECT @@global.concurrent_insert;
SELECT @@global.validate_password.policy;
SELECT @@global.validate_password.length;

-- Turn off reconnect again
--disable_reconnect

--echo -- Search for warnings in error log.
--let $log_file= $MYSQLTEST_VARDIR/log/mysqld.1.err
--let LOGF= $log_file

CALL mtr.add_suppression("currently unknown variable 'validate_password*");
let $MYSQLD_DATADIR= `select @@datadir`;
SELECT * FROM performance_schema.persisted_variables;
SET PERSIST validate_password.policy= 2;
SELECT * FROM performance_schema.persisted_variables;
SET PERSIST validate_password.length= 13;
SELECT * FROM performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables;
SET @@persist.validate_password.length=10;
SET @@persist.validate_password.check_user_name=OFF;
SELECT COUNT(*) FROM performance_schema.persisted_variables;
SELECT COUNT(*) FROM performance_schema.error_log WHERE ERROR_CODE = "MY-013185";
SELECT * FROM performance_schema.persisted_variables;
