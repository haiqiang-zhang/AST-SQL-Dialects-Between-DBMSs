
-- Warning is generated when default file (NULL) is used
CALL mtr.add_suppression("Dictionary file not specified");

select @@global.profiling;
select @@local.profiling;
select @@global.profiling_history_size;
select @@local.profiling_history_size;
select @@global.have_profiling;
set @@local.profiling= @@global.profiling;
set @@local.profiling_history_size= @@global.profiling_history_size;
set @wl6443_have_profiling= @@global.have_profiling;

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Request shutdown
-- send_shutdown

-- Call script that will poll the server waiting for it to disapear
-- source include/wait_until_disconnected.inc

--echo -- Restart server.

--exec echo "restart:--plugin-validate-password-length=8" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

-- Turn off reconnect again
--disable_reconnect

UNINSTALL PLUGIN validate_password;
  use strict;
  my $logf= $ENV{'LOGF'} or die "LOGF not set";
  my $count_warnings= grep(/\[Warning\] \[[^]]*\] \[[^]]*\] The syntax 'plugin-validate-password-length' is deprecated and will be removed in a future release\. Please use validate-password-length instead\./gi,<FILE>);
  my $count_warnings= $count_warnings;
  -- Truncate the log file so that repititions of the test don't pick up deprecation warnings from previous runs
  open(FILE,">$logf") or die("Unable to open $logf for truncation $!\n");
EOF

--echo -- Host table deprecation
select count(*) from information_schema.tables where table_name like 'host' and table_schema like 'mysql' and table_type like 'BASE TABLE';

create table mysql.host(c1 int) engine MyISAM;
insert into mysql.host values(1);

drop table mysql.host;
create view mysql.host as select HOST from mysql.db;
create user 'wl6443_u1'@'10.10.10.1' identified by 'sql';
select count(*) from mysql.host;

-- Clean Up
drop view mysql.host;
drop user 'wl6443_u1'@'10.10.10.1';

SELECT * FROM INFORMATION_SCHEMA.profiling;
