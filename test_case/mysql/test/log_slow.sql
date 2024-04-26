
-- PS protocol skews our counters with its prepare/execute cycles.
-- Cursor protocol doesn't support everything we need.
--source include/no_protocol.inc

-- Test does not depend on MyISAM. Can possibly be merged into
-- show_check.test or log_state.test once their dependence on
-- MyISAM has been removed.

SELECT @@global.slow_query_log INTO @save_sql;
SET @@global.slow_query_log=1;
SELECT variable_name,variable_value
  FROM performance_schema.session_status
 WHERE variable_name = "Slow_queries";

SET SESSION long_query_time=0;
SELECT variable_name,variable_value
  FROM performance_schema.session_status
 WHERE variable_name = "Slow_queries";
SET @@global.slow_query_log=0;
SELECT variable_name,variable_value
  FROM performance_schema.session_status
 WHERE variable_name = "Slow_queries";

SET SESSION long_query_time=DEFAULT;
SET @@global.slow_query_log=@save_sql;
