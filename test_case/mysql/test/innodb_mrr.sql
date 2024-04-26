--

--source include/no_valgrind_without_big.inc

set optimizer_switch='mrr=on,mrr_cost_based=off';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='index_condition_pushdown=off';

set @save_storage_engine= @@default_storage_engine;
set default_storage_engine=InnoDB;

set default_storage_engine= @save_storage_engine;
set optimizer_switch=default;
