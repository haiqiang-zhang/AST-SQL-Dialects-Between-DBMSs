--

--let BASEDIR= `select @@basedir`
--let DDIR=$MYSQL_TMP_DIR/installdb_test
--let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log
--let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR
--let init_args=--explicit_defaults_for_timestamp --gtid-mode=on --enforce-gtid-consistency=on --log-bin=mysql-bin --server-id=1
--let BOOTSTRAP_SQL=$MYSQL_TMP_DIR/tiny_bootstrap.sql

-- We don't care about innodb warnings at this point
USE mysql;
CREATE DATABASE test;
CREATE TABLE test.t1(a INT) ENGINE=innodb;
INSERT INTO test.t1 VALUES (1);
SET sql_log_bin= 0;
INSERT INTO test.t1 VALUES (2);
SET sql_log_bin= 1;
DROP TABLE test.t1;
DROP DATABASE test;
EOF

--echo -- Shut server down
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc
--echo -- Server is down

--echo -- Run the server with:
--echo --   --initialize-insecure
--echo --   $init_args
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR $init_args --init-file=$BOOTSTRAP_SQL > $MYSQLD_LOG 2>&1

--echo -- Restart the server against DDIR
--exec echo "restart:--datadir=$DDIR $init_args" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- Connect as root
connect(root_con,localhost,root,,mysql);

-- Delete mysqld log and init file
remove_file $MYSQLD_LOG;
