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
