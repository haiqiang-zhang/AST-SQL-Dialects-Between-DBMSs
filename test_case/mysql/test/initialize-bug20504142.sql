

let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL=$MYSQL_TMP_DIR/tiny_bootstrap.sql;
let PASSWD_FILE=$MYSQL_TMP_DIR/password_file.txt;
CREATE DATABASE test;
CREATE TABLE mysql.t1(a INT) ENGINE=innodb;
INSERT INTO mysql.t1 VALUES (1);
INSERT INTO mysql.t1 VALUES (2);
EOF

--echo -- make the data dir
mkdir $DDIR;
SELECT 1;

let $AFILE=$DDIR/afile;
EOF

--echo -- Run the server with --initialize-insecure
--error 1
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR > $MYSQLD_LOG 2>&1

--echo -- look for the mysql directory. should not be there
perl;
   use strict;
   my $mysqldir="$ENV{'DDIR'}/mysql";
   if (opendir(my $dh, $mysqldir))
   {
     print "Data directory $mysqldir not empty\n";
     closedir($dh);
   }
EOF

--echo -- delete mysqld log
remove_file $MYSQLD_LOG;
EOF

--echo -- Run the server with --initialize-insecure
--error 1
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR > $MYSQLD_LOG 2>&1

--echo -- delete mysqld log
remove_file $MYSQLD_LOG;
