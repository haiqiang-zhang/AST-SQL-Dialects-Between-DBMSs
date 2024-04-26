
-- 
-- Run subquery.inc without semi-join optimization and subquery materialization
--

set optimizer_switch='index_condition_pushdown=on,mrr=on,mrr_cost_based=off';
{
  set optimizer_switch='semijoin=off';

if (`select locate('materialization', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='materialization=off';

set optimizer_switch=default;
