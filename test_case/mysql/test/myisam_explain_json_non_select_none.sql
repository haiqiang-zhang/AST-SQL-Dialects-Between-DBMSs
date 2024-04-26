
-- 
-- Run explain_non_select.inc on MyISAM without any of the socalled 6.0 features.

-- There are expected differences in Handler_update output when run with and
-- without log-bin. Thus, test is updated to run with binary logging ON.
-- Testcase is skipped for binlog_format=STATEMENT due to Unsafe statements:
-- LIMIT clause, REPLACE... SELECT.
-- Testcase is also skipped for binlog_format=MIXED, since it mismatches result
-- file for used_columns output (Bug#22472365).
--source include/have_binlog_format_row.inc

--source include/force_myisam_default.inc
--source include/have_myisam.inc

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
set session default_storage_engine = MyISAM;
set default_storage_engine= @save_storage_engine;

set optimizer_switch=default;
