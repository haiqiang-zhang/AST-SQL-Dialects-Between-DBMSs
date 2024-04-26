
-- myisam specific test
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Don't run with binlog_format=statement due to unsafe REPLACE... SELECT.
--source include/not_binlog_format_statement.inc

-- 
-- Run explain_non_select.inc on MyISAM with all of the so-called 6.0 features.

set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';

set @save_storage_engine= @@session.default_storage_engine;
set session default_storage_engine = MyISAM;
set default_storage_engine= @save_storage_engine;

set optimizer_switch=default;
