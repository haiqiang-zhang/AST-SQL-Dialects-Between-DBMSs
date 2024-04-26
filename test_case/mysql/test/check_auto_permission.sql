
-- Change file permissions to world writable
--let $MYSQL_DATA_DIR=`select @@datadir`
--let _INPUT_FILE_=$MYSQL_DATA_DIR/auto.cnf
--let _FILE_PERMS_=0777
--source include/change_file_perms.inc

-- Restart the server
--source include/restart_mysqld.inc

-- Check that it has 660 valid permissions.
--perl
 use strict;
 my $input_file= $ENV{'_INPUT_FILE_'};
 my $mode = (stat($input_file))[2];
 my $perm= $mode & 07777;
