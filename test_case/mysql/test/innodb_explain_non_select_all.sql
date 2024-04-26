
-- source include/big_test.inc
-- There are expected differences in Handler_update output when run with and
-- without log-bin. Thus, test is updated to run with binary logging ON now.
-- Also, skipping it for binlog_format=STATEMENT due to Unsafe statements.
--source include/have_binlog_format_mixed_or_row.inc

-- 
-- Run explain_non_select.inc on InnoDB with all of the so-called 6.0 features.
--


set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';

set @save_storage_engine= @@session.default_storage_engine;
set session default_storage_engine = InnoDB;

-- json format in explain_util.inc can be switched off by setting to zero.
--let $json = 0

--source include/explain_non_select.inc
set default_storage_engine= @save_storage_engine;

set optimizer_switch=default;
