
-- 
-- Run explain_non_select.inc on MyISAM with all of the so-called 6.0 features.

-- There are expected differences in Handler_update output when run with and
-- without log-bin. Thus, test is updated to run with binary logging ON.
-- Testcase is skipped for binlog_format=STATEMENT due to Unsafe statements:
-- LIMIT clause, REPLACE... SELECT.
-- Testcase is also skipped for binlog_format=MIXED, since it mismatches result
-- file for used_columns output (Bug#22472365).
--source include/have_binlog_format_row.inc

--source include/force_myisam_default.inc
--source include/have_myisam.inc

set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';

set @save_storage_engine= @@session.default_storage_engine;
set session default_storage_engine = MyISAM;
set default_storage_engine= @save_storage_engine;

set optimizer_switch=default;
