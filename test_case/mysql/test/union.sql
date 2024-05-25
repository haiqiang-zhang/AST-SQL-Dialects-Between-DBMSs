drop table if exists t1,t2,t3,t4,t5,t6;
CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
CREATE TABLE t2 (a int not null, b char (10) not null);
insert into t2 values (3,'c'),(4,'d'),(5,'f'),(6,'e');
select a,b from t1 union distinct select a,b from t2;
select a,b from t1 union all select a,b from t2;
select a,b from t1 union all select a,b from t2 order by b;
select a,b from t1 union all select a,b from t2 union select 7,'g';
select 0,'#' union select a,b from t1 union all select a,b from t2 union select 7,'gg';
select a,b from t1 union select a,b from t1;
select 't1',b,count(*) from t1 group by b UNION select 't2',b,count(*) from t2 group by b;
select count(*) from (
(select                      a,b from t1 limit 2)  union all (select a,b from t2 order by a)) q;
select found_rows();
select count(*) from (
select                      a,b from t1  union all select a,b from t2) q;
select sql_calc_found_rows  a,b from t1  union all select a,b from t2 limit 2;
select found_rows();
select * from t1 where a in
    (select a from t1 union select a from t1 order by (select a))
  union select * from t1 order by (select a);
create table t3 select a,b from t1 union all select a,b from t2;
insert into t3 select a,b from t1 union all select a,b from t2;
drop table t1,t2,t3;
select 1 as a,(select a union select a);
SELECT @a:=1 UNION SELECT @a:=@a+1;
create table t1 (a int);
create table t2 (a int);
insert into t1 values (1),(2),(3),(4),(5);
insert into t2 values (11),(12),(13),(14),(15);
drop table t1,t2;
CREATE TABLE t1 (
  cid smallint(5) unsigned NOT NULL default '0',
  cv varchar(250) NOT NULL default '',
  PRIMARY KEY  (cid),
  UNIQUE KEY cv (cv)
);
INSERT INTO t1 VALUES (8,'dummy');
CREATE TABLE t2 (
  cid bigint(20) unsigned NOT NULL auto_increment,
  cap varchar(255) NOT NULL default '',
  PRIMARY KEY  (cid),
  KEY cap (cap)
);
CREATE TABLE t3 (
  gid bigint(20) unsigned NOT NULL auto_increment,
  gn varchar(255) NOT NULL default '',
  must tinyint(4) default NULL,
  PRIMARY KEY  (gid),
  KEY gn (gn)
);
INSERT INTO t3 VALUES (1,'V1',NULL);
CREATE TABLE t4 (
  uid bigint(20) unsigned NOT NULL default '0',
  gid bigint(20) unsigned default NULL,
  rid bigint(20) unsigned default NULL,
  cid bigint(20) unsigned default NULL,
  UNIQUE KEY m (uid,gid,rid,cid),
  KEY uid (uid),
  KEY rid (rid),
  KEY cid (cid),
  KEY container (gid,rid,cid)
);
INSERT INTO t4 VALUES (1,1,NULL,NULL);
CREATE TABLE t5 (
  rid bigint(20) unsigned NOT NULL auto_increment,
  rl varchar(255) NOT NULL default '',
  PRIMARY KEY  (rid),
  KEY rl (rl)
);
CREATE TABLE t6 (
  uid bigint(20) unsigned NOT NULL auto_increment,
  un varchar(250) NOT NULL default '',
  uc smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (uid),
  UNIQUE KEY nc (un,uc),
  KEY un (un)
);
INSERT INTO t6 VALUES (1,'test',8);
SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test";
SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t3.must IS NOT NULL AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test";
drop table t1,t2,t3,t4,t5,t6;
CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
CREATE TABLE t2 (a int not null, b char (10) not null);
insert into t2 values (3,'c'),(4,'d'),(5,'f'),(6,'e');
create table t3 select a,b from t1 union select a,b from t2;
create table t4 (select a,b from t1) union (select a,b from t2) limit 2;
insert into  t4 select a,b from t1 union select a,b from t2;
insert into  t3 (select a,b from t1) union (select a,b from t2) limit 2;
select * from t3;
select * from t4;
drop table t1,t2,t3,t4;
create table t1 (a int);
insert into t1 values (1),(2),(3);
create table t2 (a int);
insert into t2 values (3),(4),(5);
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1) UNION all (SELECT * FROM t2)) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2)) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2)) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1) UNION all (SELECT * FROM t2 LIMIT 1)) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION SELECT * FROM t2) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION all SELECT * FROM t2) q;
select found_rows();
SELECT COUNT(*) FROM (
SELECT                     * FROM t1 UNION all SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION all SELECT * FROM t2 LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM (
SELECT                     * FROM t1 UNION SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM (
SELECT                     * FROM t1 UNION SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 100;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 100) UNION SELECT * FROM t2) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION SELECT * FROM t2) q;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 LIMIT 1) UNION SELECT * FROM t2) q;
select found_rows();
SELECT COUNT(*) FROM (
SELECT                     * FROM t1 UNION SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 2,2;
select found_rows();
SELECT COUNT(*) FROM (
(SELECT                     * FROM t1 limit 2,2) UNION SELECT * FROM t2) q;
select found_rows();
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a desc LIMIT 1;
create temporary table t1 select a from t1 union select a from t2;
drop temporary table t1;
create temporary table temp1 select a from t1 union select a from t2;
drop temporary table temp1;
drop table t1,t2;
select length(version()) > 1 as `*` UNION select 2;
create table t1 (a int);
insert into t1 values (0), (3), (1), (2);
drop table t1;
create table t1 (a int not null primary key auto_increment, b int, key(b));
create table t2 (a int not null primary key auto_increment, b int);
insert into t1 (b) values (1),(2),(2),(3);
insert into t2 (b) values (10),(11),(12),(13);
drop table t1,t2;
create table `groups` (id int not null auto_increment, primary key (id) ,user_name text );
create table users (id int not null auto_increment, primary key (id) ,group_name text );
create table t3 (id int not null auto_increment, primary key (id),user_id int,index user_idx (user_id),foreign key (user_id) references users(id),group_id int,index group_idx (group_id),foreign key (group_id) references `groups`(id) );
insert into `groups` (user_name) values ('Tester');
insert into users (group_name) values ('Group A');
insert into users (group_name) values ('Group B');
insert into t3 (user_id, group_id) values (1,1);
select 1 'is_in_group', a.user_name, c.group_name, b.id from `groups` a, t3 b, users c where a.id = b.user_id and b.group_id = c.id UNION  select 0 'is_in_group', a.user_name, c.group_name, null from `groups` a, users c;
drop table t3, users, `groups`;
create table t1 (mat_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, matintnum CHAR(6) NOT NULL, test MEDIUMINT UNSIGNED NULL);
create table t2 (mat_id MEDIUMINT UNSIGNED NOT NULL, pla_id MEDIUMINT UNSIGNED NOT NULL);
insert into t1 values (NULL, 'a', 1), (NULL, 'b', 2), (NULL, 'c', 3), (NULL, 'd', 4), (NULL, 'e', 5), (NULL, 'f', 6), (NULL, 'g', 7), (NULL, 'h', 8), (NULL, 'i', 9);
insert into t2 values (1, 100), (1, 101), (1, 102), (2, 100), (2, 103), (2, 104), (3, 101), (3, 102), (3, 105);
SELECT mp.pla_id, MIN(m1.matintnum) AS matintnum FROM t2 mp INNER JOIN t1 m1 ON mp.mat_id=m1.mat_id GROUP BY mp.pla_id union SELECT 0, 0;
drop table t1, t2;
create table t1 SELECT "a" as a UNION select "aa" as a;
select * from t1;
drop table t1;
create table t1 SELECT 12 as a UNION select "aa" as a;
select * from t1;
drop table t1;
create table t1 SELECT 12 as a UNION select 12.2 as a;
select * from t1;
drop table t1;
create table t2 (it1 tinyint, it2 tinyint not null, i int not null, ib bigint, f float, d double, y year, da date, dt datetime, sc char(10), sv varchar(10), b blob, tx text);
insert into t2 values (NULL, 1, 3, 4, 1.5, 2.5, 1972, '1972-10-22', '1972-10-22 11:50', 'testc', 'testv', 'tetetetetest', 'teeeeeeeeeeeest');
create table t1 SELECT it2 from t2 UNION select it1 from t2;
select * from t1;
drop table t1;
create table t1 SELECT it2 from t2 UNION select i from t2;
select * from t1;
drop table t1;
create table t1 SELECT i from t2 UNION select f from t2;
select * from t1;
drop table t1;
create table t1 SELECT f from t2 UNION select d from t2;
select * from t1;
drop table t1;
create table t1 SELECT ib from t2 UNION select f from t2;
select * from t1;
drop table t1;
create table t1 SELECT ib from t2 UNION select d from t2;
select * from t1;
drop table t1;
create table t1 SELECT f from t2 UNION select y from t2;
select * from t1;
drop table t1;
create table t1 SELECT f from t2 UNION select da from t2;
select * from t1;
drop table t1;
create table t1 SELECT y from t2 UNION select da from t2;
select * from t1;
drop table t1;
create table t1 SELECT y from t2 UNION select dt from t2;
select * from t1;
drop table t1;
create table t1 SELECT da from t2 UNION select dt from t2;
select * from t1;
drop table t1;
create table t1 SELECT dt from t2 UNION select trim(sc) from t2;
select trim(dt) from t1;
drop table t1;
create table t1 SELECT dt from t2 UNION select sv from t2;
select * from t1;
drop table t1;
create table t1 SELECT sc from t2 UNION select sv from t2;
select * from t1;
drop table t1;
create table t1 SELECT dt from t2 UNION select b from t2;
select * from t1;
drop table t1;
create table t1 SELECT sv from t2 UNION select b from t2;
select * from t1;
drop table t1;
create table t1 SELECT i from t2 UNION select d from t2 UNION select b from t2;
select * from t1;
drop table t1;
create table t1 SELECT sv from t2 UNION select tx from t2;
select * from t1;
drop table t1;
create table t1 SELECT b from t2 UNION select tx from t2;
select * from t1;
drop table t1,t2;
create table t1 select 1 union select -1;
select * from t1;
drop table t1;
create table t1 select _latin2"test" union select _latin2"testt";
drop table t1;
create table t1 (s char(200));
insert into t1 values (repeat("1",200));
create table t2 select * from t1;
insert into t2 select * from t1;
insert into t1 select * from t2;
insert into t2 select * from t1;
insert into t1 select * from t2;
insert into t2 select * from t1;
select count(*) from (select * from t1 union all select * from t2 order by 1) b;
select count(*) from t1;
select count(*) from t2;
drop table t1,t2;
create table t1 (a int, index (a), b int);
insert t1 values (1,1),(2,2),(3,3),(4,4),(5,5);
insert t1 select a+1, a+b from t1;
insert t1 select a+1, a+b from t1;
insert t1 select a+1, a+b from t1;
insert t1 select a+1, a+b from t1;
insert t1 select a+1, a+b from t1;
select count(*) from t1 where a=7;
select count(*) from t1 where b=13;
select count(*) from t1 where b=13 union select count(*) from t1 where a=7;
select count(*) from t1 where a=7 union select count(*) from t1 where b=13;
select a from t1 where b not in (1,2,3) union select a from t1 where b not in (4,5,6);
drop table t1;
create table t1 (col1 tinyint unsigned, col2 tinyint unsigned);
insert into t1 values (1,2),(3,4),(5,6),(7,8),(9,10);
select col1 n from t1 union select col2 n from t1 order by n;
alter table t1 add index myindex (col2);
select col1 n from t1 union select col2 n from t1 order by n;
drop  table t1;
create table t1 (i int);
insert into t1 values (1);
select * from t1 UNION select * from t1;
select * from t1 UNION ALL select * from t1;
select * from t1 UNION select * from t1 UNION ALL select * from t1;
drop table t1;
select 1 as a union all select 1 union all select 2 union select 1 union all select 2;
select 1 union select 2;
create table t1 (a int);
insert into t1 values (100), (1);
create table t2 (a int);
insert into t2 values (100);
select a from t1 union select a from t2 order by a;
select a from t1 union select a from t2 order by a;
drop table t1, t2;
CREATE TABLE t1 (i int(11) default NULL,c char(1) default NULL,KEY i (i));
CREATE TABLE t2 (i int(11) default NULL,c char(1) default NULL,KEY i (i));
drop table t1, t2;
CREATE TABLE t1 (uid int(1));
INSERT INTO t1 SELECT 150;
SELECT 'a' UNION SELECT uid FROM t1;
drop table t1;
create table t1 (a ENUM('Yes', 'No') NOT NULL);
create table t2 (a ENUM('aaa', 'bbb') NOT NULL);
insert into t1 values ('No');
insert into t2 values ('bbb');
create table t3 (a SET('Yes', 'No') NOT NULL);
create table t4 (a SET('aaa', 'bbb') NOT NULL);
insert into t3 values (1);
insert into t4 values (3);
select "1" as a union select a from t1;
select a as a from t1 union select "1";
select a as a from t2 union select a from t1;
select "1" as a union select a from t3;
select a as a from t3 union select "1";
select a as a from t4 union select a from t3;
select a as a from t1 union select a from t4;
drop table t1,t2,t3,t4;
create table t1 as
(select _latin1'test') union
(select _latin1'TEST') union
(select _latin1'TeST');
select count(*) from t1;
drop table t1;
create table t1 as
(select _latin1'test' collate latin1_bin) union
(select _latin1'TEST') union
(select _latin1'TeST');
select count(*) from t1;
drop table t1;
create table t1 as
(select _latin1'test') union
(select _latin1'TEST' collate latin1_bin) union
(select _latin1'TeST');
select count(*) from t1;
drop table t1;
create table t1 as
(select _latin1'test') union
(select _latin1'TEST') union
(select _latin1'TeST' collate latin1_bin);
select count(*) from t1;
drop table t1;
create table t2 (
a char character set latin1 collate latin1_swedish_ci,
b char character set latin1 collate latin1_german1_ci);
create table t1 as
(select a collate latin1_german1_ci from t2) union
(select b from t2);
drop table t1;
create table t1 as
(select a from t2) union
(select b collate latin1_german1_ci from t2);
drop table t1;
drop table t2;
create table t1(a1 int, f1 char(10));
create table t2
select f2,a1 from (select a1, CAST('2004-12-31' AS DATE) f2 from t1) a
union
select f2,a1 from (select a1, CAST('2004-12-31' AS DATE) f2 from t1) a
order by f2, a1;
drop table t1, t2;
create table t1 (f1 int);
create table t2 (f1 int, f2 int ,f3 date);
create table t3 (f1 int, f2 char(10));
create table t4
(
  select t2.f3 as sdate
  from t1
  left outer join t2 on (t1.f1 = t2.f1)
  inner join t3 on (t2.f2 = t3.f1)
  order by t1.f1, t3.f1, t2.f3
)
union
(
  select cast('2004-12-31' as date) as sdate
  from t1
  left outer join t2 on (t1.f1 = t2.f1)
  inner join t3 on (t2.f2 = t3.f1)
  group by t1.f1
  order by t1.f1, t3.f1, t2.f3
)
order by sdate;
drop table t1, t2, t3, t4;
create table t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
select * from ((select * from t1 limit 1)) a;
select * from ((select * from t1 limit 1) union (select * from t1 limit 1)) a;
select * from ((select * from t1 limit 1) union (select * from t1 limit 1) union (select * from t1 limit 1)) a;
select * from ((((select * from t1))) union (select * from t1) union (select * from t1)) a;
select * from ((select * from t1) union (((select * from t1))) union (select * from t1)) a;
drop table t1;
select concat('value is: ', @val) union select 'some text';
select concat(_latin1'a', _ascii'b' collate ascii_bin);
create table t1 (foo varchar(100)) collate ascii_bin;
insert into t1 (foo) values ("foo");
select foo from t1 union select 'bar' as foo from dual;
drop table t1;
CREATE TABLE t1 (
  a ENUM('ÃÂ¤','ÃÂ¶','ÃÂ¼') character set utf8mb3 not null default 'ÃÂ¼',
  b ENUM("one", "two") character set utf8mb3,
  c ENUM("one", "two")
);
insert into t1 values ('ÃÂ¤', 'one', 'one'), ('ÃÂ¶', 'two', 'one'), ('ÃÂ¼', NULL, NULL);
create table t2 select NULL union select a from t1;
drop table t2;
create table t2 select a from t1 union select NULL;
drop table t2;
create table t2 select a from t1 union select a from t1;
drop table t2;
create table t2 select a from t1 union select c from t1;
drop table t2;
create table t2 select a from t1 union select b from t1;
drop table t2, t1;
create table t1 (f1 decimal(60,25), f2 decimal(60,25));
insert into t1 values (0.0,0.0);
select f1 from t1 union all select f2 from t1;
select 'XXXXXXXXXXXXXXXXXXXX' as description, f1 from t1
union all
select 'YYYYYYYYYYYYYYYYYYYY' as description, f2 from t1;
drop table t1;
create table t1 (f1 decimal(60,24), f2 decimal(60,24));
insert into t1 values (0.0,0.0);
select f1 from t1 union all select f2 from t1;
select 'XXXXXXXXXXXXXXXXXXXX' as description, f1 from t1
union all
select 'YYYYYYYYYYYYYYYYYYYY' as description, f2 from t1;
drop table t1;
create table t1 (a varchar(5));
create table t2 select * from t1 union select 'abcdefghijkl';
select row_format from information_schema.TABLES where table_schema="test" and table_name="t2";
drop table t1,t2;
CREATE TABLE t1 (a mediumtext);
CREATE TABLE t2 (b varchar(20));
INSERT INTO t1 VALUES ('a'),('b');
SELECT left(a,100000000) FROM t1 UNION  SELECT b FROM t2;
create table t3 SELECT left(a,100000000) FROM t1 UNION  SELECT b FROM t2;
drop tables t1,t2,t3;
CREATE TABLE t1 (a longtext);
CREATE TABLE t2 (b varchar(20));
INSERT INTO t1 VALUES ('a'),('b');
SELECT left(a,100000000) FROM t1 UNION  SELECT b FROM t2;
create table t3 SELECT left(a,100000000) FROM t1 UNION  SELECT b FROM t2;
drop tables t1,t2,t3;
SELECT @tmp_max:= @@global.max_allowed_packet;
CREATE TABLE t1 (a mediumtext);
CREATE TABLE t2 (b varchar(20));
INSERT INTO t1 VALUES ('a');
CREATE TABLE t3 SELECT REPEAT(a,20000000) AS a FROM t1 UNION SELECT b FROM t2;
DROP TABLES t1,t3;
CREATE TABLE t1 (a tinytext);
INSERT INTO t1 VALUES ('a');
CREATE TABLE t3 SELECT REPEAT(a,2) AS a FROM t1 UNION SELECT b FROM t2;
DROP TABLES t1,t3;
CREATE TABLE t1 (a mediumtext);
INSERT INTO t1 VALUES ('a');
CREATE TABLE t3 SELECT REPEAT(a,2) AS a FROM t1 UNION SELECT b FROM t2;
DROP TABLES t1,t3;
CREATE TABLE t1 (a tinyblob);
INSERT INTO t1 VALUES ('a');
CREATE TABLE t3 SELECT REPEAT(a,2) AS a FROM t1 UNION SELECT b FROM t2;
DROP TABLES t1,t2,t3;
create table t1 ( id int not null auto_increment, primary key (id), col1 int);
insert into t1 (col1) values (2),(3),(4),(5),(6);
select 99 union all select id from t1 order by 1;
select id from t1 union all select 99 order by 1;
drop table t1;
select _utf8mb3'12' union select _latin1'12345';
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (3),(1),(2),(4),(1);
SELECT a FROM (SELECT a FROM t1 UNION SELECT a FROM t1 ORDER BY a) AS test;
DROP TABLE t1;
select @var;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (10), (20);
CREATE TABLE t2 (b int);
INSERT INTO t2 VALUES (10), (50), (50);
SELECT a,1 FROM t1
UNION
SELECT b, COUNT(*) FROM t2 GROUP BY b WITH ROLLUP
ORDER BY a;
SELECT a,1 FROM t1
UNION
SELECT b, COUNT(*) FROM t2 GROUP BY b WITH ROLLUP
ORDER BY a DESC;
SELECT a,1 FROM t1
UNION
SELECT b, COUNT(*) FROM t2 GROUP BY b WITH ROLLUP
ORDER BY a ASC LIMIT 3;
SELECT a,1 FROM t1
UNION ALL
SELECT b, COUNT(*) FROM t2 GROUP BY b WITH ROLLUP
ORDER BY a DESC;
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TABLE t2 SELECT * FROM (SELECT NULL) a UNION SELECT a FROM t1;
CREATE TABLE t3 SELECT a FROM t1 UNION SELECT * FROM (SELECT NULL) a;
CREATE TABLE t4 SELECT NULL;
CREATE TABLE t5 SELECT NULL UNION SELECT NULL;
CREATE TABLE t6
SELECT * FROM (SELECT * FROM (SELECT NULL)a) b UNION SELECT a FROM t1;
DROP TABLE t1, t2, t3, t4, t5, t6;
CREATE TABLE t1 (f FLOAT(9,6));
CREATE TABLE t2 AS SELECT f FROM t1 UNION SELECT f FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1(d DOUBLE(9,6));
CREATE TABLE t2 AS SELECT d FROM t1 UNION SELECT d FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
SELECT a FROM t1
UNION
SELECT a FROM t1
ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
SELECT a INTO @v FROM (
  SELECT a FROM t1
  UNION
  SELECT a FROM t1
) alias;
SELECT a FROM t1 UNION SELECT a INTO @v FROM t1;
SELECT ( SELECT a UNION SELECT a ) INTO @v FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10), FULLTEXT KEY a (a));
INSERT INTO t1 VALUES (1),(2);
CREATE TABLE t2 (b INT);
INSERT INTO t2 VALUES (1),(2);
SELECT * FROM t1 UNION SELECT * FROM t1 ORDER BY a + 12;
SELECT * FROM t1 UNION SELECT * FROM t1 ORDER BY a + 12;
SELECT * FROM t1 UNION SELECT * FROM t1
  ORDER BY (SELECT a FROM t2 WHERE b = 12);
SELECT * FROM t1 UNION SELECT * FROM t1
  ORDER BY (SELECT a FROM t2 WHERE b = 12);
SELECT * FROM t2 UNION SELECT * FROM t2
  ORDER BY (SELECT * FROM t1 WHERE MATCH(a) AGAINST ('+abc' IN BOOLEAN MODE));
DROP TABLE t1,t2;
CREATE TABLE t1 (c1 VARCHAR(10) NOT NULL, c2 INT NOT NULL);
CREATE TABLE t2 (c1 VARCHAR(10) NOT NULL, c2 INT NOT NULL);
INSERT INTO t1 (c1, c2) VALUES ('t1a', 1), ('t1a', 2), ('t1a', 3), ('t1b', 2), ('t1b', 1);
INSERT INTO t2 (c1, c2) VALUES ('t2a', 1), ('t2a', 2), ('t2a', 3), ('t2b', 2), ('t2b', 1);
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY c2, c1;
SELECT * FROM t1 UNION (SELECT * FROM t2) ORDER BY c2, c1;
SELECT * FROM t1 UNION (SELECT * FROM t2 ORDER BY c2, c1);
SELECT c1, c2 FROM (
  SELECT c1, c2 FROM t1
  UNION
  (SELECT c1, c2 FROM t2)
  ORDER BY c2, c1
) AS res;
SELECT c1, c2 FROM (
  SELECT c1, c2 FROM t1
  UNION
  (SELECT c1, c2 FROM t2)
  ORDER BY c2 DESC, c1 LIMIT 1
) AS res;
SELECT c1, c2 FROM (
  SELECT c1, c2 FROM t1
  UNION
  (SELECT c1, c2 FROM t2 ORDER BY c2 DESC, c1 LIMIT 1)
) AS res;
SELECT c1, c2 FROM (
  SELECT c1, c2 FROM t1
  UNION
  SELECT c1, c2 FROM t2
  ORDER BY c2 DESC, c1 DESC LIMIT 1
) AS res;
SELECT c1, c2 FROM (
  (
   (SELECT c1, c2 FROM t1)
   UNION
   (SELECT c1, c2 FROM t2)
  )
  ORDER BY c2 DESC, c1 ASC LIMIT 1
) AS res;
DROP TABLE t1, t2;
create table t1(b int) engine=innodb;
select b as z from t1 union select b from t1 order by z;
select b as z from t1 union select b from t1 order by (select z);
select b as z from t1 union (select b from t1) order by (select z);
drop table t1;
CREATE TABLE t1 (a TIME);
CREATE TABLE t2 (b DATETIME);
CREATE TABLE t3
SELECT a FROM t1 UNION ALL SELECT b FROM t2;
SELECT column_name, column_type
FROM information_schema.columns
WHERE TABLE_NAME='t3';
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a VARCHAR(1));
INSERT INTO t1 VALUES (NULL);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t1 VALUES ('j');
INSERT INTO t1 VALUES ('k');
INSERT INTO t1 VALUES ('r');
INSERT INTO t1 VALUES ('r');
INSERT INTO t1 VALUES ('h');
SELECT a FROM t1 WHERE a IN (SELECT 'r' FROM t1 UNION ALL SELECT 'j');
CREATE TABLE t2
SELECT a FROM t1 WHERE a IN (SELECT 'r' FROM t1 UNION ALL SELECT 'j');
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t2 VALUES (1);
SELECT FOUND_ROWS();
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=MEMORY;
CREATE TABLE t2 (a INT) ENGINE=MEMORY;
INSERT INTO t2 VALUES (1);
SELECT COUNT(*) FROM (
SELECT                     * FROM t2 UNION ALL SELECT * FROM t1) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t2 UNION ALL SELECT * FROM t1;
SELECT FOUND_ROWS();
SELECT COUNT(*) FROM (
SELECT                     * FROM t1 UNION ALL SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION ALL SELECT * FROM t2;
SELECT FOUND_ROWS();
DROP TABLE t1, t2;
SELECT MAX(1) AS foo
UNION
SELECT MAX(2)
ORDER BY foo;
SELECT MAX(1) AS foo
UNION
SELECT MAX(2)
ORDER BY 1 DESC;
CREATE TABLE t1(a INTEGER);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2(a INTEGER, b INTEGER);
INSERT INTO t2 VALUES (1,10), (2,20);
DROP TABLE t1, t2;
CREATE TABLE t1(g GEOMETRY, p POINT, l LINESTRING);
INSERT INTO t1 (p, l) VALUES (ST_GeomFromText('POINT(1 1)'),
                              ST_GeomFromText('LINESTRING(0 0,1 1,2 2)'));
SELECT ST_AsText(a) FROM (SELECT p AS a FROM t1 UNION SELECT l FROM t1) t;
CREATE TABLE t2 ENGINE=InnoDB SELECT a FROM
  (SELECT p AS a FROM t1 UNION SELECT l FROM t1) t;
DROP TABLE t1, t2;
CREATE TABLE geometries (
  g GEOMETRY,
  pt POINT,
  ls LINESTRING,
  py POLYGON,
  mpt MULTIPOINT,
  mls MULTILINESTRING,
  mpy MULTIPOLYGON,
  gc GEOMETRYCOLLECTION);
INSERT INTO geometries VALUES (
  ST_GeomFromText('POLYGON((0 0, 9 0, 9 9, 0 9, 0 0), (2 2, 4 2, 4 4, 2 2))'),
  ST_GeomFromText('POINT(0 0)'),
  ST_GeomFromText('LINESTRING(0 0, 10 10)'),
  ST_GeomFromText('POLYGON((0 0, 9 0, 9 9, 0 9, 0 0), (2 2, 4 2, 4 4, 2 2))'),
  ST_GeomFromText('MULTIPOINT(0 0, 1 1, 2 2)'),
  ST_GeomFromText('MULTILINESTRING((0 0, 10 10), (10 0, 0 10))'),
  ST_GeomFromText('MULTIPOLYGON(((0 0, 9 0, 9 9, 0 0)), '
                               '((2 2, 3 2, 3 3, 2 2)))'),
  ST_GeomFromText('GEOMETRYCOLLECTION(POINT(1 1), LINESTRING(2 2, 3 3), '
                                     'POLYGON((0 0, 9 0, 9 9, 0 9, 0 0)))'));
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT g FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT pt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT ls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT py FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT mpt FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT mls FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT mpy FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT g AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT pt AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT ls AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT py AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpt AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mls AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT mpy AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT a FROM
  (SELECT gc AS a FROM geometries UNION SELECT gc FROM geometries) t;
DROP TABLE t1;
DROP TABLE geometries;
CREATE TABLE t1(a INT) engine=innodb;
CREATE TABLE t2(a SET('a'))engine=innodb;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
SELECT a FROM (SELECT a FROM t2) t1
UNION ALL
SELECT 1 FROM t1;
DROP TABLE t1, t2;
SELECT COUNT(*) FROM (SELECT NULL UNION SELECT POINT(1,1)) AS dt;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2);
CREATE TABLE t2 LIKE t1;
SELECT * FROM t1 UNION ALL SELECT * FROM t1;
INSERT INTO t2
SELECT * FROM t1 UNION ALL SELECT * FROM t1;
SELECT * FROM t2;
DELETE FROM t2;
INSERT INTO t2
SELECT * FROM (SELECT * FROM t1 UNION ALL SELECT * FROM t1) AS dt;
SELECT * FROM t2;
DROP TABLE t1,t2;
SELECT 1 UNION ALL SELECT 2;
SELECT 1 UNION DISTINCT SELECT 2;
CREATE TABLE t1(
  a tinyint(4) DEFAULT NULL,
  b int(11) DEFAULT NULL,
  c bigint(20) DEFAULT NULL
);
CREATE VIEW v1 AS SELECT t1.a AS a, t1.b AS b,t1.c AS c, 1 AS
`1`, 1 AS `Name_exp_1`, 1 AS `Name_exp_1_1` FROM t1 UNION SELECT -(1) AS `-1`,
-(1) AS `-1`, -(1) AS `-1`, -(1) AS `-1`, -(1) AS `-1`, -(1) AS `-1`;
CREATE VIEW v2 AS SELECT 1 AS `1`, 1 AS `Name_exp_1`, 1 AS `Name_exp_1_1`,
-(1) AS `-1`, -(1) AS `Name_exp_-1`, -(1) AS `Name_exp_1_-1`;
CREATE VIEW v3 AS SELECT t1.a AS a, t1.b AS b, t1.c AS c FROM t1;
DROP TABLE t1;
DROP VIEW v1,v2,v3;
CREATE TABLE `t1` (`date` date NOT NULL);
INSERT INTO t1 VALUES ('2017-03-02'), ('2017-06-22');
CREATE TABLE IF NOT EXISTS t2 AS
SELECT * FROM t1
UNION
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (
i1 INT NOT NULL,
i2 INT NOT NULL DEFAULT '1234',
# non-specified nullability => i3 is nullable
i3 INT,
i4 INT DEFAULT NULL,
i5 INT DEFAULT '5678',
d1 date NOT NULL,
d2 date NOT NULL DEFAULT '2018-01-25',
d3 date,
d4 date DEFAULT NULL,
d5 date DEFAULT '2017-11-14',
g1 geometry
);
SELECT @@SQL_MODE;
CREATE TEMPORARY TABLE t2 AS
  SELECT * FROM t1;
DROP TEMPORARY TABLE t2;
CREATE TEMPORARY TABLE t2 AS
  SELECT * FROM t1
  UNION
  SELECT * FROM t1;
DROP TEMPORARY TABLE t2;
CREATE TEMPORARY TABLE t2 AS
  SELECT * FROM t1
  UNION ALL
  SELECT * FROM t1;
SELECT * FROM t2;
DROP TEMPORARY TABLE t2;
DROP TABLE t1;
SELECT ST_GEOMFROMTEXT('POINT(0 0)')
UNION
SELECT * FROM (SELECT NULL) AS a;
CREATE TABLE t(a VARCHAR(10) CHARSET ASCII);
SELECT _utf8mb4 'a' UNION SELECT a FROM t;
DROP TABLE t;
PREPARE stmt FROM "SELECT 'foo' UNION ALL SELECT ?";
DEALLOCATE PREPARE stmt;
PREPARE stmt FROM 'SELECT "foo", "foo2" UNION SELECT CONVERT("bar" USING utf8mb3), "bar2" UNION SELECT "foobar", CONVERT("foobar2" USING utf8mb3)';
DEALLOCATE PREPARE stmt;
CREATE PROCEDURE p1() SELECT "foo", "foo2" UNION SELECT CONVERT("bar" USING utf8mb3), "bar2" UNION SELECT "foobar", CONVERT("foobar2" USING utf8mb3);
DROP PROCEDURE p1;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t2 VALUES (1);
CREATE VIEW v1 AS SELECT * FROM t1;
DROP TABLE t1, t2;
DROP VIEW v1;
CREATE TABLE t1 (f1 VARCHAR(1));
INSERT INTO t1 VALUES ('t'),('a');
SELECT COUNT(DISTINCT f1) FROM t1 WHERE (
	SELECT MAX(f1) FROM t1 WHERE f1 NOT IN ( SELECT 5 UNION SELECT 5 )
) IS NOT NULL;
DROP TABLE t1;
CREATE TABLE t1 (f1 varchar(1));
CREATE INDEX i1 ON t1 (f1);
CREATE TABLE t2 (f1 varchar(1));
INSERT INTO t1 VALUES ('d');
INSERT INTO t2 VALUES ('d');
SELECT t1.f1 FROM t1 LEFT JOIN t2 ON EXISTS ( SELECT * FROM t1, t2 )
UNION ALL
SELECT t1.f1 FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 SELECT a+1 FROM t1;
INSERT INTO t1 SELECT a+1 FROM t1;
INSERT INTO t1 SELECT a+1 FROM t1;
INSERT INTO t1 SELECT a+1 FROM t1;
INSERT INTO t1 SELECT a+1 FROM t1;
SELECT COUNT(*) FROM t1;
SELECT * FROM t1 LIMIT 1;
SELECT * FROM t1 UNION ALL SELECT * FROM t1 LIMIT 1;
SELECT * FROM t1 UNION DISTINCT SELECT * FROM t1 LIMIT 1;
DROP TABLE t1;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  b BLOB,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (1,'');
SELECT * FROM ( SELECT * FROM t1 WHERE pk=1 UNION SELECT * FROM t1 WHERE FALSE ) d1;
DROP TABLE t1;
CREATE TABLE t1(id INTEGER SIGNED);
CREATE TABLE t2(id INTEGER UNSIGNED);
INSERT INTO t1(id) VALUES (2000000000);
INSERT INTO t2(id) VALUES (4000000000);
SELECT id FROM t2 UNION ALL SELECT id FROM t1;
SELECT MAX(id) FROM t2 UNION ALL SELECT MAX(id) FROM t1;
SELECT id FROM t1 UNION ALL SELECT id FROM t2;
SELECT MAX(id) FROM t1 UNION ALL SELECT MAX(id) FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1(
  ts TINYINT SIGNED,
  tu TINYINT UNSIGNED,
  ss SMALLINT SIGNED,
  su SMALLINT UNSIGNED,
  ms MEDIUMINT SIGNED,
  mu MEDIUMINT UNSIGNED,
  ls INTEGER SIGNED,
  lu INTEGER UNSIGNED,
  bs BIGINT SIGNED,
  bu BIGINT UNSIGNED
);
INSERT INTO t1 VALUES
 (-128, 0, -32768, 0, -8388608, 0, -2147483648, 0, -9223372036854775808, 0),
 (127, 255, 32767, 65535, 8388607, 16777215, 2147483647, 4294967295,
  9223372036854775807, 18446744073709551615);
SELECT ts, ss, ms, ls, bs, tu, su, mu, lu, bu,
       ts AS a, ss AS b, ms AS c, ls AS d, bs AS e,
       tu AS f, su AS g, mu AS h, lu AS i, bu AS j
FROM t1
UNION ALL
SELECT ts, ss, ms, ls, bs, tu, su, mu, lu, bu,
       tu, su, mu, lu, bu, ts, ss, ms, ls, bs
FROM t1;
DROP TABLE t1;
SELECT 1 UNION SELECT 1 LIMIT 0;
CREATE TABLE r(a INT);
INSERT INTO r VALUES (1), (2), (-1), (-2);
CREATE TABLE s(a INT);
INSERT INTO s VALUES (1), (10), (20), (-10), (-20);
CREATE TABLE t(a INT);
INSERT INTO t VALUES (10), (100), (200), (-100), (-200);
SELECT * FROM s UNION ALL
             SELECT * FROM t;
SELECT * FROM s UNION ALL
             SELECT * FROM t ORDER BY a;
SELECT * FROM s UNION ALL
             SELECT * FROM t ORDER BY a;
SELECT * FROM s UNION ALL
             SELECT * FROM t ORDER BY a LIMIT 11;
SELECT * FROM s UNION ALL
             SELECT * FROM t ORDER BY a LIMIT 11;
SELECT FOUND_ROWS();
DROP TABLE r, s, t;
CREATE TABLE t1 (
  a INT,
  b INT,
  PRIMARY KEY(a)
);
INSERT INTO t1 VALUES (0,0), (1,1), (2,2);
DROP TABLE t1;
CREATE TABLE t1 (c1 INTEGER);
INSERT INTO t1 (c1)
SELECT 2 UNION SELECT 1
ON DUPLICATE KEY UPDATE c1 = 1 IN (SELECT 1);
DROP TABLE t1;
