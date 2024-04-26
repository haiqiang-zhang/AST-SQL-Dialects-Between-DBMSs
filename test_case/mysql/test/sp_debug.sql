CREATE FUNCTION f1() RETURNS INT return 1;
CREATE PROCEDURE p1() SELECT 1 AS my_column;

SET DEBUG='+d,fail_stored_routine_load';
SELECT f1();
SET DEBUG='-d,fail_stored_routine_load';

SELECT f1();

DROP FUNCTION f1;
DROP PROCEDURE p1;
SET DEBUG='+d,simulate_routine_length_error';
CREATE PROCEDURE p1() SELECT "simulate_routine_length_error";
SET DEBUG='-d,simulate_routine_length_error';
CREATE SCHEMA new_db;
CREATE PROCEDURE new_db.proc() SELECT 1 AS my_column;

SET DEBUG='+d,fail_drop_db_routines';
DROP SCHEMA IF EXISTS new_db;
SET DEBUG='-d,fail_drop_db_routines';

-- Failure to drop routines in previous statement should not leave Schema in
-- inconsistent state. Following DROP SCHEMA should work fine.
DROP SCHEMA IF EXISTS new_db;

-- Creating schema with same name again should work fine.
CREATE SCHEMA new_db;

-- Cleanup
DROP SCHEMA new_db;

CREATE TABLE t1 (a INT);
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO t1 VALUES (1);
SET DEBUG_SYNC= "sp_lex_instr_before_exec_core SIGNAL sp_ready WAIT_FOR sp_finish";
SET DEBUG_SYNC="now WAIT_FOR sp_ready";
SET DEBUG_SYNC="now SIGNAL sp_finish";
SET DEBUG_SYNC='RESET';
DROP TABLE t1;
DROP FUNCTION f1;
SET NAMES utf8mb3;
SET DEBUG='+d,simulate_lctn_two_case_for_schema_case_compare';
CREATE DATABASE `tèst-db`;
CREATE PROCEDURE `tèst-db`.test() SELECT 1;
DROP DATABASE `tèst-db`;
SET DEBUG='-d,simulate_lctn_two_case_for_schema_case_compare';
SET NAMES default;

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

CREATE SCHEMA testdb;
CREATE USER usr_no_priv@localhost, usr_show_routine@localhost, usr_global_select@localhost, usr_definer@localhost, usr_role@localhost, usr_create_routine@localhost, usr_alter_routine@localhost, usr_execute@localhost;
CREATE ROLE role_show_routine;
CREATE PROCEDURE testdb.proc_root() SELECT "ProcRoot";
CREATE FUNCTION testdb.func_root() RETURNS VARCHAR(8) DETERMINISTIC RETURN "FuncRoot";
CREATE DEFINER = `usr_definer`@`localhost` PROCEDURE testdb.proc_definer() SELECT "ProcDefiner";
CREATE DEFINER = `usr_definer`@`localhost` FUNCTION testdb.func_definer() RETURNS VARCHAR(11) DETERMINISTIC RETURN "FuncDefiner";
SET ROLE role_show_routine;
SET @start_partial_revokes = @@global.partial_revokes;
SET @@global.partial_revokes=ON;
DROP USER usr_global_select@localhost;
SET @@global.partial_revokes = @start_partial_revokes;
DROP USER usr_no_priv@localhost, usr_show_routine@localhost, usr_definer@localhost, usr_role@localhost, usr_create_routine@localhost, usr_alter_routine@localhost, usr_execute@localhost;
DROP ROLE role_show_routine;
DROP SCHEMA testdb;

CREATE FUNCTION f1() RETURNS INT return 1;
CREATE PROCEDURE p1() SELECT 1;

SET SESSION DEBUG='+d,simulate_dd_elements_cache_full';
SELECT f1();
SELECT f1();
SET SESSION DEBUG='-d,simulate_dd_elements_cache_full';

DROP PROCEDURE p1;
DROP FUNCTION f1;
