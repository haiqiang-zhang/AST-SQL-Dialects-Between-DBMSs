
--
-- ICP/MyISAM tests (Index Condition Pushdown)
-- (Turns off all other 6.0 optimizer switches)
--

set optimizer_switch='index_condition_pushdown=on';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;
