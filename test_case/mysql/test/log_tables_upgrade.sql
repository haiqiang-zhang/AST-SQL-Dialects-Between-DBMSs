
USE test;

-- Create the table with a bogus NULL column
CREATE TABLE bug49823 (event_time TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), user_host MEDIUMTEXT NOT NULL, thread_id BIGINT(21) UNSIGNED NOT NULL, server_id INTEGER UNSIGNED NULL, command_type VARCHAR(64) NOT NULL, argument MEDIUMBLOB NOT NULL) engine=MYISAM CHARACTER SET utf8mb3 comment="General log";

SET GLOBAL general_log = OFF;
USE mysql;

-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb. Always report check-for-upgrade status as OK, as it depends
-- on the order in which tests are run.
--let $restart_parameters = restart:--upgrade=FORCE --general-log=0
--let $wait_counter= 10000
--source include/restart_mysqld.inc

DROP TABLE general_log;
USE test;
