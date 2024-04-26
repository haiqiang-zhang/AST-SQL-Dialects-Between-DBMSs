

let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let PASSWD_FILE=$MYSQL_TMP_DIR/password_file.txt;
  use strict;
  my $log= $ENV{'MYSQLD_LOG'} or die;
  my $passwd_file= $ENV{'PASSWD_FILE'} or die;
  my $FILE;
  {
    if ($row =~ m/.*\[Note\] \[[^]]*\] \[[^]]*\] A temporary password is generated for root.localhost: ([^ \n][^ \n]*)/)
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
SET PASSWORD='';

CREATE DATABASE test;
