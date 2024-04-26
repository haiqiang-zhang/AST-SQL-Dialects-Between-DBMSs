
let $MYSQLD_SOCKET= `SELECT @@socket`;
let $MYSQLD_PORT= `SELECT @@port`;
let $MTR_DATADIR= `SELECT @@datadir`;
let $PLUGIN_DIR= `SELECT @@plugin_dir`;

let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let MYSQLD_OUT= $MYSQL_TMP_DIR/server.out;
let DDIR=       $MYSQL_TMP_DIR/basedir_test;
let SHUTDOWN_SQL= $MYSQL_TMP_DIR/shutdown.sql;

-- Need to save this as PWD env var is overriden when invoking perl
let BDIR= $PWD;

let DEFARGS= --no-defaults --plugin-dir=$PLUGIN_DIR --innodb_dedicated_server=OFF --explicit_defaults_for_timestamp --socket=$MYSQLD_SOCKET --port=$MYSQLD_PORT --skip-ssl --secure-file-priv="" --datadir=$DDIR --skip-mysqlx;

let INIT_FILE_ARGS= $DEFARGS --log-error=$MYSQLD_LOG --init-file=$SHUTDOWN_SQL;
let INIT_FILE_ARGS_D= --no-defaults --plugin-dir=$PLUGIN_DIR --innodb_dedicated_server=OFF --explicit_defaults_for_timestamp --socket=$MYSQLD_SOCKET --port=$MYSQLD_PORT  --skip-mysqlx --skip-ssl --secure-file-priv="" --datadir=$MTR_DATADIR -D --log-error=$MYSQLD_LOG;
EOF

--echo -- Run -I on a new datadir
--exec $MYSQLD $DEFARGS -I --log-error=$MYSQLD_LOG


--echo --
--echo -- Deduce --basedir when using full path to mysqld
--exec $MYSQLD $INIT_FILE_ARGS

--perl
  use strict;
  my $mysqld_log= $ENV{'MYSQLD_LOG'};
  {
    if (/ERROR/) { print;
  }
  close(MYSQLD_LOG);
EOF
--remove_file $MYSQLD_LOG

--echo --
--echo -- Deduce --basedir when using path relative to CWD
--perl
  use strict;
  my $bdir= $ENV{'BDIR'};
  my $mysqld_log= $ENV{'MYSQLD_LOG'};
   
  my $binary= $ENV{'MYSQLD'};

  my $init_file_args= $ENV{'INIT_FILE_ARGS'};
    die "system failed on '$binary $init_file_args': $!";
    die "Failed to open '$mysqld_log': $!";
  {
    if (/ERROR/) { print;
  }
  close(MYSQLD_LOG);
EOF
--remove_file $MYSQLD_LOG

--echo --
--echo -- Deduce --basedir when using bare executable name (PATH lookup)
--perl
  use strict;
  use File::Basename;
  my $bdir= $ENV{'BDIR'};
   
  my $bindir= dirname($ENV{'MYSQLD'});

  my $init_file_args= $ENV{'INIT_FILE_ARGS'};
  my $binary= $ENV{'MYSQLD'};
    die "system failed on 'mysqld $init_file_args': $!";

  my $mysqld_log= $ENV{'MYSQLD_LOG'};
  {
    if (/ERROR/) { print;
  }
  close(MYSQLD_LOG);

EOF
--remove_file $MYSQLD_LOG


--echo --
--echo -- Try invalid --log-error
--error 1,2
--exec $MYSQLD $DEFARGS --log-error=$MYSQL_TMP_DIR/no_such_dir/bad_err_log.err >$MYSQLD_OUT 2>&1

--echo -- Look for expected error in output:
--perl
  use strict;
  my $mysqld_out= $ENV{'MYSQLD_OUT'};
  my $found_expected_error= 0;
  {
    if (/\[ERROR\] \[[^]]*\] \[[^]]*\] Could not open .+ for error logging/)
    {
      print "-- Found expected error\n";
      $found_expected_error= 1;
    }
  }
  if (!$found_expected_error) {
    seek(MYSQLD_OUT, 0, 0) || die "Failed to rewind FH for '$mysqld_out': $!";
    while(<MYSQLD_OUT>) { print;
  }
  close(MYSQLD_OUT);
EOF


--echo --
--echo -- Try -D as shortcut for --daemonize option with invalid --log-error
--error 1,2
--exec $MYSQLD $DEFARGS -D --log-error=$MYSQL_TMP_DIR/no_such_dir/bad_err_log.err >$MYSQLD_OUT 2>&1

--echo -- Look for expected errors in output from launcher and daemon:
--perl
  use strict;
  my $mysqld_out= $ENV{'MYSQLD_OUT'};
  my $found_expected_errors= 0;
  {
    if (/\[ERROR\] \[[^]]*\] \[[^]]*\] Could not open .+ for error logging/)
    {
      print "-- Found expected error from launcher process\n";
      ++$found_expected_errors;
    }
    if (/\[ERROR\] \[[^]]*\] \[[^]]*\] Failed to start mysqld daemon\. Check mysqld error log\./)
    {
      print "-- Found expected error from daemon process\n";
      ++$found_expected_errors;
    }
  }
  if ($found_expected_errors < 2) {
      seek(MYSQLD_OUT, 0, 0) || die "Failed to rewind FH for '$mysqld_out': $!";
  }
  close(MYSQLD_OUT);
EOF


--echo --
--echo -- Try using -D with relative path

--perl
  use strict;
  use File::Basename;
  my $mysqld= $ENV{'MYSQLD'};
  my $mysql_tmp_dir= $ENV{'MYSQL_TMP_DIR'};
  my $init_file_args_d= $ENV{'INIT_FILE_ARGS_D'};
  my $mysqld_out= $ENV{'MYSQLD_OUT'};
    die "system failed on '$mysqld $init_file_args_d': $!";

  my $mysqld_log= $ENV{'MYSQLD_LOG'};
  {
    if (/ERROR/) { print;
  }
  close(MYSQLD_LOG);
  {
    if (!(/initializing of server has completed/) &&
        !(/Invalid systemd notify socket, cannot send:/) &&
        !(/MySQL Server - end./)) {
      print;
    }
  }
  close(MYSQLD_OUT);
EOF

--echo -- Wait for daemon server to start
--enable_reconnect
--source include/wait_until_connected_again.inc
--disable_reconnect

--echo -- Execute a query to see that it is running OK
SHOW DATABASES;
