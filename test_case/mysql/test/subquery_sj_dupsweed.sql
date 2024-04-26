-- 
-- Run subquery_sj.inc with semijoin and turn off all strategies to make
-- it resort to duplicate weedout strategy.
--

--disable_query_log
if (`select locate('materialization', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='firstmatch=off';
{
  set optimizer_switch='loosescan=off';
{
  set optimizer_switch='index_condition_pushdown=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;
