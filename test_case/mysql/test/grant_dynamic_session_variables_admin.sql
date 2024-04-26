
-- to allow setting transaction_write_set_extraction
--let $saved_btdt = `SELECT @@global.binlog_transaction_dependency_tracking`
SET GLOBAL binlog_transaction_dependency_tracking=COMMIT_ORDER;

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc


--echo -- Testing FR2

--echo Must have SESSION_VARIABLES_ADMIN with grant option
SHOW GRANTS FOR root@localhost;

CREATE USER wl12217@localhost;
CREATE DATABASE wl12217;
DROP DATABASE wl12217;
DROP USER wl12217@localhost;

CREATE USER wl12217@localhost;
CREATE DATABASE wl12217;
SET SESSION binlog_direct_non_transactional_updates = DEFAULT;
SET SESSION binlog_format = DEFAULT;
SET SESSION binlog_row_image = DEFAULT;
SET SESSION binlog_row_value_options = DEFAULT;
SET SESSION binlog_rows_query_log_events = DEFAULT;
SET SESSION bulk_insert_buffer_size = DEFAULT;
SET SESSION character_set_database = DEFAULT;
SET SESSION character_set_filesystem = DEFAULT;
SET SESSION pseudo_replica_mode = DEFAULT;
SET SESSION pseudo_thread_id = DEFAULT;
SET SESSION histogram_generation_max_mem_size = DEFAULT;
SET SESSION sql_log_off = DEFAULT;
SET SESSION original_commit_timestamp = DEFAULT;
SET SESSION sql_log_bin = DEFAULT;
SET SESSION auto_increment_increment = DEFAULT;
SET SESSION auto_increment_offset = DEFAULT;
SET SESSION binlog_direct_non_transactional_updates = DEFAULT;
SET SESSION binlog_format = DEFAULT;
SET SESSION binlog_row_image = DEFAULT;
SET SESSION binlog_row_value_options = DEFAULT;
SET SESSION binlog_rows_query_log_events = DEFAULT;
SET SESSION bulk_insert_buffer_size = DEFAULT;
SET SESSION character_set_database = DEFAULT;
SET SESSION character_set_filesystem = DEFAULT;
SET SESSION collation_database = DEFAULT;
SET SESSION pseudo_replica_mode = DEFAULT;
SET SESSION pseudo_thread_id = DEFAULT;
SET SESSION histogram_generation_max_mem_size = DEFAULT;
SET SESSION sql_log_off = DEFAULT;
SET SESSION original_commit_timestamp = DEFAULT;
SET SESSION default_collation_for_utf8mb4 = DEFAULT;
SET SESSION explicit_defaults_for_timestamp = DEFAULT;
SET SESSION sql_log_bin = DEFAULT;
SET SESSION rbr_exec_mode = DEFAULT;
DROP DATABASE wl12217;
DROP USER wl12217@localhost;

CREATE USER wl12217@localhost;
CREATE DATABASE wl12217;
SET SESSION auto_increment_increment = DEFAULT;
SET SESSION auto_increment_offset = DEFAULT;
SET SESSION binlog_direct_non_transactional_updates = DEFAULT;
SET SESSION binlog_format = DEFAULT;
SET SESSION binlog_row_image = DEFAULT;
SET SESSION binlog_row_value_options = DEFAULT;
SET SESSION binlog_rows_query_log_events = DEFAULT;
SET SESSION bulk_insert_buffer_size = DEFAULT;
SET SESSION character_set_database = DEFAULT;
SET SESSION character_set_filesystem = DEFAULT;
SET SESSION collation_database = DEFAULT;
SET SESSION pseudo_replica_mode = DEFAULT;
SET SESSION pseudo_thread_id = DEFAULT;
SET SESSION histogram_generation_max_mem_size = DEFAULT;
SET SESSION sql_log_off = DEFAULT;
SET SESSION original_commit_timestamp = DEFAULT;
SET SESSION default_collation_for_utf8mb4 = DEFAULT;
SET SESSION explicit_defaults_for_timestamp = DEFAULT;
SET SESSION sql_log_bin = DEFAULT;
SET SESSION rbr_exec_mode = DEFAULT;
DROP DATABASE wl12217;
DROP USER wl12217@localhost;

CREATE USER wl12217@localhost;
CREATE DATABASE wl12217;
SET SESSION auto_increment_increment = DEFAULT;
SET SESSION auto_increment_offset = DEFAULT;
SET SESSION binlog_direct_non_transactional_updates = DEFAULT;
SET SESSION binlog_format = DEFAULT;
SET SESSION binlog_row_image = DEFAULT;
SET SESSION binlog_row_value_options = DEFAULT;
SET SESSION binlog_rows_query_log_events = DEFAULT;
SET SESSION bulk_insert_buffer_size = DEFAULT;
SET SESSION character_set_database = DEFAULT;
SET SESSION character_set_filesystem = DEFAULT;
SET SESSION collation_database = DEFAULT;
SET SESSION pseudo_replica_mode = DEFAULT;
SET SESSION pseudo_thread_id = DEFAULT;
SET SESSION histogram_generation_max_mem_size = DEFAULT;
SET SESSION sql_log_off = DEFAULT;
SET SESSION original_commit_timestamp = DEFAULT;
SET SESSION default_collation_for_utf8mb4 = DEFAULT;
SET SESSION explicit_defaults_for_timestamp = DEFAULT;
SET SESSION sql_log_bin = DEFAULT;
SET SESSION rbr_exec_mode = DEFAULT;
DROP DATABASE wl12217;
DROP USER wl12217@localhost;
