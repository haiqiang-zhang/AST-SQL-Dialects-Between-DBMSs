
-- Fetch default values for current version
--let $old_server_defaults= `(SELECT GROUP_CONCAT(default_value) FROM mysql.server_cost)`
--let $old_engine_defaults= `(SELECT GROUP_CONCAT(default_value) FROM mysql.engine_cost)`

-- Drop columns and let upgrade script add them back
ALTER TABLE mysql.server_cost DROP COLUMN default_value;
ALTER TABLE mysql.engine_cost DROP COLUMN default_value;

-- Filter out ndb_binlog_index to mask differences due to running with
-- or without NDB. Always report check-for-upgrade status as OK, as it depends
-- on the order in which tests are run.
--let $restart_parameters = restart:--upgrade=FORCE
--let $wait_counter= 10000
--source include/restart_mysqld.inc

-- Mask out the content of the last_update column
--replace_column 3 --
SELECT * FROM mysql.server_cost;
SELECT * FROM mysql.engine_cost;

-- Run upgrade script a second time to test upgrade when columns already exists
--
-- Filter out ndb_binlog_index to mask differences due to running with
-- or without NDB.
--let $restart_parameters = restart:--upgrade=FORCE
--let $wait_counter= 10000
--source include/restart_mysqld.inc

-- Mask out the content of the last_update column
--replace_column 3 --
SELECT * FROM mysql.server_cost;
SELECT * FROM mysql.engine_cost;
