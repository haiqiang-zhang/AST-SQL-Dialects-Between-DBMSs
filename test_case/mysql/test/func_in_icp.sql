-- 
-- Run func_in.inc with index_condition_pushdown
--

set optimizer_switch='index_condition_pushdown=on';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;
