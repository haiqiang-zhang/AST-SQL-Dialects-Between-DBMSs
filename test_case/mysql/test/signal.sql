
-- Tests for SIGNAL and RESIGNAL

--echo --
--echo -- PART 1: syntax
--echo --

--echo --
--echo -- Test every new reserved and non reserved keywords
--echo --

--disable_warnings
drop table if exists signal_non_reserved;

create table signal_non_reserved (
  class_origin int,
  subclass_origin int,
  constraint_catalog int,
  constraint_schema int,
  constraint_name int,
  catalog_name int,
  schema_name int,
  table_name int,
  column_name int,
  cursor_name int,
  message_text int,
  sqlcode int
);

drop table signal_non_reserved;
drop table if exists diag_non_reserved;

create table diag_non_reserved (
  diagnostics int,
  current int,
  stacked int,
  exception int
);

drop table diag_non_reserved;
drop table if exists diag_cond_non_reserved;

create table diag_cond_non_reserved (
  condition_identifier int,
  condition_number int,
  condition_name int,
  connection_name int,
  message_length int,
  message_octet_length int,
  parameter_mode int,
  parameter_name int,
  parameter_ordinal_position int,
  returned_sqlstate int,
  routine_catalog int,
  routine_name int,
  routine_schema int,
  server_name int,
  specific_name int,
  trigger_catalog int,
  trigger_name int,
  trigger_schema int
);

drop table diag_cond_non_reserved;
drop table if exists diag_stmt_non_reserved;

create table diag_stmt_non_reserved (
  number int,
  more int,
  command_function int,
  command_function_code int,
  dynamic_function int,
  dynamic_function_code int,
  row_count int,
  transactions_committed int,
  transactions_rolled_back int,
  transaction_active int
);

drop table diag_stmt_non_reserved;
drop table if exists test_reserved;
create table test_reserved (signal int);
create table test_reserved (resignal int);
create table test_reserved (condition int);
drop procedure if exists test_invalid;
drop procedure if exists test_signal_syntax;
drop function if exists test_signal_func;
create procedure test_invalid()
begin
  SIGNAL;
end $$

--error ER_SP_COND_MISMATCH
create procedure test_invalid()
begin
  SIGNAL foo;
end $$

--error ER_SIGNAL_BAD_CONDITION_TYPE
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR 1234;
end $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  SIGNAL SQLSTATE '23000';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  SIGNAL SQLSTATE VALUE '23000';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_signal_syntax $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

create procedure test_signal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    CLASS_ORIGIN = 'foo',
    SUBCLASS_ORIGIN = 'foo',
    CONSTRAINT_CATALOG = 'foo',
    CONSTRAINT_SCHEMA = 'foo',
    CONSTRAINT_NAME = 'foo',
    CATALOG_NAME = 'foo',
    SCHEMA_NAME = 'foo',
    TABLE_NAME = 'foo',
    COLUMN_NAME = 'foo',
    CURSOR_NAME = 'foo',
    MESSAGE_TEXT = 'foo',
    MYSQL_ERRNO = 'foo';
end $$
drop procedure test_signal_syntax $$

--error ER_SP_BAD_SQLSTATE
SIGNAL SQLSTATE '00000' $$

--error ER_SP_BAD_SQLSTATE
SIGNAL SQLSTATE '00001' $$

--error ER_SP_BAD_SQLSTATE
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '00000';
end $$

--error ER_SP_BAD_SQLSTATE
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '00001';
end $$

--echo --
--echo -- Test conditions information that SIGNAL can not set
--echo --

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET bla_bla = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET CONDITION_IDENTIFIER = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET CONDITION_NUMBER = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET CONNECTION_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET MESSAGE_LENGTH = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET MESSAGE_OCTET_LENGTH = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET PARAMETER_MODE = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET PARAMETER_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET PARAMETER_ORDINAL_POSITION = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET RETURNED_SQLSTATE = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET ROUTINE_CATALOG = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET ROUTINE_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET ROUTINE_SCHEMA = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET SERVER_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET SPECIFIC_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET TRIGGER_CATALOG = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET TRIGGER_NAME = 'foo';
end $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  SIGNAL SQLSTATE '12345' SET TRIGGER_SCHEMA = 'foo';
end $$

delimiter ;
drop procedure if exists test_invalid;
drop procedure if exists test_resignal_syntax;
create procedure test_invalid()
begin
  RESIGNAL foo;
end $$

create procedure test_resignal_syntax()
begin
  RESIGNAL;
end $$
drop procedure test_resignal_syntax $$

--error ER_SIGNAL_BAD_CONDITION_TYPE
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR 1234;
end $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SQLSTATE '23000';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SQLSTATE VALUE '23000';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CLASS_ORIGIN = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET SUBCLASS_ORIGIN = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CONSTRAINT_CATALOG = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CONSTRAINT_SCHEMA = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CONSTRAINT_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CATALOG_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET SCHEMA_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET TABLE_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET COLUMN_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET CURSOR_NAME = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET MESSAGE_TEXT = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  RESIGNAL SET MYSQL_ERRNO = 'foo';
end $$
drop procedure test_resignal_syntax $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$
drop procedure test_resignal_syntax $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

--error ER_DUP_SIGNAL_SET
create procedure test_invalid()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

create procedure test_resignal_syntax()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    CLASS_ORIGIN = 'foo',
    SUBCLASS_ORIGIN = 'foo',
    CONSTRAINT_CATALOG = 'foo',
    CONSTRAINT_SCHEMA = 'foo',
    CONSTRAINT_NAME = 'foo',
    CATALOG_NAME = 'foo',
    SCHEMA_NAME = 'foo',
    TABLE_NAME = 'foo',
    COLUMN_NAME = 'foo',
    CURSOR_NAME = 'foo',
    MESSAGE_TEXT = 'foo';
end $$
drop procedure test_resignal_syntax $$

--error ER_SP_BAD_SQLSTATE
create procedure test_invalid()
begin
  RESIGNAL SQLSTATE '00000';
end $$

--error ER_SP_BAD_SQLSTATE
create procedure test_invalid()
begin
  RESIGNAL SQLSTATE '00001';
end $$

delimiter ;
drop procedure if exists test_signal;
drop procedure if exists test_resignal;
drop table if exists t_warn;
drop table if exists t_cursor;

-- Helper tables
create table t_warn(a integer(2));
create table t_cursor(a integer);

create procedure test_signal()
begin
  -- max range
  DECLARE foo CONDITION FOR SQLSTATE 'AABBB';
end $$

--error 65535
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- max range
  DECLARE foo CONDITION FOR SQLSTATE 'AABBB';
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Error
  DECLARE foo CONDITION FOR SQLSTATE '99999';
end $$

--error 9999
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- warning
  DECLARE too_few_records CONDITION FOR SQLSTATE '01000';
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Not found
  DECLARE sp_fetch_no_data CONDITION FOR SQLSTATE '02000';
end $$

--error ER_SP_FETCH_NO_DATA
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Error
  DECLARE sp_cursor_already_open CONDITION FOR SQLSTATE '24000';
end $$

--error ER_SP_CURSOR_ALREADY_OPEN
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Severe error
  DECLARE lock_deadlock CONDITION FOR SQLSTATE '40001';
end $$

--error ER_LOCK_DEADLOCK
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Unknown -> error
  DECLARE foo CONDITION FOR SQLSTATE "99999";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- warning, no subclass
  DECLARE warn CONDITION FOR SQLSTATE "01000";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- warning, with subclass
  DECLARE warn CONDITION FOR SQLSTATE "01123";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Not found, no subclass
  DECLARE not_found CONDITION FOR SQLSTATE "02000";
end $$

--error ER_SIGNAL_NOT_FOUND
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Not found, with subclass
  DECLARE not_found CONDITION FOR SQLSTATE "02XXX";
end $$

--error ER_SIGNAL_NOT_FOUND
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Error, no subclass
  DECLARE error CONDITION FOR SQLSTATE "12000";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Error, with subclass
  DECLARE error CONDITION FOR SQLSTATE "12ABC";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Severe error, no subclass
  DECLARE error CONDITION FOR SQLSTATE "40000";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  -- Severe error, with subclass
  DECLARE error CONDITION FOR SQLSTATE "40001";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

--echo --
--echo -- Test the scope of condition
--echo --

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '99999';
    DECLARE foo CONDITION FOR 8888;
end $$

--error 9999
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR 9999;
    DECLARE foo CONDITION FOR SQLSTATE '88888';
    SIGNAL foo SET MYSQL_ERRNO=8888;
end $$

--error 8888
call test_signal() $$
drop procedure test_signal $$

--echo --
--echo -- Test SET MYSQL_ERRNO
--echo --

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '99999';
end $$

--error 1111
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01000";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02000";
end $$

--error 1111
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55000";
end $$

--error 1111
call test_signal() $$
drop procedure test_signal $$

--echo --
--echo -- Test SET MESSAGE_TEXT
--echo --

--error ER_SIGNAL_EXCEPTION
SIGNAL SQLSTATE '77777' SET MESSAGE_TEXT='' $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '77777';
    MESSAGE_TEXT = "",
    MYSQL_ERRNO=45678;
end $$

--error 45678
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '99999';
    MESSAGE_TEXT = "Something bad happened",
    MYSQL_ERRNO=9999;
end $$

--error 9999
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01000";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02000";
end $$

--error ER_SIGNAL_NOT_FOUND
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55000";
end $$

--error ER_SIGNAL_EXCEPTION
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE something CONDITION FOR SQLSTATE "01000";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE something CONDITION FOR SQLSTATE "01000";
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01111";
end $$

call test_signal() $$
show warnings $$
drop procedure test_signal $$

--echo --
--echo -- Test SET complex expressions
--echo --

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    MYSQL_ERRNO = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CLASS_ORIGIN = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    SUBCLASS_ORIGIN = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CONSTRAINT_CATALOG = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CONSTRAINT_SCHEMA = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CONSTRAINT_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CATALOG_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    SCHEMA_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    TABLE_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    COLUMN_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    CURSOR_NAME = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE '99999';
    MESSAGE_TEXT = NULL;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE something CONDITION FOR SQLSTATE '99999';
    MESSAGE_TEXT = message_text,
    MYSQL_ERRNO = sqlcode;
end $$

--error 1234
call test_signal() $$
drop procedure test_signal $$

create procedure test_signal(message_text VARCHAR(64), sqlcode INTEGER)
begin
  DECLARE something CONDITION FOR SQLSTATE "12345";
    MESSAGE_TEXT = message_text,
    MYSQL_ERRNO = sqlcode;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal("Parameter string", NULL) $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal(NULL, 1234) $$

--error 45678
call test_signal("Parameter string", 45678) $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE something CONDITION FOR SQLSTATE "AABBB";
    MESSAGE_TEXT = @message_text,
    MYSQL_ERRNO = @sqlcode;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$

set @sqlcode= 12 $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$

set @message_text= "User variable" $$

--error 12
call test_signal() $$
drop procedure test_signal $$

--error ER_PARSE_ERROR
create procedure test_invalid()
begin
  DECLARE something CONDITION FOR SQLSTATE "AABBB";
    MESSAGE_TEXT = @message_text := 'illegal',
    MYSQL_ERRNO = @sqlcode := 1234;
end $$

create procedure test_signal()
begin
  DECLARE aaa VARCHAR(64);

  set aaa= repeat("A", 64);
  set bbb= repeat("B", 64);
  set ccc= repeat("C", 64);
  set ddd= repeat("D", 64);
  set eee= repeat("E", 64);
  set fff= repeat("F", 64);
  set ggg= repeat("G", 64);
  set hhh= repeat("H", 64);
  set iii= repeat("I", 64);
  set jjj= repeat("J", 64);
  set kkk= repeat("K", 64);
    CLASS_ORIGIN = aaa,
    SUBCLASS_ORIGIN = bbb,
    CONSTRAINT_CATALOG = ccc,
    CONSTRAINT_SCHEMA = ddd,
    CONSTRAINT_NAME = eee,
    CATALOG_NAME = fff,
    SCHEMA_NAME = ggg,
    TABLE_NAME = hhh,
    COLUMN_NAME = iii,
    CURSOR_NAME = jjj,
    MESSAGE_TEXT = kkk,
    MYSQL_ERRNO = 65535;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
    MYSQL_ERRNO = 999999999999999999999999999999999999999999999999999;
end $$

--error ER_WRONG_VALUE_FOR_VAR
call test_signal() $$
drop procedure test_signal $$
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create procedure test_signal()
begin
  DECLARE aaax VARCHAR(65);

  set aaax= concat(repeat("A", 64), "X");
  set bbbx= concat(repeat("B", 64), "X");
  set cccx= concat(repeat("C", 64), "X");
  set dddx= concat(repeat("D", 64), "X");
  set eeex= concat(repeat("E", 64), "X");
  set fffx= concat(repeat("F", 64), "X");
  set gggx= concat(repeat("G", 64), "X");
  set hhhx= concat(repeat("H", 64), "X");
  set iiix= concat(repeat("I", 64), "X");
  set jjjx= concat(repeat("J", 64), "X");
  set kkkx= concat(repeat("K", 64), "X");
  set lllx= concat(repeat("1", 100),
                   repeat("2", 20),
                   repeat("8", 8),
                   "X");
    CLASS_ORIGIN = aaax,
    SUBCLASS_ORIGIN = bbbx,
    CONSTRAINT_CATALOG = cccx,
    CONSTRAINT_SCHEMA = dddx,
    CONSTRAINT_NAME = eeex,
    CATALOG_NAME = fffx,
    SCHEMA_NAME = gggx,
    TABLE_NAME = hhhx,
    COLUMN_NAME = iiix,
    CURSOR_NAME = jjjx,
    MESSAGE_TEXT = lllx,
    MYSQL_ERRNO = 10000;
end $$

--NOTE: the warning text for ER_TRUNCATED_WRONG_VALUE contains
-- value: '%-.128s', so the warning printed truncates the value too,
-- which affects MESSAGE_TEXT (the X is missing)

call test_signal() $$
drop procedure test_signal $$
SET sql_mode = default;

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
    select "Caught by SQLSTATE";
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
    select "Caught by number";
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
    select "Caught by SQLWARNING";
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "Caught by SQLSTATE";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "Caught by number";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "Caught by NOT FOUND";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55555";
    select "Caught by SQLSTATE";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55555";
    select "Caught by number";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55555";
    select "Caught by SQLEXCEPTION";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

call test_signal() $$
drop procedure test_signal $$

--echo --
--echo -- Test where SIGNAL can be used
--echo --

--echo
--echo -- RETURN statement clears Diagnostics Area, thus
--echo -- the warnings raised in a stored function are not
--echo -- visible outsidef the stored function. So, we're using
--echo -- @@warning_count variable to check that SIGNAL succeeded.
--echo

create function test_signal_func() returns integer
begin
  DECLARE v INT;
    MESSAGE_TEXT = "This function SIGNAL a warning",
    MYSQL_ERRNO = 1012;

  SELECT @@warning_count INTO v;
end $$

select test_signal_func() $$
drop function test_signal_func $$

create function test_signal_func() returns integer
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02XXX";
    MESSAGE_TEXT = "This function SIGNAL not found",
    MYSQL_ERRNO = 1012;
end $$

--error 1012
select test_signal_func() $$
drop function test_signal_func $$

create function test_signal_func() returns integer
begin
  DECLARE error CONDITION FOR SQLSTATE "50000";
    MESSAGE_TEXT = "This function SIGNAL an error",
    MYSQL_ERRNO = 1012;
end $$

--error 1012
select test_signal_func() $$
drop function test_signal_func $$

--disable_warnings
drop table if exists t1 $$
--enable_warnings

create table t1 (a integer) $$

create trigger t1_ai after insert on t1 for each row
begin
  DECLARE msg VARCHAR(128);

  set msg= concat("This trigger SIGNAL a warning, a=", NEW.a);
    MESSAGE_TEXT = msg,
    MYSQL_ERRNO = 1012;
end $$

insert into t1 values (1), (2) $$
 
drop trigger t1_ai $$

create trigger t1_ai after insert on t1 for each row
begin
  DECLARE msg VARCHAR(128);

  set msg= concat("This trigger SIGNAL a not found, a=", NEW.a);
    MESSAGE_TEXT = msg,
    MYSQL_ERRNO = 1012;
end $$

--error 1012
insert into t1 values (3), (4) $$
 
drop trigger t1_ai $$

create trigger t1_ai after insert on t1 for each row
begin
  DECLARE msg VARCHAR(128);

  set msg= concat("This trigger SIGNAL an error, a=", NEW.a);
    MESSAGE_TEXT = msg,
    MYSQL_ERRNO = 1012;
end $$

--error 1012
insert into t1 values (5), (6) $$

drop table t1 $$

create table t1 (errno integer, msg varchar(128)) $$

create trigger t1_ai after insert on t1 for each row
begin
  DECLARE warn CONDITION FOR SQLSTATE "01XXX";
    MESSAGE_TEXT = NEW.msg,
    MYSQL_ERRNO = NEW.errno;
end $$

insert into t1 set errno=1012, msg='Warning message 1 in trigger' $$
insert into t1 set errno=1013, msg='Warning message 2 in trigger' $$

drop table t1 $$

--disable_warnings
drop table if exists t1 $$
drop procedure if exists p1 $$
drop function if exists f1 $$
--enable_warnings

create table t1 (s1 int) $$
insert into t1 values (1) $$

create procedure p1()
begin
  declare a int;
    select "caught 03000";
    select "caught cursor is not open";

  select "Before open";
  select "Before fetch";
  select "Before close";
end $$

create function f1() returns int
begin
  signal sqlstate '03000';
end $$

--# FIXME : MEMORY plugin warning, valgrind leak, bug#36518
--# call p1() $$

drop table t1 $$
drop procedure p1 $$
drop function f1 $$

--echo --
--echo -- Test the RESIGNAL runtime
--echo --

-- 6 tests:
-- {Signaled warning, Signaled Not Found, Signaled Error,
-- warning, not found, error} --> RESIGNAL

create procedure test_resignal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
     select "handler called";
     RESIGNAL;
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02222";
    select "before RESIGNAL";
    RESIGNAL;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

--error 1012
call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE error CONDITION FOR SQLSTATE "55555";
    select "before RESIGNAL";
    RESIGNAL;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

--error 1012
call test_resignal() $$
drop procedure test_resignal $$
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlwarning
  begin
    select "handler called";
    RESIGNAL;

  insert into t_warn set a= 9999999999999999;
end $$

call test_resignal() $$
drop procedure test_resignal $$
SET sql_mode = default;
create procedure test_resignal()
begin
  DECLARE x integer;
    select "before RESIGNAL";
    RESIGNAL;
    select "after RESIGNAL";
end $$

--error ER_SP_FETCH_NO_DATA
call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlexception
  begin
    select "before RESIGNAL";
    RESIGNAL;
    select "after RESIGNAL";

  drop table no_such_table;
end $$

--error ER_BAD_TABLE_ERROR
call test_resignal() $$
drop procedure test_resignal $$

-- 6 tests:
-- {Signaled warning, Signaled Not Found, Signaled Error,
-- warning, not found, error} --> RESIGNAL SET ...

create procedure test_resignal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01234";
    select "handler called";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of a warning",
      MYSQL_ERRNO = 55555 ;
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02111";
    select "before RESIGNAL";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of a not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE error CONDITION FOR SQLSTATE "33333";
    select "before RESIGNAL";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of an error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
drop procedure test_resignal $$
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlwarning
  begin
    select "handler called";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of a warning",
      MYSQL_ERRNO = 55555 ;

  insert into t_warn set a= 9999999999999999;
end $$

call test_resignal() $$
drop procedure test_resignal $$
SET sql_mode = default;
create procedure test_resignal()
begin
  DECLARE x integer;
    select "before RESIGNAL";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
end $$

--error 55555
call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlexception
  begin
    select "before RESIGNAL";
    RESIGNAL SET
      MESSAGE_TEXT = "RESIGNAL of an error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";

  drop table no_such_table;
end $$

--error 55555
call test_resignal() $$
drop procedure test_resignal $$

--########################################################

-- 3 tests:
-- {Signaled warning}
-- --> RESIGNAL SQLSTATE {warning, not found, error} SET ...

create procedure test_resignal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01111";
    select "handler called";
    RESIGNAL SQLSTATE "01222" SET
      MESSAGE_TEXT = "RESIGNAL to warning",
      MYSQL_ERRNO = 55555 ;
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01111";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02222" SET
      MESSAGE_TEXT = "RESIGNAL to not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE warn CONDITION FOR SQLSTATE "01111";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "33333" SET
      MESSAGE_TEXT = "RESIGNAL to error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a warning",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

-- 3 tests:
-- {Signaled not found}
-- --> RESIGNAL SQLSTATE {warning, not found, error} SET ...

create procedure test_resignal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "handler called";
    RESIGNAL SQLSTATE "01222" SET
      MESSAGE_TEXT = "RESIGNAL to warning",
      MYSQL_ERRNO = 55555 ;
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02222" SET
      MESSAGE_TEXT = "RESIGNAL to not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE not_found CONDITION FOR SQLSTATE "02ABC";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "33333" SET
      MESSAGE_TEXT = "RESIGNAL to error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising a not found",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

-- 3 tests:
-- {Signaled error}
-- --> RESIGNAL SQLSTATE {warning, not found, error} SET ...

create procedure test_resignal()
begin
  DECLARE error CONDITION FOR SQLSTATE "AAAAA";
    select "handler called";
    RESIGNAL SQLSTATE "01222" SET
      MESSAGE_TEXT = "RESIGNAL to warning",
      MYSQL_ERRNO = 55555 ;
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE error CONDITION FOR SQLSTATE "AAAAA";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02222" SET
      MESSAGE_TEXT = "RESIGNAL to not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE error CONDITION FOR SQLSTATE "AAAAA";
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "33333" SET
      MESSAGE_TEXT = "RESIGNAL to error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
    MESSAGE_TEXT = "Raising an error",
    MYSQL_ERRNO = 1012;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

-- 3 tests:
-- {warning}
-- --> RESIGNAL SQLSTATE {warning, not found, error} SET ...
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlwarning
  begin
    select "handler called";
    RESIGNAL SQLSTATE "01111" SET
      MESSAGE_TEXT = "RESIGNAL to a warning",
      MYSQL_ERRNO = 55555 ;

  insert into t_warn set a= 9999999999999999;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlwarning
  begin
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02444" SET
      MESSAGE_TEXT = "RESIGNAL to a not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";

  insert into t_warn set a= 9999999999999999;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlwarning
  begin
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "44444" SET
      MESSAGE_TEXT = "RESIGNAL to an error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";

  insert into t_warn set a= 9999999999999999;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$
SET sql_mode = default;

create procedure test_resignal()
begin
  DECLARE x integer;
    select "handler called";
    RESIGNAL SQLSTATE "01111" SET
      MESSAGE_TEXT = "RESIGNAL to a warning",
      MYSQL_ERRNO = 55555 ;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE x integer;
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02444" SET
      MESSAGE_TEXT = "RESIGNAL to a not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE x integer;
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "44444" SET
      MESSAGE_TEXT = "RESIGNAL to an error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

-- 3 tests:
-- {error}
-- --> RESIGNAL SQLSTATE {warning, not found, error} SET ...

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlexception
  begin
    select "handler called";
    RESIGNAL SQLSTATE "01111" SET
      MESSAGE_TEXT = "RESIGNAL to a warning",
      MYSQL_ERRNO = 55555 ;

  drop table no_such_table;
end $$

call test_resignal() $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlexception
  begin
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "02444" SET
      MESSAGE_TEXT = "RESIGNAL to a not found",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";

  drop table no_such_table;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

create procedure test_resignal()
begin
  DECLARE CONTINUE HANDLER for sqlexception
  begin
    select "before RESIGNAL";
    RESIGNAL SQLSTATE "44444" SET
      MESSAGE_TEXT = "RESIGNAL to an error",
      MYSQL_ERRNO = 55555 ;
    select "after RESIGNAL";

  drop table no_such_table;
end $$

--error 55555
call test_resignal() $$
show warnings $$
drop procedure test_resignal $$

--echo --
--echo -- More complex cases
--echo --

--disable_warnings
drop procedure if exists peter_p1 $$
drop procedure if exists peter_p2 $$
--enable_warnings

CREATE PROCEDURE peter_p1 ()
BEGIN
  DECLARE x CONDITION FOR 1231;
    SELECT '2';
    RESIGNAL SET MYSQL_ERRNO = 9999;
    DECLARE EXIT HANDLER FOR x
    BEGIN
      SELECT '1';
      RESIGNAL SET SCHEMA_NAME = 'test';
    END;
    SET @@sql_mode=NULL;
END
$$

CREATE PROCEDURE peter_p2 ()
BEGIN
  DECLARE x CONDITION for 9999;
    SELECT '3';
    RESIGNAL SET MESSAGE_TEXT = 'Hi, I am a useless error message';
END
$$

--
-- Here, RESIGNAL only modifies the condition caught,
-- so there is only 1 condition at the end
-- The final SQLSTATE is 42000 (it comes from the error 1231),
-- since the condition attributes are preserved.
--
--error 9999
CALL peter_p2() $$
show warnings $$

drop procedure peter_p1 $$
drop procedure peter_p2 $$

CREATE PROCEDURE peter_p1 ()
BEGIN
  DECLARE x CONDITION FOR SQLSTATE '42000';
    SHOW WARNINGS;
    RESIGNAL x SET MYSQL_ERRNO = 9999;
    DECLARE EXIT HANDLER FOR x
    BEGIN
      SHOW WARNINGS;
      RESIGNAL x SET
        SCHEMA_NAME = 'test',
        MYSQL_ERRNO= 1232;
    END;
    /* Raises ER_WRONG_VALUE_FOR_VAR : 1231, SQLSTATE 42000 */
    SET @@sql_mode=NULL;
END
$$

CREATE PROCEDURE peter_p2 ()
BEGIN
  DECLARE x CONDITION for SQLSTATE '42000';
    SHOW WARNINGS;
    RESIGNAL x SET
      MESSAGE_TEXT = 'Hi, I am a useless error message',
      MYSQL_ERRNO = 9999;
END
$$

--
-- Here, "RESIGNAL <condition>" create a new condition in the diagnostics
-- area, so that there are 4 conditions at the end.
--
--error 9999
CALL peter_p2() $$
show warnings $$

drop procedure peter_p1 $$
drop procedure peter_p2 $$

--
-- Test the value of MESSAGE_TEXT in RESIGNAL when no SET MESSAGE_TEXT clause
-- is provided (the expected result is the text from the SIGNALed condition)
--

drop procedure if exists peter_p3 $$

create procedure peter_p3()
begin
  declare continue handler for sqlexception
    resignal sqlstate '99002' set mysql_errno = 2;
end $$

--error 2
call peter_p3() $$

-- Expecting 2 conditions, both with the text "Original"
show warnings $$

drop procedure peter_p3 $$

delimiter ;

drop table t_warn;
drop table t_cursor;

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error 18
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error 18
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error 65
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_WRONG_VALUE_FOR_VAR
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error 65
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_WRONG_VALUE_FOR_VAR
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_BAD_FIELD_ERROR
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_BAD_FIELD_ERROR
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

-- error 3
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT= 0x41;
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT= 0b01000001;
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT = "Hello";
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT = 'Hello';
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT = `Hello`;
end $$

-- error ER_BAD_FIELD_ERROR
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
    MESSAGE_TEXT = 65.4321;
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

-- error ER_PARSE_ERROR
create procedure test_signal()
begin
  DECLARE céèçà foo CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_PARSE_ERROR
create procedure test_signal()
begin
  DECLARE "céèçà" CONDITION FOR SQLSTATE '12345';
end $$

-- error ER_PARSE_ERROR
create procedure test_signal()
begin
  DECLARE 'céèçà' CONDITION FOR SQLSTATE '12345';
end $$

create procedure test_signal()
begin
  DECLARE `céèçà` CONDITION FOR SQLSTATE '12345';
end $$

-- error 1000
call test_signal $$
drop procedure test_signal $$

create procedure test_signal()
begin
  SIGNAL SQLSTATE '77777' SET MYSQL_ERRNO = 1000, MESSAGE_TEXT='ÁÂÃÅÄ';
end $$

-- Commented until WL#751 is implemented in this version
-- -- error 1000
-- call test_signal $$
drop procedure test_signal $$

delimiter ;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    RESIGNAL;
    RESIGNAL;

  SELECT 10 + 'a';
END $$
delimiter ;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    RESIGNAL SET MESSAGE_TEXT= '1st resignal';
    RESIGNAL SET MESSAGE_TEXT= '2nd resignal';

  SELECT 10 + 'a';
END $$
delimiter ;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    RESIGNAL SQLSTATE '01000' SET MESSAGE_TEXT= '1st resignal';
    RESIGNAL SQLSTATE '01000' SET MESSAGE_TEXT= '2nd resignal';

  SELECT 10 + 'a';
END $$
delimiter ;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    RESIGNAL SQLSTATE '01000' SET MESSAGE_TEXT= '1st resignal';
    RESIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT= '2nd resignal';

  SELECT 10 + 'a';
END $$
delimiter ;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1051
  BEGIN
    DROP DATABASE none;
  DROP TABLE none;
END $$
delimiter ;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING RESIGNAL SET MESSAGE_TEXT = asdf;
  SELECT 10 + 'a';
END $$

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING RESIGNAL SET MESSAGE_TEXT = asdf;
    SELECT 10 + 'a';
END $$

CREATE PROCEDURE p3()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING RESIGNAL SET MESSAGE_TEXT = asdf;
    SELECT 10 + 'a';
END $$

CREATE PROCEDURE p4()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
    RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
  SELECT 10 + 'a';
END $$

CREATE PROCEDURE p5()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
    SELECT 10 + 'a';
END $$

CREATE PROCEDURE p6()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
    SELECT 10 + 'a';
END $$
delimiter ;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RESIGNAL SET MESSAGE_TEXT = asdf;
  DROP TABLE none;
END $$

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RESIGNAL SET MESSAGE_TEXT = asdf;
    DROP TABLE none;
END $$

CREATE PROCEDURE p3()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RESIGNAL SET MESSAGE_TEXT = asdf;
    DROP TABLE none;
END $$

CREATE PROCEDURE p4()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
  DROP TABLE none;
END $$

CREATE PROCEDURE p5()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
    DROP TABLE none;
END $$

CREATE PROCEDURE p6()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'handled' as Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = asdf;
    DROP TABLE none;
END $$
delimiter ;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
CREATE FUNCTION f1() RETURNS INTEGER
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION RESIGNAL;
  INSERT INTO none VALUES (NULL);

CREATE PROCEDURE p1()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION RESIGNAL;
  SELECT f1();

DROP PROCEDURE p1;
DROP FUNCTION f1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RESIGNAL;

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING RESIGNAL;

CREATE PROCEDURE p3()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    RESIGNAL SET MESSAGE_TEXT= 'custom error msg';

CREATE PROCEDURE p4()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
    RESIGNAL SET MESSAGE_TEXT= 'custom warning msg';

CREATE PROCEDURE p5()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= 'custom error msg';

CREATE PROCEDURE p6()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
    RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= 'custom warning msg';

CREATE PROCEDURE p7()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RESIGNAL;
    SIGNAL SQLSTATE 'HY000';

CREATE PROCEDURE p8()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING RESIGNAL;
    SIGNAL SQLSTATE '01000';

CREATE PROCEDURE p9()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      RESIGNAL SET MESSAGE_TEXT= 'custom error msg';
    SIGNAL SQLSTATE 'HY000';

CREATE PROCEDURE p10()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
      RESIGNAL SET MESSAGE_TEXT= 'custom warning msg';
    SIGNAL SQLSTATE '01000';

CREATE PROCEDURE p11()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= 'custom error msg';
    SIGNAL SQLSTATE 'HY000';

CREATE PROCEDURE p12()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'handled' AS Msg;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
      RESIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= 'custom warning msg';
    SIGNAL SQLSTATE '01000';

SET max_error_count= 0;
SET max_error_count= DEFAULT;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
DROP PROCEDURE p7;
DROP PROCEDURE p8;
DROP PROCEDURE p9;
DROP PROCEDURE p10;
DROP PROCEDURE p11;
DROP PROCEDURE p12;
SET sql_mode = default;
