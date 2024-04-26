
--
--echo -- Bug#26142776 : DIFFERENT MYSQL SCHEMA AFTER UPGRADE
--

-- For data directory created in current 8.0 branch.
-- Display contents of mysql schema
--LET $mysqld_datadir=`select @@DATADIR`
--echo --files in mysql schema
--replace_regex /_[0-9]+\.sdi/_XXX.sdi/
--list_files $MYSQLD_DATADIR/mysql/

SET debug='+d,skip_dd_table_access_check';
let $OUTFILE1 = $MYSQLTEST_VARDIR/tmp/mysql_schema.out;
    (SELECT id FROM mysql.schemata WHERE name='mysql')) AS tables1 LEFT JOIN
  mysql.tablespaces ON tables1.tablespace_id = tablespaces.id
  WHERE tables1.name NOT IN ('ndb_binlog_index') ORDER BY tables1.name;

-- Display table names from mysql.tables that belong to mysql schema
-- and mysql tablespace. It should be as same as displayed by upgrade.
let $OUTFILE2 = $MYSQLTEST_VARDIR/tmp/mysql_tablespace.out;

-- For data directory created in mysql-5.7 branch.
--source include/not_valgrind.inc
--Zipped data directory was created with default 16K page size
--Innodb does not recognizes partition table created in linux from windows
--due to difference in path format.
--source include/not_windows.inc

call mtr.add_suppression("Resizing redo log from");

-- Set different paths for --datadir
let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57_partition;

-- Create a bootstrap file in temp location
--replace_result $MYSQL_TMP_DIR MYSQL_TMP_DIR
--exec echo $MYSQL_TMP_DIR/bootstrap.log

--exec echo "restart: --loose-skip-log-bin --skip-log-replica-updates --datadir=$MYSQLD_DATADIR1" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--let $wait_counter= 10000
--enable_reconnect
--source include/wait_until_connected_again.inc

SHOW CREATE TABLE partitions.t1;

SET debug='+d,skip_dd_table_access_check';
let $OUTFILE3 = $MYSQLTEST_VARDIR/tmp/mysql_schema_upgrade.out;
    (SELECT id FROM mysql.schemata WHERE name='mysql')) AS tables1 LEFT JOIN
  mysql.tablespaces ON tables1.tablespace_id = tablespaces.id
  WHERE tables1.name NOT IN ('ndb_binlog_index') ORDER BY tables1.name;

-- Display table names from mysql.tables that belong to mysql schema
-- and mysql tablespace. It should be as same as displayed by upgrade.
let $OUTFILE4 = $MYSQLTEST_VARDIR/tmp/mysql_tablespace_upgrade.out;
