
-- 
-- Run explain_non_select.inc on MyISAM without any of the socalled 6.0 features.
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Don't run with binlog_format=statement due to unsafe REPLACE... SELECT.
--source include/not_binlog_format_statement.inc

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
