
--
-- Bug #16502: mysqlcheck tries to check views
--
create table t1 (a int) engine=myisam;
create view v1 as select * from t1;
drop view v1;
drop table t1;

--
-- Bug #30654: mysqlcheck fails during upgrade of tables whose names include backticks
--
create table `t``1`(a int) engine=myisam;
create table `t 1`(a int) engine=myisam;
drop table `t``1`, `t 1`;

--
-- Bug#25347: mysqlcheck -A -r doesn't repair table marked as crashed
--
create database d_bug25347;
use d_bug25347;
create table t_bug25347 (a int) engine=myisam;
create view v_bug25347 as select * from t_bug25347;
insert into t_bug25347 values (1),(2),(3);
let $MYSQLD_DATADIR= `select @@datadir`;
EOF
--exec $MYSQL_CHECK --repair --databases d_bug25347
--error 130
insert into t_bug25347 values (4),(5),(6);
insert into t_bug25347 values (7),(8),(9);
select * from t_bug25347;
select * from v_bug25347;
drop view v_bug25347;
drop table t_bug25347;
drop database d_bug25347;
use test;
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE TABLE db1.t1 (a INT) ENGINE=MYISAM;
EOF
CREATE TABLE db2.t2 (a INT);
DROP DATABASE db1;
DROP DATABASE db2;
