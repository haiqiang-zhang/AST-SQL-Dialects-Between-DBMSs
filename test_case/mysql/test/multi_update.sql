select count(*) from t1 where id1 > 95;
update t1,t2,t3 set t1.t="aaa", t2.t="bbb", t3.t="cc" where  t1.id1 = t2.id2 and t2.id2 = t3.id3  and t1.id1 > 90;
delete t1.*, t2.*, t3.*  from t1,t2,t3 where t1.id1 = t2.id2 and t2.id2 = t3.id3  and t1.id1 > 95;
delete t1, t2, t3  from t1,t2,t3 where t1.id1 = t2.id2 and t2.id2 = t3.id3  and t1.id1 > 5;
delete from t1, t2, t3  using t1,t2,t3 where t1.id1 = t2.id2 and t2.id2 = t3.id3  and t1.id1 > 0;
drop table t1,t2,t3;
create table t1(id1 int not null  primary key, t varchar(100)) pack_keys = 1;
create table t2(id2 int not null, t varchar(100), index(id2)) pack_keys = 1;
delete t1  from t1,t2 where t1.id1 = t2.id2 and t1.id1 > 500;
drop table t1,t2;
CREATE TABLE t1 (
  id int(11) NOT NULL default '0',
  name varchar(10) default NULL,
  PRIMARY KEY  (id)
);
INSERT INTO t1 VALUES (1,'aaa'),(2,'aaa'),(3,'aaa');
CREATE TABLE t2 (
  id int(11) NOT NULL default '0',
  name varchar(10) default NULL,
  PRIMARY KEY  (id)
);
INSERT INTO t2 VALUES (2,'bbb'),(3,'bbb'),(4,'bbb');
CREATE TABLE t3 (
  id int(11) NOT NULL default '0',
  mydate datetime default NULL,
  PRIMARY KEY  (id)
);
INSERT INTO t3 VALUES (1,'2002-02-04 00:00:00'),(3,'2002-05-12 00:00:00'),(5,'2002-05-12 00:00:00'),(6,'2002-06-22
00:00:00'),(7,'2002-07-22 00:00:00');
delete t1,t2,t3 from t1,t2,t3 where to_days(now())-to_days(t3.mydate)>=30 and t3.id=t1.id and t3.id=t2.id;
select * from t3;
DROP TABLE t1,t2,t3;
CREATE TABLE IF NOT EXISTS `t1` (
  `id` int(11) NOT NULL auto_increment,
  `tst` text,
  `tst1` text,
  PRIMARY KEY  (`id`)
);
CREATE TABLE IF NOT EXISTS `t2` (
  `ID` int(11) NOT NULL auto_increment,
  `ParId` int(11) default NULL,
  `tst` text,
  `tst1` text,
  PRIMARY KEY  (`ID`),
  KEY `IX_ParId_t2` (`ParId`),
  FOREIGN KEY (`ParId`) REFERENCES `t1` (`id`)
);
INSERT INTO t1(tst,tst1) VALUES("MySQL","MySQL AB"), ("MSSQL","Microsoft"), ("ORACLE","ORACLE");
INSERT INTO t2(ParId) VALUES(1), (2), (3);
select * from t2;
UPDATE t2, t1 SET t2.tst = t1.tst, t2.tst1 = t1.tst1 WHERE t2.ParId = t1.Id;
select * from t2;
drop table t2, t1;
create table t1 (n numeric(10));
create table t2 (n numeric(10));
insert into t2 values (1),(2),(4),(8),(16),(32);
select * from t2 left outer join t1  using (n);
delete  t1,t2 from t2 left outer join t1  using (n);
select * from t2 left outer join t1  using (n);
drop table t1,t2;
create table t1 (n int(10) not null primary key, d int(10));
create table t2 (n int(10) not null primary key, d int(10));
insert into t1 values(1,1);
insert into t2 values(1,10),(2,20);
LOCK TABLES t1 write, t2 read;
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
unlock tables;
LOCK TABLES t1 write, t2 write;
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
select * from t1;
DELETE t1.*, t2.* FROM t1,t2 where t1.n=t2.n;
select * from t1;
select * from t2;
unlock tables;
drop table t1,t2;
create table t1 (n int(10), d int(10));
create table t2 (n int(10), d int(10));
insert into t1 values(1,1);
insert into t2 values(1,10),(2,20);
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
drop table t1,t2;
create table t1 (n int(10) not null primary key, d int(10), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
create table t2 (n int(10) not null primary key, d int(10), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1(n,d) values(1,1);
insert into t2(n,d) values(1,10),(2,20);
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
select n,d,unix_timestamp(t) from t1;
drop table t1,t2;
create table t1 (n int(10) not null primary key, d int(10));
create table t2 (n int(10) not null primary key, d int(10));
insert into t1 values(1,1), (3,3);
insert into t2 values(1,10),(2,20);
UPDATE t2 left outer join t1 on t1.n=t2.n  SET t1.d=t2.d;
select * from t1;
select * from t2;
drop table t1,t2;
create table t1 (n int(10), d int(10));
create table t2 (n int(10), d int(10));
insert into t1 values(1,1),(1,2);
insert into t2 values(1,10),(2,20);
UPDATE t1,t2 SET t1.d=t2.d,t2.d=30 WHERE t1.n=t2.n;
select * from t1;
select * from t2;
drop table t1,t2;
create table t1 (n int(10), d int(10));
create table t2 (n int(10), d int(10));
insert into t1 values(1,1),(3,2);
insert into t2 values(1,10),(1,20);
UPDATE t1,t2 SET t1.d=t2.d,t2.d=30 WHERE t1.n=t2.n;
select * from t1;
select * from t2;
UPDATE t1 a ,t2 b SET a.d=b.d,b.d=30 WHERE a.n=b.n;
select * from t1;
select * from t2;
DELETE a, b  FROM t1 a,t2 b where a.n=b.n;
select * from t1;
select * from t2;
drop table t1,t2;
CREATE TABLE t1 ( broj int(4) unsigned NOT NULL default '0',  naziv char(25) NOT NULL default 'NEPOZNAT',  PRIMARY KEY  (broj));
INSERT INTO t1 VALUES (1,'jedan'),(2,'dva'),(3,'tri'),(4,'xxxxxxxxxx'),(5,'a'),(10,''),(11,''),(12,''),(13,'');
CREATE TABLE t2 ( broj int(4) unsigned NOT NULL default '0',  naziv char(25) NOT NULL default 'NEPOZNAT',  PRIMARY KEY  (broj));
INSERT INTO t2 VALUES (1,'jedan'),(2,'dva'),(3,'tri'),(4,'xxxxxxxxxx'),(5,'a');
CREATE TABLE t3 ( broj int(4) unsigned NOT NULL default '0',  naziv char(25) NOT NULL default 'NEPOZNAT',  PRIMARY KEY  (broj));
INSERT INTO t3 VALUES (1,'jedan'),(2,'dva');
update t1,t2 set t1.naziv="aaaa" where t1.broj=t2.broj;
update t1,t2,t3 set t1.naziv="bbbb", t2.naziv="aaaa" where t1.broj=t2.broj and t2.broj=t3.broj;
drop table t1,t2,t3;
CREATE TABLE t1 (a int not null primary key, b int not null, key (b));
CREATE TABLE t2 (a int not null primary key, b int not null, key (b));
INSERT INTO t1 values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9);
INSERT INTO t2 values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9);
update t1,t2 set t1.a=t1.a+100;
select * from t1;
update t1,t2 set t1.a=t1.a+100 where t1.a=101;
select * from t1;
update t1,t2 set t1.b=t1.b+10 where t1.b=2;
select * from t1;
update t1,t2 set t1.b=t1.b+2,t2.b=t1.b+10 where t1.b between 3 and 5 and t2.a=t1.a-100;
select * from t1;
select * from t2;
update t1,t2 set t1.b=t2.b, t1.a=t2.a where t1.a=t2.a and not exists (select * from t2 where t2.a > 10);
drop table t1,t2;
CREATE TABLE t3 (  KEY1 varchar(50) NOT NULL default '',  PARAM_CORR_DISTANCE_RUSH double default NULL,  PARAM_CORR_DISTANCE_GEM double default NULL,  PARAM_AVG_TARE double default NULL,  PARAM_AVG_NB_DAYS double default NULL,  PARAM_DEFAULT_PROP_GEM_SRVC varchar(50) default NULL,  PARAM_DEFAULT_PROP_GEM_NO_ETIK varchar(50) default NULL,  PARAM_SCENARIO_COSTS varchar(50) default NULL,  PARAM_DEFAULT_WAGON_COST double default NULL,  tmp int(11) default NULL,  PRIMARY KEY  (KEY1));
INSERT INTO t3 VALUES ('A',1,1,22,3.2,'R','R','BASE2',0.24,NULL);
create table t1 (A varchar(1));
insert into t1 values  ("A") ,("B"),("C"),("D");
create table t2(Z varchar(15));
insert into t2(Z)  select concat(a.a,b.a,c.a,d.a) from t1 as a, t1 as b, t1 as c, t1 as d;
update t2,t3 set Z =param_scenario_costs;
drop table t1,t2,t3;
create table t1 (a int, b int);
create table t2 (a int, b int);
insert into t1 values (1,1),(2,1),(3,1);
insert into t2 values (1,1), (3,1);
update t1 left join t2  on t1.a=t2.a set t1.b=2, t2.b=2 where t1.b=1 and t2.b=1 or t2.a is NULL;
select t1.a, t1.b,t2.a, t2.b from t1 left join t2  on t1.a=t2.a where t1.b=1 and t2.b=1 or t2.a is NULL;
drop table t1,t2;
create table t1 (a int not null auto_increment primary key, b int not null);
insert into t1 (b) values (1),(2),(3),(4);
update t1, t1 as t2 set t1.b=t2.b+1 where t1.a=t2.a;
select * from t1;
drop table t1;
create table t1(id1 smallint(5), field char(5));
create table t2(id2 smallint(5), field char(5));
insert into t1 values (1, 'a'), (2, 'aa');
insert into t2 values (1, 'b'), (2, 'bb');
select * from t1;
select * from t2;
update t2 inner join t1 on t1.id1=t2.id2
  set t2.field=t1.field
  where 0=1;
update t2, t1 set t2.field=t1.field
  where t1.id1=t2.id2 and 0=1;
delete t1, t2 from t2 inner join t1 on t1.id1=t2.id2
  where 0=1;
delete t1, t2 from t2,t1
  where t1.id1=t2.id2 and 0=1;
drop table t1,t2;
CREATE TABLE t1 ( a int );
CREATE TABLE t2 ( a int );
DELETE t1 FROM t1, t2 AS t3;
DELETE t4 FROM t1, t1 AS t4;
DELETE t3 FROM t1 AS t3, t1 AS t4;
INSERT INTO t1 values (1),(2);
INSERT INTO t2 values (1),(2);
DELETE t1 FROM t1 AS t2, t2 AS t1 where t1.a=t2.a and t1.a=1;
SELECT * from t1;
SELECT * from t2;
DELETE t2 FROM t1 AS t2, t2 AS t1 where t1.a=t2.a and t1.a=2;
SELECT * from t1;
SELECT * from t2;
DROP TABLE t1,t2;
create table `t1` (`p_id` int(10) unsigned NOT NULL auto_increment, `p_code` varchar(20) NOT NULL default '', `p_active` tinyint(1) unsigned NOT NULL default '1', PRIMARY KEY (`p_id`) );
create table `t2` (`c2_id` int(10) unsigned NOT NULL auto_increment, `c2_p_id` int(10) unsigned NOT NULL default '0', `c2_note` text NOT NULL, `c2_active` tinyint(1) unsigned NOT NULL default '1', PRIMARY KEY (`c2_id`), KEY `c2_p_id` (`c2_p_id`) );
insert into t1 values (0,'A01-Comp',1);
insert into t1 values (0,'B01-Comp',1);
insert into t2 values (0,1,'A Note',1);
update t1 left join t2 on p_id = c2_p_id set c2_note = 'asdf-1' where p_id = 2;
select * from t1;
select * from t2;
drop table t1, t2;
create database mysqltest;
create table mysqltest.t1 (a int, b int, primary key (a));
create table mysqltest.t2 (a int, b int, primary key (a));
create table mysqltest.t3 (a int, b int, primary key (a));
drop database mysqltest;
create table t1 (a int, primary key (a));
create table t2 (a int, primary key (a));
create table t3 (a int, primary key (a));
drop table t1, t2, t3;
create table t1 (col1 int);
create table t2 (col1 int);
drop table t1,t2;
create table t1 (
  aclid bigint not null primary key,
  status tinyint(1) not null
) engine = innodb;
create table t2 (
  refid bigint not null primary key,
  aclid bigint, index idx_acl(aclid)
) engine = innodb;
insert into t2 values(1,null);
delete t2, t1 from t2 left join t1 on (t2.aclid=t1.aclid) where t2.refid='1';
drop table t1, t2;
create table t1(a int);
create table t2(a int);
drop table t1, t2;
create table t1 ( c char(8) not null ) engine=innodb;
insert into t1 values ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9');
insert into t1 values ('A'),('B'),('C'),('D'),('E'),('F');
alter table t1 add b char(8) not null;
alter table t1 add a char(8) not null;
alter table t1 add primary key (a,b,c);
update t1 set a=c, b=c;
create table t2 like t1;
insert into t2 select * from t1;
delete t1,t2 from t2,t1 where t1.a<'B' and t2.b=t1.b;
drop table t1,t2;
create table t1 ( c char(8) not null ) engine=innodb;
insert into t1 values ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9');
insert into t1 values ('A'),('B'),('C'),('D'),('E'),('F');
alter table t1 add b char(8) not null;
alter table t1 add a char(8) not null;
alter table t1 add primary key (a,b,c);
update t1 set a=c, b=c;
create table t2 like t1;
insert into t2 select * from t1;
delete t1,t2 from t2,t1 where t1.a<'B' and t2.b=t1.b;
drop table t1,t2;
create table t1 (a int, b int);
insert into t1 values (1, 2), (2, 3), (3, 4);
create table t2 (a int);
insert into t2 values (10), (20), (30);
create view v1 as select a as b, a/10 as a from t2;
lock table t1 write;
unlock tables;
select * from t1;
select * from t2;
drop view v1;
drop table t1, t2;
create table t1 (i1 int, i2 int, i3 int);
create table t2 (id int, c1 varchar(20), c2 varchar(20));
insert into t1 values (1,5,10),(3,7,12),(4,5,2),(9,10,15),(2,2,2);
insert into t2 values (9,"abc","def"),(5,"opq","lmn"),(2,"test t","t test");
select * from t1 order by i1;
select * from t2;
update t1,t2 set t1.i2=15, t2.c2="ppc" where t1.i1=t2.id;
select * from t1 order by i1;
select * from t2 order by id;
delete t1.*,t2.* from t1,t2 where t1.i2=t2.id;
select * from t1 order by i1;
select * from t2 order by id;
drop table t1, t2;
create table t1 (i1 int auto_increment not null, i2 int, i3 int, primary key (i1));
create table t2 (id int auto_increment not null, c1 varchar(20), c2 varchar(20), primary key(id));
insert into t1 values (1,5,10),(3,7,12),(4,5,2),(9,10,15),(2,2,2);
insert into t2 values (9,"abc","def"),(5,"opq","lmn"),(2,"test t","t test");
select * from t1 order by i1;
select * from t2 order by id;
update t1,t2 set t1.i2=15, t2.c2="ppc" where t1.i1=t2.id;
select * from t1 order by i1;
select * from t2 order by id;
delete t1.*,t2.* from t1,t2 where t1.i2=t2.id;
select * from t1 order by i1;
select * from t2 order by id;
drop table t1, t2;
drop table if exists t1, t2, t3;
CREATE TABLE t1 (a int, PRIMARY KEY (a));
CREATE TABLE t2 (a int, PRIMARY KEY (a));
CREATE TABLE t3 (a int, PRIMARY KEY (a));
insert into t2 values (1),(2);
insert into t3 values (1),(2);
delete t3.* from t2,t3 where t2.a=t3.a;
drop table t1, t2, t3;
CREATE TABLE t1( a INT, KEY( a ) );
INSERT INTO t1 VALUES (1), (2), (3);
UPDATE IGNORE t1, t1 t1a SET t1.a = 1 WHERE t1a.a = 1;
DROP TABLE t1;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES (1), (2);
CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES (1), (2);
UPDATE IGNORE
  ( SELECT ( SELECT COUNT(*) FROM t1 GROUP BY a, @v ) a FROM t2 ) x, t3
SET t3.a = 0;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (f1 DATE);
INSERT INTO t1 VALUES('2001-01-01');
DROP TABLE t1;
CREATE TABLE t1(a TEXT, FULLTEXT(a)) engine = blackhole;
UPDATE IGNORE (SELECT 1 FROM t1 WHERE(MATCH(a) AGAINST(''))) `x`,`t1` SET a = 1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT) ENGINE=InnoDB;
CREATE TABLE t2 (f1 INT PRIMARY KEY, f2 INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (5, 7);
INSERT INTO t2 VALUES (6, 97);
CREATE ALGORITHM = MERGE VIEW v1 AS 
SELECT a2.f1 AS f1, a2.f2 AS f2
FROM t1 AS a1 JOIN t2 AS a2 ON a1.f2 > a2.f1 
WITH LOCAL CHECK OPTION;
SELECT * FROM v1;
UPDATE v1 SET f1 = 1;
SELECT * FROM v1;
DROP TABLE t1, t2;
DROP VIEW v1;
DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (id INT PRIMARY KEY);
INSERT INTO t1 VALUES (1), (2);
UPDATE IGNORE t1, (SELECT 1 AS duplicate_id) AS t2 SET t1.id=t2.duplicate_id;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
CREATE VIEW v AS SELECT t1.a FROM t1,t1 q;
DROP TABLE t1;
DROP VIEW v;
CREATE TABLE t1 (f1 INTEGER PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (f1 INTEGER PRIMARY KEY, f2 INTEGER) ENGINE=InnoDB;
CREATE TABLE t3 (f1 INTEGER) ENGINE=INNODB;
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 1), (2, 2);
INSERT INTO t3 VALUES (1), (2);
CREATE VIEW v2 AS 
SELECT * FROM t2 WHERE f2 IN (SELECT f1 FROM t3)
WITH CHECK OPTION;
SELECT * FROM t1 JOIN v2 ON t1.f1=v2.f1;
UPDATE t1 JOIN v2 ON t1.f1=v2.f1
SET f2 = f2 + 1
WHERE t1.f1=1;
SELECT * FROM t1 JOIN v2 ON t1.f1=v2.f1;
DROP VIEW v2;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 INTEGER, c2 INTEGER, KEY(c1));
CREATE TABLE t2 (c1 INTEGER, c2 INTEGER);
CREATE TABLE t3 (c1 INTEGER, c2 INTEGER);
INSERT INTO t1 VALUES(1,1),(2,2),(3,3),(4,4),(5,5);
INSERT INTO t2 VALUES(11,1),(12,1),(13,1),(14,2),(15,6);
INSERT INTO t3 VALUES(21,11),(22,11),(23,13),(24,14),(25,15);
SELECT * FROM t3 ORDER BY c1;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
INSERT INTO t1 VALUES(1,1);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(pk INTEGER PRIMARY KEY, a INTEGER);
INSERT INTO t1 VALUES(1, 10), (2, 20);
PREPARE s FROM 'UPDATE t1, (SELECT 1 FROM DUAL) AS dt SET a=a+1';
SELECT ROW_COUNT();
DEALLOCATE PREPARE s;
DROP TABLE t1;
