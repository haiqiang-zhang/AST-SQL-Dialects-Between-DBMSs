
--
-- MRR/MyISAM tests.
-- (Runs with all 6.0 optimizer switches on)
--

set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';

set @read_rnd_buffer_size_save= @@read_rnd_buffer_size;
set read_rnd_buffer_size=79;
select @@read_rnd_buffer_size;

-- source include/mrr_tests.inc
-- source include/mrr_myisam_tests.inc

set @@read_rnd_buffer_size= @read_rnd_buffer_size_save;
set optimizer_switch=default;
