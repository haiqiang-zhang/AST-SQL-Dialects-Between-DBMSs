drop table if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop view if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop database if exists MySQLTest;
create database MySQLTest;
create table TaB (Field int);
create view ViE as select * from TAb;
drop database MySQLTest;
create table t1Aa (col1 int);
create table t2aA (col1 int);
create view v1Aa as select * from t1aA;
create view v2aA as select * from v1aA;
create view v3Aa as select v2Aa.col1 from v2aA,t2Aa where v2Aa.col1 = t2aA.col1;
drop view v3aA,v2Aa,v1aA;
drop table t1Aa,t2Aa;
create table t1Aa (col1 int);
create view v1Aa as select col1 from t1Aa as AaA;
drop view v1AA;
select Aaa.col1 from t1Aa as AaA;
create view v1Aa as select Aaa.col1 from t1Aa as AaA;
drop view v1AA;
create view v1Aa as select AaA.col1 from t1Aa as AaA;
drop view v1AA;
drop table t1Aa;
CREATE TABLE  t1 (a int, b int);
CREATE OR REPLACE VIEW v1 AS
select X.a from t1 AS X group by X.b having (X.a = 1);
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
