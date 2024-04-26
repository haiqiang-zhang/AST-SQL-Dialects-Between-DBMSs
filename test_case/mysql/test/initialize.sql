

let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL=$MYSQL_TMP_DIR/tiny_bootstrap.sql;
let PASSWD_FILE=$MYSQL_TMP_DIR/password_file.txt;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $passwd_file= $ENV{'PASSWD_FILE'} or die;
  my $FILE;
  {
    if ($row =~ m/.*A temporary password is generated for root.localhost: ([^ \n][^ \n]*)/)
    {
      my $passwd=$1;
      print "password found\n";
      my $OUT_FILE;
      open(OUT_FILE, "> $passwd_file");
      print OUT_FILE "delimiter lessprobability;
      print OUT_FILE "let new_pwd=$passwd";
      print OUT_FILE "lessprobability\n";
      print OUT_FILE "--delimiter ;
      close(OUT_FILE);
    }
  }
  close(FILE);
EOF

source $passwd_file;
SELECT 1;
SET PASSWORD='';
SELECT TABLE_NAME,COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA='mysql' ORDER BY TABLE_NAME,ORDINAL_POSITION;
SELECT user, host, plugin, LENGTH(authentication_string)
  FROM mysql.user ORDER by user;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'sys' AND ROUTINE_TYPE = 'PROCEDURE';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'sys' AND ROUTINE_TYPE = 'FUNCTION';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND TABLE_TYPE = 'BASE TABLE';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND TABLE_TYPE = 'VIEW';
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TRIGGERS WHERE TRIGGER_SCHEMA = 'sys';

CREATE DATABASE test;
CREATE DATABASE test;
CREATE TABLE mysql.t1(a INT) ENGINE=innodb;
INSERT INTO mysql.t1 VALUES (1);
INSERT INTO mysql.t1 VALUES (2);
EOF

--echo -- Run the server with --initialize-insecure --init-file
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL > $MYSQLD_LOG 2>&1


--echo -- Restart the server against DDIR
--exec echo "restart:--datadir=$DDIR " > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- connect as root
connect(root_con,localhost,root,,mysql);
SELECT 1;
SELECT TABLE_NAME,COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA='mysql' ORDER BY TABLE_NAME,ORDINAL_POSITION;
SELECT user, host, plugin, LENGTH(authentication_string)
  FROM mysql.user ORDER BY user;
SELECT a FROM t1 ORDER BY a;

let DDIR=$MYSQL_TMP_DIR/initialize_4k;
let MYSQLD_LOG=$MYSQL_TMP_DIR/initialize_4k.err;
CREATE DATABASE test;
EOF

--echo -- Run the server with --initialize-insecure and 4K pages.
--exec $MYSQLD --no-defaults --initialize-insecure --innodb_page_size=4K --datadir=$DDIR --init-file=$BOOTSTRAP_SQL >$MYSQLD_LOG 2>&1

--echo -- Look for error messages from my_message_stderr (there should be none)
--perl
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} || die "Failed to read MYSQLD_LOG from env: $!";
     /mysqld: Specified key was too long/ && print;
  }
  close(FILE);
EOF

--echo -- Restart the server against the 4k DDIR to make sure it can be started
--exec echo "restart:--innodb_page_size=4k --datadir=$DDIR " > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

SELECT * FROM information_schema.schemata;
