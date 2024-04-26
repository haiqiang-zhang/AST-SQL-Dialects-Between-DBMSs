-- 
-- Run subquery_sj.inc with subquery materialization and without semijoin
--

set optimizer_switch='materialization=on';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='index_condition_pushdown=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;
