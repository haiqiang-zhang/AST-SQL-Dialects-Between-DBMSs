
-- This test is also meant to check read-only persisted value of log-replica-updates,
-- thus, it makes sense to run this test when log-bin and log-replica-updates are enabled.
-- source include/have_log_bin.inc

--echo -- Check there are no existing persistent variables
--echo -- Must return 0 rows.
SELECT * FROM performance_schema.persisted_variables;
SELECT VARIABLE_NAME FROM performance_schema.variables_info WHERE VARIABLE_SOURCE = 'PERSISTED';

-- clang/UBSAN needs to override the small thread stack in the .sql file
call mtr.add_suppression("option 'thread_stack':");

let $MYSQLD_DATADIR= `select @@datadir`;
SELECT count(*) from performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables ORDER BY VARIABLE_NAME;
SELECT VARIABLE_NAME FROM performance_schema.variables_info WHERE VARIABLE_SOURCE = 'PERSISTED' ORDER BY VARIABLE_NAME;
SELECT @@version_tokens_session_number;
SET @@persist_only.version_tokens_session_number=3;
SELECT * FROM performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables;
SELECT VARIABLE_NAME FROM performance_schema.variables_info WHERE VARIABLE_SOURCE = 'PERSISTED';
