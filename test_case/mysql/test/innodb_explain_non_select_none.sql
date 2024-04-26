
-- source include/big_test.inc
-- There are expected differences in Handler_update output when run with and
-- without log-bin. Thus, test is updated to run with binary logging ON now.
-- Also, skipping it for binlog_format=STATEMENT due to Unsafe statements.
--source include/have_binlog_format_mixed_or_row.inc

-- 
-- Run explain_non_select.inc on InnoDB without any of the socalled 6.0 features.
--


--disable_query_log
if (`select locate('semijoin', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='index_condition_pushdown=off';
{
  set optimizer_switch='mrr=off';

set @save_storage_engine= @@session.default_storage_engine;
set session default_storage_engine = InnoDB;
set default_storage_engine= @save_storage_engine;

set optimizer_switch=default;