
CREATE DATABASE db_25380000;
USE db_25380000;
CREATE TABLE t_25380000(a INT);
INSERT INTO t_25380000 VALUES(1);

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_dump_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLIMPORT
--exec $MYSQL_DUMP --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem --tab=$MYSQLTEST_VARDIR/tmp/  db_25380000

--exec $MYSQL_IMPORT --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem  db_25380000 $MYSQLTEST_VARDIR/tmp/t_25380000.txt > $MYSQLTEST_VARDIR/tmp/25380000_import_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_import_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQL
--exec $MYSQL --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem -e "SELECT * from db_25380000.t_25380000;

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysql_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLCHECK
--exec $MYSQL_CHECK --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem --analyze --databases db_25380000 > $MYSQLTEST_VARDIR/tmp/25380000_mysqlcheck_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqlcheck_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLBINLOG
--exec $MYSQL_BINLOG --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem --read-from-remote-server binlog.000001 > $MYSQLTEST_VARDIR/tmp/25380000_mysqlbinlog_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqlbinlog_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLADMIN
--exec $MYSQLADMIN --no-defaults --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem -S $MASTER_MYSOCK -P $MASTER_MYPORT -uroot ping > $MYSQLTEST_VARDIR/tmp/25380000_mysqladmin_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqladmin_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLSHOW
--exec $MYSQL_SHOW --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem db_25380000 > $MYSQLTEST_VARDIR/tmp/25380000_mysqlshow_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqlshow_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLSLAP
--exec $MYSQL_SLAP --ssl-mode=DISABLED --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem --query="SELECT * from db_25380000.t_25380000" --only-print > $MYSQLTEST_VARDIR/tmp/25380000_mysqlslap_result 2> $MYSQLTEST_VARDIR/tmp/25380000_stderr
--cat_file $MYSQLTEST_VARDIR/tmp/25380000_stderr

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqlslap_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --MYSQLTEST
--exec echo "SELECT * from db_25380000.t_25380000;

-- Search for warning message in the result file
--let SEARCH_FILE= $MYSQLTEST_VARDIR/tmp/25380000_mysqltest_result
--let SEARCH_PATTERN= WARNING: no verification of server certificate will be done. Use --ssl-mode=VERIFY_CA or VERIFY_IDENTITY.
--source include/search_pattern.inc

--echo --Cleanup
DROP TABLE t_25380000;
DROP DATABASE db_25380000;
