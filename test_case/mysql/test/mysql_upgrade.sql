
--
-- Bug #28547424 - MYSQL_UPGRADE FAILES WITH SYNTAX ERROR ON INPLACE FROM 5.7 TO 8.0
--

--let $sql_mode_old= `SELECT @@sql_mode`

--let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/mysql_upgrade_test.log
--replace_result $MYSQLD_LOG MYSQLD_LOG
--let $restart_parameters = restart:--upgrade=FORCE --sql-mode=$sql_mode_old,ANSI_QUOTES --log-error=$MYSQLD_LOG
--let $wait_counter= 10000
--source include/restart_mysqld.inc

--echo -- There should be no errors
--let SEARCH_FILE= $MYSQLD_LOG

--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

--echo -- mysql_upgrade_info file should be created successfully.
--let SEARCH_PATTERN= Could not open server upgrade info file \'.*\' for writing\. Please make sure the file is writable\.
--source include/search_pattern.inc

--remove_file $MYSQLD_LOG

--echo -- Restart server with defaults
--let $restart_parameters = restart:
--source include/restart_mysqld.inc

--echo --
--echo -- Bug #27549249: MYSQL_UPGRADE FAILED TO CHANGE @@SESSION.SQL_LOG_BIN
--echo --   WHEN AUTOCOMMIT IS OFF
--echo --

-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--let $restart_parameters = restart:--upgrade=FORCE --autocommit=0
--let $wait_counter= 10000
--source include/restart_mysqld.inc

--echo -- Restart server with defaults
--let $restart_parameters = restart:
--source include/restart_mysqld.inc

--echo --
--echo -- Bug #28392985: SESSION USER DOES NOT HAVE PRIV SESSION_VARIABLES_ADMIN IN UPGRADED DATABASE
--echo --

SHOW GRANTS FOR "mysql.session"@localhost;

-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--let $restart_parameters = restart:--upgrade=FORCE
--let $wait_counter= 10000
--source include/restart_mysqld.inc

--echo -- Must have SESSION_VARIABLES_ADMIN;

let $restart_parameters = restart: ;

CREATE USER u1,u2;

-- remove these privielges
REVOKE PASSWORDLESS_USER_ADMIN, AUTHENTICATION_POLICY_ADMIN ON *.* FROM root@localhost;
DROP USER u1,u2;

CREATE USER u34068378;

-- remove SENSITIVE_VARIABLES_OBSERVER from root
REVOKE SENSITIVE_VARIABLES_OBSERVER ON *.* FROM root@localhost;

-- cleanup
DROP USER u34068378;
