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
drop procedure if exists test_invalid;
drop procedure if exists test_signal_syntax;
drop function if exists test_signal_func;
drop procedure if exists test_invalid;
drop procedure if exists test_resignal_syntax;
drop procedure if exists test_signal;
drop procedure if exists test_resignal;
drop table if exists t_warn;
drop table if exists t_cursor;
create table t_warn(a integer(2));
create table t_cursor(a integer);
select "Caught by SQLSTATE";
select "Caught by number";
select "Caught by SQLWARNING";
select "Caught by SQLSTATE";
select "Caught by number";
select "Caught by NOT FOUND";
select "Caught by SQLSTATE";
select "Caught by number";
select "Caught by SQLEXCEPTION";
select "caught 03000";
select "caught cursor is not open";
select "Before open";
select "Before fetch";
select "Before close";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
select "handler called";
select "before RESIGNAL";
select "after RESIGNAL";
select "before RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
select "after RESIGNAL";
SELECT '2';
SELECT '1';
SELECT '3';
drop table t_warn;
drop table t_cursor;
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
SELECT 10 + 'a';
