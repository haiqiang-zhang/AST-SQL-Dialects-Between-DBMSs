
let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR --skip-mysqlx;
let BOOTSTRAP_SQL=$MYSQL_TMP_DIR/tiny_bootstrap.sql;
let $MYSQLD_SOCKET= `SELECT @@socket`;
let $MYSQLD_PORT= `SELECT @@port`;
CREATE DATABASE test;
EOF

--echo -- Shut the test server down
--source include/shutdown_mysqld.inc

--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL > $MYSQLD_LOG 2>&1

--echo -- Restart the server against DDIR
--exec echo "restart:--datadir=$DDIR " > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

connect(root_con,localhost,root,,mysql);
DROP TABLE mysql.user;
