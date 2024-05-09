DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
  AUFNR varchar(12) NOT NULL default '',
  PLNFL varchar(6) NOT NULL default '',
  VORNR varchar(4) NOT NULL default '',
  xstatus_vor smallint(5) unsigned NOT NULL default '0'
);
INSERT INTO t1 VALUES ('40004712','000001','0010',9);
INSERT INTO t1 VALUES ('40004712','000001','0020',0);
UPDATE t1 SET t1.xstatus_vor = Greatest(t1.xstatus_vor,1) WHERE t1.aufnr =
"40004712" AND t1.plnfl = "000001" AND t1.vornr > "0010" ORDER BY t1.vornr
ASC LIMIT 1;
drop table t1;
drop table if exists t1,t2,t3;
create table t1 (a int, b int, c int);
create table t2 (d int);
create table t3 (a1 int, b1 int, c1 int);
insert into t1 values(1,2,3);
insert into t1 values(11,22,33);
insert into t2 values(99);
select t1.* from t1;
select t2.* from t2;
select t1.*, t1.* from t1;
select t1.*, a, t1.* from t1;
select a, t1.* from t1;
select t1.*, a from t1;
select a, t1.*, b from t1;
select (select d from t2 where d > a), t1.* from t1;
select t1.*, (select a from t2 where d > a) from t1;
select a as 'x', t1.* from t1;
select t1.*, a as 'x' from t1;
select a as 'x', t1.*, b as 'x' from t1;
select (select d from t2 where d > a) as 'x', t1.* from t1;
select t1.*, (select a from t2 where d > a) as 'x' from t1;
select (select t2.* from t2) from t1;
select a, (select t2.* from t2) from t1;
select t1.*, (select t2.* from t2) from t1;
insert into t3 select t1.* from t1;
insert into t3 select t2.*, 1, 2 from t2;
insert into t3 select t2.*, d as 'x', d as 'z' from t2;
insert into t3 select t2.*, t2.*, 3 from t2;
create table t4 select t1.* from t1;
drop table t4;
create table t4 select t2.*, 1, 2 from t2;
drop table t4;
create table t4 select t2.*, d as 'x', d as 'z' from t2;
drop table t4;
drop table t1,t2,t3;
