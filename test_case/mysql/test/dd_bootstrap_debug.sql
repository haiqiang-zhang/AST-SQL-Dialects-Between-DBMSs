
let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/dd_bootstrap_test;
let extra_args= --no-defaults --innodb_dedicated_server=OFF --secure-file-priv="" --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
let PASSWD_FILE=   $MYSQL_TMP_DIR/password_file.txt;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_1.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  SET SESSION debug= '+d,skip_dd_table_access_check';
  CREATE SCHEMA test;
  UPDATE mysql.dd_properties SET properties= 'invalid';
  SET SESSION debug= '-d,skip_dd_table_access_check';
EOF

--echo -- 1.2 First start the server with --initialize, and update the version.
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 1.3 Restart the server against DDIR - should fail.
--error 1
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --datadir=$DDIR

--echo -- 1.4 Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_w= grep(/No data dictionary version number found./gi,<FILE>);
EOF

--echo -- 1.5 Delete bootstrap file and datadir.
remove_file $BOOTSTRAP_SQL;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_2.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  CREATE SCHEMA test;
  SET SESSION debug= '+d,skip_dd_table_access_check';
  DROP TABLE mysql.dd_properties;
  SET SESSION debug= '-d,skip_dd_table_access_check';
EOF

--echo -- 2.2 First start the server with --initialize, and drop the properties table. Should fail.
--error 1
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 2.3 Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_w= grep(/The used command is not allowed with this MySQL version/gi,<FILE>);
EOF

--echo -- 2.4 Delete bootstrap file and datadir.
remove_file $BOOTSTRAP_SQL;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_3.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  CREATE SCHEMA test;
  SET FOREIGN_KEY_CHECKS= 0;
  SET SESSION debug= '+d,skip_dd_table_access_check';
  DROP TABLE mysql.tables;
  SET SESSION debug= '-d,skip_dd_table_access_check';
EOF

--echo -- 3.2 First start the server with --initialize, and drop the tables table: Should fail.
--error 1
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 3.3 Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_w= grep(/The used command is not allowed with this MySQL version/gi,<FILE>);
EOF

--echo -- 3.4 Delete bootstrap file and datadir.
remove_file $BOOTSTRAP_SQL;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_4.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  CREATE SCHEMA test;
  SET SESSION debug= '+d,skip_dd_table_access_check';
  ALTER TABLE mysql.schemata COMMENT 'Altered table';
  SET SESSION debug= '-d,skip_dd_table_access_check';
EOF

--echo -- 4.2 First start the server with --initialize, and alter the schemata table.
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 4.3 Restart the server against DDIR.
--exec echo "restart: --datadir=$DDIR --no-console --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- 4.4 Connect as root.
connect(root_con,localhost,root,,mysql);
SET SESSION debug= '+d,skip_dd_table_access_check';
SELECT t.comment FROM mysql.tables AS t, mysql.schemata AS s WHERE
  t.name = 'schemata' AND
  t.schema_id = s.id AND
  s.name = 'mysql';
SET SESSION debug= '-d,skip_dd_table_access_check';

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_5.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  SELECT * FROM mysql.st_spatial_reference_systems;
EOF

--echo -- 5.2 First start the server with --initialize, and submit the init file.
--error 1
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 5.3 Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_w= grep(/Access to data dictionary table \'mysql.st_spatial_reference_systems\' is rejected/gi,<FILE>);
EOF

--echo -- 5.4 Delete bootstrap file and datadir.
remove_file $BOOTSTRAP_SQL;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_6.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  CREATE SCHEMA test;
  SELECT * FROM mysql.tables;
EOF

--echo -- 6.2 First start the server with --initialize.
--exec $MYSQLD $extra_args --log-error=$MYSQLD_LOG --initialize-insecure --datadir=$DDIR

--echo -- 6.3 Restart the server against DDIR with an init-file.
--exec echo "restart: --datadir=$DDIR --no-console --log-error=$MYSQLD_LOG --init-file=$BOOTSTRAP_SQL" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- 6.4 An init file error does not make the server exit, so we need to stop the server.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- 6.5 Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_w= grep(/Access to data dictionary table \'mysql.tables\' is rejected/gi,<FILE>);
EOF

--echo -- 6.6 Delete bootstrap file and datadir.
remove_file $BOOTSTRAP_SQL;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_bootstrap_7.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;
  CREATE SCHEMA test;
EOF

--echo -- 7.2 First start the server with --initialize
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR --sql-require-primary-key=ON --init-file=$BOOTSTRAP_SQL

--echo -- 7.3 Restart the server against DDIR.
--exec echo "restart: --datadir=$DDIR --no-console --log-error=$MYSQLD_LOG --sql-require-primary-key=ON" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- 7.4 Connect as root.
connect(root_con,localhost,root,,mysql);
CREATE TABLE t1(i INT);
CREATE TABLE t1(i INT);
