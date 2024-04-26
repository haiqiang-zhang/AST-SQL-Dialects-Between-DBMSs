set optimizer_switch='mrr=on,mrr_cost_based=off';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='index_condition_pushdown=off';

set optimizer_switch=default;
