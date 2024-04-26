
-- need to have the dynamic loading turned on for the client plugin tests
--source include/have_plugin_auth.inc

SET @old_general_log= @@global.general_log;
SET @old_slow_query_log= @@global.slow_query_log;
SET @old_log_output = @@global.log_output;
SET @old_general_log_file = @@global.general_log_file;

SET GLOBAL log_output="FILE,TABLE";
SET GLOBAL general_log= 'ON';

--
-- If this test fails with "command "$MYSQL_CLIENT_TEST" failed",
-- you should either run mysql_client_test separately against a running
-- server or run mysql-test-run --debug mysql_client_test and check
-- var/log/mysql_client_test.trace

--exec echo "$MYSQL_CLIENT_TEST" > $LOG_DIR/mysql_client_test.out.log 2>&1
--exec $MYSQL_CLIENT_TEST --getopt-ll-test=25600M $PLUGIN_AUTH_CLIENT_OPT >> $LOG_DIR/mysql_client_test.out.log 2>&1

-- End of 4.1 tests
echo ok;

-- File 'test_wl4435.out.log' is created by mysql_client_test.cc
--echo
--echo -- cat MYSQL_TMP_DIR/test_wl4435.out.log
--echo -- ------------------------------------
--cat_file $MYSQL_TMP_DIR/test_wl4435.out.log
--echo -- ------------------------------------
--echo

SET @@global.general_log= @old_general_log;
SET @@global.slow_query_log= @old_slow_query_log;
SET @@global.log_output= @old_log_output;
SET @@global.general_log_file = @old_general_log_file;

let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/lctn_test;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let extra_args= --no-defaults --innodb_dedicated_server=OFF --log-error=$MYSQLD_LOG --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --lower_case_table_names=1 --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
  CREATE SCHEMA test;
