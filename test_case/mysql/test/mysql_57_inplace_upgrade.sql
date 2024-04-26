
-- It should have created a file in the MySQL Servers datadir
--let $MYSQLD_DATADIR= `select @@datadir`
--file_exists $MYSQLD_DATADIR/mysql_upgrade_info

--echo --##########################################################################
--echo -- Test upgrade of help tables
--echo --##########################################################################

--echo -- Truncate a help table
TRUNCATE TABLE mysql.help_topic;
SELECT COUNT(*) = 0 FROM mysql.help_topic;

SELECT COUNT(*) != 0 FROM mysql.help_topic;

-- It should have created a file in the MySQL Servers datadir
--let $MYSQLD_DATADIR= `select @@datadir`
--file_exists $MYSQLD_DATADIR/mysql_upgrade_info

--echo --##########################################################################
--echo -- Bug#29365552: LEFTOVER SYSTEM TABLES AFTER 5.7 => 8.0 IN-PLACE UPGRADE
--echo --##########################################################################

-- These files must not exist
-- $MYSQLD_DATADIR1/mysql/innodb_index_stats_backup57.ibd
-- $MYSQLD_DATADIR1/mysql/innodb_table_stats_backup57.ibd
--replace_regex /_[0-9]+\.sdi/_XXX.sdi/
--list_files $MYSQLD_DATADIR1/mysql

--echo --##########################################################################
--echo -- Cleanup
--echo --##########################################################################

--let $shutdown_server_timeout = 300
--source include/shutdown_mysqld.inc

--force-rmdir $MYSQLD_DATADIR1
--remove_file $MYSQL_TMP_DIR/data57.zip

--echo --##########################################################################
--echo -- Bug#29791350: NON-INSTALL IN-PLACE UPGRADE FAILING FROM 5.7.25 TO 8.0.16
--echo --##########################################################################

--copy_file $MYSQLTEST_VARDIR/std_data/upgrade/bug29791350_upgrade_57022.zip $MYSQL_TMP_DIR/data57.zip
--file_exists $MYSQL_TMP_DIR/data57.zip
--exec unzip -qo $MYSQL_TMP_DIR/data57.zip -d $MYSQL_TMP_DIR

--let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/mysql57_upgrade_bug29791350.log
--replace_result $MYSQLD MYSQLD $MYSQLD_DATADIR1 MYSQLD_DATADIR1 $MYSQLD_LOG MYSQLD_LOG
--exec echo "restart: --table-open-cache=256 --datadir=$MYSQLD_DATADIR1 --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--let $wait_counter= 10000
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo --##########################################################################
--echo -- Cleanup
--echo --##########################################################################

--let $shutdown_server_timeout = 300
--source include/shutdown_mysqld.inc

--force-rmdir $MYSQLD_DATADIR1
--remove_file $MYSQL_TMP_DIR/data57.zip

--echo --##########################################################################
--echo -- Bug#29996434: 8.0.16 AUTO- UPGRADE CAPTURES WRONG AUTO_INCREMENT VALUES FOR TABLE METADATA
--echo --##########################################################################

--copy_file $MYSQLTEST_VARDIR/std_data/upgrade/bug29996434_upgrade_57022.zip $MYSQL_TMP_DIR/data57.zip
--file_exists $MYSQL_TMP_DIR/data57.zip
--exec unzip -qo $MYSQL_TMP_DIR/data57.zip -d $MYSQL_TMP_DIR

--let $restart_parameters = restart: --datadir=$MYSQLD_DATADIR1
--let $wait_counter= 10000
--source include/start_mysqld_no_echo.inc

SELECT table_name, Auto_increment FROM INFORMATION_SCHEMA.tables WHERE table_schema='test';

SELECT * FROM test.t1;
INSERT INTO test.t1 VALUES(NULL);
SELECT * FROM test.t1;

SELECT * FROM test.t2;
INSERT INTO test.t2 VALUES(NULL, 1);
SELECT * FROM test.t2;

SELECT * FROM test.t3;
INSERT INTO test.t3 VALUES(1, 1);
SELECT * FROM test.t3;

SELECT table_name, Auto_increment FROM INFORMATION_SCHEMA.tables WHERE table_schema='test';

SELECT * FROM test.t1;
INSERT INTO test.t1 VALUES(NULL);
SELECT * FROM test.t1;

SELECT * FROM test.t2;
INSERT INTO test.t2 VALUES(NULL, 1);
SELECT * FROM test.t2;

SELECT * FROM test.t3;
INSERT INTO test.t3 VALUES(1, 1);
SELECT * FROM test.t3;
