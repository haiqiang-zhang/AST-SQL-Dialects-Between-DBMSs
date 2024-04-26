
CREATE TABLE t1(s INT);
INSERT INTO t1 VALUES(1);

-- Flush logs to create second binlog file
FLUSH LOGS;
INSERT INTO t1 VALUES(2);
DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir;

-- Create the .gz files
--exec gzip -c $MYSQLD_DATADIR/$binlog_file_1 > $MYSQLD_DATADIR/$binlog_file_1.gz
--exec gzip -c $MYSQLD_DATADIR/$binlog_file_2 > $MYSQLD_DATADIR/$binlog_file_2.gz
-- Pass the zip files to mysqlbinlog, it should not throw any error.
--exec gzip -cd $MYSQLD_DATADIR/$binlog_file_1.gz $MYSQLD_DATADIR/$binlog_file_2.gz | $MYSQL_BINLOG --force-if-open  - > $MYSQLTEST_VARDIR/tmp/compressed_files.sql
--let $grep_file=$MYSQLTEST_VARDIR/tmp/compressed_files.sql
--let $grep_pattern=DROP TABLE `t1`
--source include/grep_pattern.inc

-- Cleanup
--remove_file $MYSQLD_DATADIR/$binlog_file_1.gz
--remove_file $MYSQLD_DATADIR/$binlog_file_2.gz
--remove_file $MYSQLTEST_VARDIR/tmp/compressed_files.sql
RESET BINARY LOGS AND GTIDS;
