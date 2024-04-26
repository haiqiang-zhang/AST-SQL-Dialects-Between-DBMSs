--

--source include/no_valgrind_without_big.inc

set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=on';

set @save_storage_engine= @@default_storage_engine;
set default_storage_engine=InnoDB;

set default_storage_engine= @save_storage_engine;
set optimizer_switch=default;