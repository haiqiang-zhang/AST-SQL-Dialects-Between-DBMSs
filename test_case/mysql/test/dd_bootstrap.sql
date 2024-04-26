
let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/dd_bootstrap_test;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let extra_args= --no-defaults --innodb_dedicated_server=OFF --log-error=$MYSQLD_LOG --secure-file-priv="" --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
  CREATE SCHEMA test;
  DROP TABLE mysql.time_zone_transition_type;
EOF

--echo -- 1.2 First start the server with --initialize, and drop the time_zone_transition_type table.
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 1.3 Restart the server against DDIR - should succeed.
--exec echo "restart: --datadir=$DDIR --no-console --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- 1.4 Shut server down.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- 1.5 Look for warning.
perl;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_e= grep(/\[Warning\] \[[^]]*\] \[[^]]*\] Can\'t open and lock time zone table/gi,<FILE>);
EOF

--echo -- 1.6 Delete bootstrap file, log file and datadir.
remove_file $BOOTSTRAP_SQL;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_e= grep(/Failed to find valid data directory./gi,<FILE>);
EOF

--echo -- 2.5 Delete log file and datadir.
remove_file $MYSQLD_LOG;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_e= grep(/\[ERROR\] \[[^]]*\] \[[^]]*\] failed to set datadir/gi,<FILE>);
EOF

--echo -- 3.3 Delete log file but datadir does not need cleanup
--echo -- since it is non-existent.
remove_file $MYSQLD_LOG;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_e= grep(/Failed to find valid data directory/gi,<FILE>);
EOF

--echo -- 4.3 Delete log file and datadir.
remove_file $MYSQLD_LOG;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $c_e= grep(/Failed to find valid data directory/gi,<FILE>);
EOF

--echo -- 5.3 Delete log file and datadir.
remove_file $MYSQLD_LOG;
