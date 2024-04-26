--

--source include/master-slave.inc
--source include/have_binlog_format_statement.inc

connection master;

--
-- Test 'flush-logs slow' command.
--
--echo -- Test if mysqladmin supports 'flush-logs slow' command.
--exec $MYSQLADMIN --no-defaults -u root -S $MASTER_MYSOCK -P $MASTER_MYPORT flush-logs slow

--echo -- Make sure binary logs were not be flushed
--echo -- after executing 'flush-logs slow' command.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.1/data/master-bin.000002;

--
-- Test 'flush-logs general' command.
--
--echo -- Test if mysqladmin supports 'flush-logs general' command.
--exec $MYSQLADMIN --no-defaults -u root -S $MASTER_MYSOCK -P $MASTER_MYPORT flush-logs general

--echo -- Make sure binary logs were not flushed
--echo -- after execute 'flush-logs general' command.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.1/data/master-bin.000002;

--
-- Test 'flush-logs engine' command.
--
--echo -- Test if mysqladmin supports 'flush-logs engine' command.
--exec $MYSQLADMIN --no-defaults -u root -S $MASTER_MYSOCK -P $MASTER_MYPORT flush-logs engine

--echo -- Make sure binary logs were not flushed
--echo -- after execute 'flush-logs engine' statement.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.1/data/master-bin.000002;

--
-- Test 'flush-logs binary' command.
--
--echo -- Make sure the 'master-bin.000002' file does not
--echo -- exist before execution of 'flush-logs binary' command.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.1/data/master-bin.000002;

-- Test 'flush error logs, relay logs' statement
--source include/sync_slave_sql_with_master.inc
--echo -- Make sure the 'slave-relay-bin.000006' file does not exist
--echo -- exist before execute 'flush error logs, relay logs' statement.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.2/data/slave-relay-bin.000006;


--
-- Test 'flush-logs' command
--
--echo -- Make sure the 'slave-relay-bin.000007' and 'slave-relay-bin.000008'
--echo -- files do not exist before execute 'flush error logs, relay logs'
--echo -- statement.
--error 1
file_exists $MYSQLTEST_VARDIR/mysqld.2/data/slave-relay-bin.000007;
