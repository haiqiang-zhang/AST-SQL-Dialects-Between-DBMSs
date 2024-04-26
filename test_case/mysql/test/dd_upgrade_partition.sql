
-- This test contains zipped 5.7 data directory with innodb partitioned tables.
-- Innodb does not recognizes partition table created in linux from windows
-- due to difference in path format.
--source include/not_windows.inc
--source include/not_valgrind.inc

--disable_query_log
call mtr.add_suppression("Resizing redo log from");
--  how to record this test JSON result content mismatch
--  If required fix regex patterns in mysql-test/include/ibd2sdi.pl
--  and mysql-test/suite/innodb/include/ibd2sdi_replace_pattern.inc,
--  then run the test with --record option.
--########################

--echo -- Set different paths for --datadir
let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57_partition;
