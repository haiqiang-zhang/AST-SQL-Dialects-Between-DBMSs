
--
-- MRR/MyISAM tests.
-- (Turns off all other 6.0 optimizer switches than cost-based MRR and ICP)
--

set optimizer_switch='index_condition_pushdown=on,mrr=on,mrr_cost_based=on';
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';

set @read_rnd_buffer_size_save= @@read_rnd_buffer_size;
set read_rnd_buffer_size=79;
select @@read_rnd_buffer_size;

-- source include/mrr_tests.inc
-- source include/mrr_myisam_tests.inc

set @@read_rnd_buffer_size= @read_rnd_buffer_size_save;
set optimizer_switch=default;
