
let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/dd_bootstrap_test;
let MYSQLD_LOG= $MYSQL_TMP_DIR/lowercase_view.log;
let extra_args= --no-defaults --innodb_dedicated_server=OFF --log-error=$MYSQLD_LOG --secure-file-priv="" --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
  CREATE SCHEMA test;
EOF

--echo -- 1 First start the server with --initialize and --lower-case-table-names=1.
--echo --   We need to make sure l-c-t-n is set during database initialization.
--echo --   Otherwise the mysql.tables.name do not pick right collation.
--exec $MYSQLD $extra_args --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL --lower-case-table-names=1

--echo -- 2 Restart the server against DDIR
--exec echo "restart: --datadir=$DDIR --no-console --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc


--disable_warnings
drop table if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop view if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop database if exists MySQLTest;

--
-- different cases in VIEW
--
create database MySQLTest;
use MySQLTest;
create table TaB (Field int);
create view ViE as select * from TAb;
drop database MySQLTest;
use test;

--
-- test of updating and fetching from the same table check
--
create table t1Aa (col1 int);
create table t2aA (col1 int);
create view v1Aa as select * from t1aA;
create view v2aA as select * from v1aA;
create view v3Aa as select v2Aa.col1 from v2aA,t2Aa where v2Aa.col1 = t2aA.col1;
update v2aA set col1 = (select max(col1) from v1Aa);
update v2Aa set col1 = (select max(col1) from t1Aa);
update v2aA set col1 = (select max(col1) from v2Aa);
update v2aA,t2Aa set v2Aa.col1 = (select max(col1) from v1aA) where v2aA.col1 = t2aA.col1;
update t1aA,t2Aa set t1Aa.col1 = (select max(col1) from v1Aa) where t1aA.col1 = t2aA.col1;
update v1aA,t2Aa set v1Aa.col1 = (select max(col1) from v1aA) where v1Aa.col1 = t2aA.col1;
update t2Aa,v2Aa set v2aA.col1 = (select max(col1) from v1aA) where v2Aa.col1 = t2aA.col1;
update t2Aa,t1Aa set t1aA.col1 = (select max(col1) from v1Aa) where t1Aa.col1 = t2aA.col1;
update t2Aa,v1aA set v1Aa.col1 = (select max(col1) from v1aA) where v1Aa.col1 = t2aA.col1;
update v2aA,t2Aa set v2Aa.col1 = (select max(col1) from t1aA) where v2aA.col1 = t2aA.col1;
update t1Aa,t2Aa set t1aA.col1 = (select max(col1) from t1Aa) where t1aA.col1 = t2aA.col1;
update v1aA,t2Aa set v1Aa.col1 = (select max(col1) from t1Aa) where v1aA.col1 = t2aA.col1;
update t2Aa,v2Aa set v2aA.col1 = (select max(col1) from t1aA) where v2Aa.col1 = t2aA.col1;
update t2Aa,t1Aa set t1aA.col1 = (select max(col1) from t1Aa) where t1aA.col1 = t2aA.col1;
update t2Aa,v1Aa set v1aA.col1 = (select max(col1) from t1Aa) where v1Aa.col1 = t2aA.col1;
update v2aA,t2Aa set v2Aa.col1 = (select max(col1) from v2aA) where v2Aa.col1 = t2aA.col1;
update t1aA,t2Aa set t1Aa.col1 = (select max(col1) from v2aA) where t1aA.col1 = t2aA.col1;
update v1aA,t2Aa set v1Aa.col1 = (select max(col1) from v2Aa) where v1aA.col1 = t2aA.col1;
update t2Aa,v2aA set v2Aa.col1 = (select max(col1) from v2aA) where v2Aa.col1 = t2aA.col1;
update t2Aa,t1Aa set t1aA.col1 = (select max(col1) from v2aA) where t1Aa.col1 = t2aA.col1;
update t2Aa,v1Aa set v1aA.col1 = (select max(col1) from v2Aa) where v1Aa.col1 = t2aA.col1;
update v3aA set v3Aa.col1 = (select max(col1) from v1aA);
update v3aA set v3Aa.col1 = (select max(col1) from t1aA);
update v3aA set v3Aa.col1 = (select max(col1) from v2aA);
update v3aA set v3Aa.col1 = (select max(col1) from v3aA);
delete from v2Aa where col1 = (select max(col1) from v1Aa);
delete from v2aA where col1 = (select max(col1) from t1Aa);
delete from v2Aa where col1 = (select max(col1) from v2aA);
delete v2Aa from v2aA,t2Aa where (select max(col1) from v1aA) > 0 and v2Aa.col1 = t2aA.col1;
delete t1aA from t1Aa,t2Aa where (select max(col1) from v1Aa) > 0 and t1aA.col1 = t2aA.col1;
delete v1aA from v1Aa,t2Aa where (select max(col1) from v1aA) > 0 and v1Aa.col1 = t2aA.col1;
delete v2aA from v2Aa,t2Aa where (select max(col1) from t1Aa) > 0 and v2aA.col1 = t2aA.col1;
delete t1aA from t1Aa,t2Aa where (select max(col1) from t1aA) > 0 and t1Aa.col1 = t2aA.col1;
delete v1aA from v1Aa,t2Aa where (select max(col1) from t1aA) > 0 and v1aA.col1 = t2aA.col1;
delete v2Aa from v2aA,t2Aa where (select max(col1) from v2Aa) > 0 and v2aA.col1 = t2aA.col1;
delete t1Aa from t1aA,t2Aa where (select max(col1) from v2Aa) > 0 and t1Aa.col1 = t2aA.col1;
delete v1Aa from v1aA,t2Aa where (select max(col1) from v2aA) > 0 and v1Aa.col1 = t2aA.col1;
insert into v2Aa values ((select max(col1) from v1aA));
insert into t1aA values ((select max(col1) from v1Aa));
insert into v2aA values ((select max(col1) from v1aA));
insert into v2Aa values ((select max(col1) from t1Aa));
insert into t1aA values ((select max(col1) from t1Aa));
insert into v2aA values ((select max(col1) from t1aA));
insert into v2Aa values ((select max(col1) from v2aA));
insert into t1Aa values ((select max(col1) from v2Aa));
insert into v2aA values ((select max(col1) from v2Aa));
insert into v3Aa (col1) values ((select max(col1) from v1Aa));
insert into v3aA (col1) values ((select max(col1) from t1aA));
insert into v3Aa (col1) values ((select max(col1) from v2aA));
drop view v3aA,v2Aa,v1aA;
drop table t1Aa,t2Aa;

--
-- aliases in VIEWs
--
create table t1Aa (col1 int);
create view v1Aa as select col1 from t1Aa as AaA;
drop view v1AA;
select Aaa.col1 from t1Aa as AaA;
create view v1Aa as select Aaa.col1 from t1Aa as AaA;
drop view v1AA;
create view v1Aa as select AaA.col1 from t1Aa as AaA;
drop view v1AA;
drop table t1Aa;


--
-- Bug #31562: HAVING and lower case
--

--source include/turn_off_only_full_group_by.inc
CREATE TABLE  t1 (a int, b int);

select X.a from t1 AS X group by X.b having (X.a = 1);
select X.a from t1 AS X group by X.b having (x.a = 1);
select X.a from t1 AS X group by X.b having (x.b = 1);

CREATE OR REPLACE VIEW v1 AS
select X.a from t1 AS X group by X.b having (X.a = 1);

SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE `ttt` (
  `f1` char(3) NOT NULL,
  PRIMARY KEY (`f1`)
)DEFAULT CHARSET=latin1;

SELECT count(COLUMN_NAME) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME =
'TTT';
SELECT count(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = 'TTT';

DROP TABLE `ttt`;
