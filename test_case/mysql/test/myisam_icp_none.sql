
--
-- ICP/MyISAM tests (Index Condition Pushdown)
-- (Turns off all 6.0 optimizer switches, even ICP)
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

set optimizer_switch=default;
