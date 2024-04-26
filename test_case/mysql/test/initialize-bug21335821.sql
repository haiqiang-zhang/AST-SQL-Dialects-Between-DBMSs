

let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL=$MYSQL_TMP_DIR/tiny_bootstrap.sql;
  use strict;
  my $bootstrap_file= $ENV{'BOOTSTRAP_SQL'} or die;
EOF

--echo -- Run the server with --initialize --init-file
--exec $MYSQLD $extra_args --initialize-insecure $VALIDATE_PASSWORD_OPT --datadir=$DDIR --init-file=$BOOTSTRAP_SQL > $MYSQLD_LOG 2>&1

--echo -- Restart the server against DDIR
--exec echo "restart:--datadir=$DDIR $VALIDATE_PASSWORD_OPT" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- connect as root
connect(root_con,localhost,root,,mysql);
SELECT PLUGIN_STATUS FROM mysql.t1
  WHERE PLUGIN_NAME = 'validate_password';
SELECT PLUGIN_STATUS FROM INFORMATION_SCHEMA.plugins
  WHERE PLUGIN_NAME = 'validate_password';
