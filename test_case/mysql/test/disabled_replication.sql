
-- Not GTIDs because it sets slave_sql_skip_counter
-- When log-bin, skip-log-bin and binlog-format options are specified, mask the warning.
--disable_query_log
call mtr.add_suppression("\\[Warning\\] \\[[^]]*\\] \\[[^]]*\\] You need to use --log-bin to make --binlog-format work.");
--

--
-- Commands associated with the REPLICA.
--
SHOW REPLICA STATUS;
SELECT SOURCE_POS_WAIT('non-existent', 0);

-- Commands associated with replication filters
--error ER_REPLICA_CONFIGURATION
CHANGE REPLICATION FILTER REPLICATE_DO_DB=(db1);

--
-- Configuration options associated with the REPLICA.
--
--let $saved= `SELECT @@GLOBAL.max_relay_log_size`
SET @@GLOBAL.max_relay_log_size= 536870912;
SET @@GLOBAL.replica_net_timeout= 10;
SET @@GLOBAL.sql_replica_skip_counter= 10;
SET @@SESSION.sql_log_bin= 0;

--
-- Commands associated with the SOURCE.
--
--error ER_NO_BINARY_LOGGING
SHOW BINARY LOGS;


--
-- Configuration options associated with the SOURCE.
--
--let $saved= `SELECT @@GLOBAL.max_binlog_size`
SET @@GLOBAL.max_binlog_size= 536870912;
