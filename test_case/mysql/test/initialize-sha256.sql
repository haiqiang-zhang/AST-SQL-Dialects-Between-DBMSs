

let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
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
SELECT user, host, plugin, LENGTH(authentication_string) > 0
  FROM mysql.user ORDER BY user;

CREATE DATABASE test;
