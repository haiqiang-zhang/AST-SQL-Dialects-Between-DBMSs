create table t_alter(i int);
insert into t_alter values(1);

let INIT_SQL = $MYSQL_TMP_DIR/init.sql;
create table test.t_create as select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;
alter table test.t_alter comment = 'new comment';
EOF

create user nonsuper@localhost;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/read_only.log;
let $restart_parameters = "restart: --init-file=$INIT_SQL --read-only=1 --log-error=$MYSQLD_LOG";

select * from t_create;
drop table t_create;
alter table t_alter comment = '';
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;
create table t_create (a int);
alter table t_alter comment = 'new comment';
create table t_create (a int);
drop table t_create;
alter table t_alter comment = 'new comment';
alter table t_alter comment = '';
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/super_read_only.log;
let $restart_parameters = "restart: --init-file=$INIT_SQL --super-read-only=1 --log-error=$MYSQLD_LOG";

set @@global.super_read_only = 0;
select * from t_create;
drop table t_create;
alter table t_alter comment = '';
set @@global.super_read_only = 1;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;
create table t_create (a int);
alter table t_alter comment = 'new comment';
create table t_create (a int);
alter table t_alter comment = 'new comment';
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/transaction_read_only.log;
let $restart_parameters = "restart: --init-file=$INIT_SQL --transaction-read-only=1 --log-error=$MYSQLD_LOG";

set @@session.transaction_read_only = 0;
select * from t_create;
drop table t_create;
alter table t_alter comment = '';
set @@session.transaction_read_only = 1;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;
create table t_create (a int);
alter table t_alter comment = 'new comment';
create table t_create (a int);
alter table t_alter comment = 'new comment';
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/innodb_read_only.log;
let $restart_parameters = "restart: --init-file=$INIT_SQL --innodb-read-only=1 --log-error=$MYSQLD_LOG";

let SEARCH_FILE = $MYSQLD_LOG;
let SEARCH_PATTERN = InnoDB read-only mode;
select * from t_create;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;
create table t_create (a int);
alter table t_alter comment = 'new comment';
create table t_create (a int);
alter table t_alter comment = 'new comment';
let $VERSION = 57022;
let $MYSQLD_DATADIR = $MYSQL_TMP_DIR/data_$VERSION;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/super_read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --super-read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/transaction_read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --transaction-read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/innodb_read_only_$VERSION.log;

let SEARCH_FILE = $MYSQLD_LOG;
let SEARCH_PATTERN = Database upgrade cannot be accomplished in read-only mode;
let $VERSION = 80015;
let $MYSQLD_DATADIR = $MYSQL_TMP_DIR/data_$VERSION;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/super_read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --super-read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/transaction_read_only_$VERSION.log;
let $restart_parameters = "restart: --datadir=$MYSQLD_DATADIR --transaction-read-only=1 --log-error=$MYSQLD_LOG";
let $wait_counter= 10000;
select @@innodb_read_only, @@transaction_read_only, @@read_only, @@super_read_only;

let $wait_counter= 10000;
let $shutdown_server_timeout= 300;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/innodb_read_only_$VERSION.log;

let SEARCH_FILE = $MYSQLD_LOG;
let SEARCH_PATTERN = Cannot upgrade format \(v3\) of redo log files in read-only mode;
let $VERSION = initialize;
let $MYSQLD_DATADIR = $MYSQL_TMP_DIR/data_$VERSION;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/read_only_$VERSION.log;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/super_read_only_$VERSION.log;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/transaction_read_only_$VERSION.log;
let $MYSQLD_LOG = $MYSQLTEST_VARDIR/log/innodb_read_only_$VERSION.log;
let SEARCH_FILE = $MYSQLD_LOG;
let SEARCH_PATTERN = --innodb-read-only is set;
let $restart_parameters = "restart:";
drop table t_alter;
drop user nonsuper@localhost;
