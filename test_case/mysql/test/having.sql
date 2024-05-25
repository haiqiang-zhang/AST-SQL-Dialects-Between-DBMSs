drop table if exists t1,t2,t3;
create table t1 (a int);
select count(a) as b from t1 where a=0 having b > 0;
insert into t1 values (null);
select count(a) as b from t1 where a=0 having b > 0;
select count(a) as b from t1 where a=0 having b >=0;
drop table t1;
CREATE TABLE t1 (
  raw_id int(10) NOT NULL default '0',
  chr_start int(10) NOT NULL default '0',
  chr_end int(10) NOT NULL default '0',
  raw_start int(10) NOT NULL default '0',
  raw_end int(10) NOT NULL default '0',
  raw_ori int(2) NOT NULL default '0'
);
INSERT INTO t1 VALUES (469713,1,164123,1,164123,1),(317330,164124,317193,101,153170,1),(469434,317194,375620,101,58527,1),(591816,375621,484273,1,108653,1),(591807,484274,534671,91,50488,1),(318885,534672,649362,101,114791,1),(318728,649363,775520,102,126259,1),(336829,775521,813997,101,38577,1),(317740,813998,953227,101,139330,1),(1,813998,953227,101,139330,1);
CREATE TABLE t2 (
  id int(10) unsigned NOT NULL default '0',
  contig_id int(10) unsigned NOT NULL default '0',
  seq_start int(10) NOT NULL default '0',
  seq_end int(10) NOT NULL default '0',
  strand tinyint(2) NOT NULL default '0',
  KEY id (id)
);
INSERT INTO t2 VALUES (133195,469713,61327,61384,1),(133196,469713,64113,64387,1),(133197,1,1,1,0),(133197,1,1,1,-2);
SELECT e.id,
   MIN( IF(sgp.raw_ori=1,
          (e.seq_start+sgp.chr_start-sgp.raw_start),  
          (sgp.chr_start+sgp.raw_end-e.seq_end))) as start, 
   MAX( IF(sgp.raw_ori=1,
           (e.seq_end+sgp.chr_start-sgp.raw_start),  
           (sgp.chr_start+sgp.raw_end-e.seq_start))) as end, 
   AVG(IF (sgp.raw_ori=1,e.strand,(-e.strand))) as chr_strand 
FROM  t1 sgp,
      t2 e  
WHERE sgp.raw_id=e.contig_id 
GROUP BY e.id 
HAVING chr_strand= -1 and end >= 0 
  AND start <= 999660;
drop table t1,t2;
CREATE TABLE t1 (Fld1 int(11) default NULL,Fld2 int(11) default NULL);
INSERT INTO t1 VALUES (1,10),(1,20),(2,NULL),(2,NULL),(3,50);
select Fld1, max(Fld2) as q from t1 group by Fld1 having q is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having max(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having avg(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having std(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having variance(Fld2) is not null;
drop table t1;
create table t1 (id int not null, qty int not null);
insert into t1 values (1,2),(1,3),(2,4),(2,5);
select id, sum(qty) as sqty from t1 group by id having sqty>2;
select sum(qty) as sqty from t1 group by id having count(id) > 0;
select sum(qty) as sqty from t1 group by id having count(distinct id) > 0;
drop table t1;
CREATE TABLE t1 (
  `id` bigint(20) NOT NULL default '0',
  `description` text
);
CREATE TABLE t2 (
  `id` bigint(20) NOT NULL default '0',
  `description` varchar(20)
);
INSERT INTO t1  VALUES (1, 'test');
INSERT INTO t2 VALUES (1, 'test');
CREATE TABLE t3 (
  `id`       bigint(20) NOT NULL default '0',
  `order_id` bigint(20) NOT NULL default '0'
);
select
	a.id, a.description,
	count(b.id) as c 
from t1 a left join t3 b on a.id=b.order_id 
group by a.id, a.description 
having (a.description is not null) and (c=0);
select
	a.*, 
	count(b.id) as c 
from t2 a left join t3 b on a.id=b.order_id 
group by a.id, a.description
having (a.description is not null) and (c=0);
INSERT INTO t1  VALUES (2, 'test2');
select
	a.id, a.description,
	count(b.id) as c 
from t1 a left join t3 b on a.id=b.order_id 
group by a.id, a.description 
having (a.description is not null) and (c=0);
drop table t1,t2,t3;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (3), (4), (1), (3), (1);
SELECT SUM(a) FROM t1 GROUP BY a HAVING SUM(a)>0;
SELECT SUM(a) FROM t1 GROUP BY a HAVING SUM(a);
DROP TABLE t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2), (1), (3), (2), (1);
SELECT a FROM t1 GROUP BY a HAVING a > 1;
SELECT a FROM t1 GROUP BY a HAVING 1 != 1 AND a > 1;
SELECT 0 AS x, a FROM t1 GROUP BY x,a HAVING x=1 AND a > 1;
DROP table t1;
CREATE TABLE t1 (a int PRIMARY KEY);
CREATE TABLE t2 (b int PRIMARY KEY, a int);
CREATE TABLE t3 (b int, flag int);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1,1), (2,1), (3,1);
INSERT INTO t3(b,flag) VALUES (2, 1);
SELECT t1.a
  FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b
    GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
SELECT DISTINCT t1.a, MAX(t3.flag)
  FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b
    GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
SELECT DISTINCT t1.a
  FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b
    GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
DROP TABLE t1,t2,t3;
create table t1 (col1 int, col2 varchar(5), col_t1 int);
create table t2 (col1 int, col2 varchar(5), col_t2 int);
create table t3 (col1 int, col2 varchar(5), col_t3 int);
insert into t1 values(10,'hello',10);
insert into t1 values(20,'hello',20);
insert into t1 values(30,'hello',30);
insert into t1 values(10,'bye',10);
insert into t1 values(10,'sam',10);
insert into t1 values(10,'bob',10);
insert into t2 select * from t1;
insert into t3 select * from t1;
select count(*) from t1 group by col1 having col1 = 10;
select count(*) as count_col1 from t1 group by col1 having col1 = 10;
select count(*) as count_col1 from t1 as tmp1 group by col1 having col1 = 10;
select count(*) from t1 group by col2 having col2 = 'hello';
select col1 as count_col1 from t1 as tmp1 group by col1 having col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by col1 having count_col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by count_col1 having col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by count_col1 having count_col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having count_col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having col2 = 'hello';
select col1 as count_col1,col2 as group_col2 from t1 as tmp1 group by col1,col2 having group_col2 = 'hello';
select sum(col1) as co2, count(col2) as cc from t1 group by col1 having col1 =10;
select t1.col1 from t1
where t1.col2 in 
      (select t2.col2 from t2 
       group by t2.col1, t2.col2 having t2.col1 <= 10);
select t1.col1 from t1
where t1.col2 in 
      (select t2.col2 from t2
       group by t2.col1, t2.col2
       having t2.col1 <=
              (select min(t3.col1) from t3));
select t1.col1 from t1
where t1.col2 in
      (select t2.col2 from t2 
       group by t2.col1, t2.col2 having t1.col1 <= 10);
select t1.col1 from t1
where t1.col2 in 
      (select t2.col2 from t2 
       group by t2.col1, t2.col2 having col_t1 <= 10);
select sum(col1) from t1
group by col_t1
having (select col_t1 from t2 where col_t1 = col_t2 order by col_t2 limit 1);
select col_t1, sum(col1) from t1
group by col_t1
having col_t1 > 10 and
       exists (select sum(t2.col1) from t2
               group by t2.col2 having t2.col2 > 'b');
select sum(col1) from t1
group by col_t1
having col_t1 in (select sum(t2.col1) from t2
                  group by t2.col2, t2.col1 having t2.col1 = col_t1);
drop table t1, t2, t3;
create table t1 (s1 int);
insert into t1 values (1),(2),(3);
select count(*) from t1 group by s1 having s1 is null;
select s1*0 as s1 from t1 group by s1 having s1 <> 0;
select s1*0 from t1 group by s1 having s1 = 0;
select s1 from t1 group by 1 having 1 = 0;
select count(s1) from t1 group by s1 having count(1+1)=2;
select count(s1) from t1 group by s1 having s1*0=0;
drop table t1;
create table t1 (s1 char character set latin1 collate latin1_german1_ci);
insert ignore into t1 values ('ÃÂÃÂ¼'),('y');
drop table t1;
DROP SCHEMA IF EXISTS HU;
CREATE SCHEMA HU;
CREATE TABLE STAFF
 (EMPNUM   CHAR(3) NOT NULL UNIQUE,
  EMPNAME  CHAR(20),
  GRADE    DECIMAL(4),
  CITY     CHAR(15));
CREATE TABLE PROJ
 (PNUM     CHAR(3) NOT NULL UNIQUE,
  PNAME    CHAR(20),
  PTYPE    CHAR(6),
  BUDGET   DECIMAL(9),
  CITY     CHAR(15));
INSERT INTO STAFF VALUES ('E1','Alice',12,'Deale');
INSERT INTO STAFF VALUES ('E2','Betty',10,'Vienna');
INSERT INTO STAFF VALUES ('E3','Carmen',13,'Vienna');
INSERT INTO STAFF VALUES ('E4','Don',12,'Deale');
INSERT INTO STAFF VALUES ('E5','Ed',13,'Akron');
INSERT INTO PROJ VALUES  ('P1','MXSS','Design',10000,'Deale');
INSERT INTO PROJ VALUES  ('P2','CALM','Code',30000,'Vienna');
INSERT INTO PROJ VALUES  ('P3','SDP','Test',30000,'Tampa');
INSERT INTO PROJ VALUES  ('P4','SDP','Design',20000,'Deale');
INSERT INTO PROJ VALUES  ('P5','IRM','Test',10000,'Vienna');
INSERT INTO PROJ VALUES  ('P6','PAYR','Design',50000,'Deale');
DROP SCHEMA HU;
create table t1(f1 int);
select f1 from t1 group by f1 having max(f1)=f1;
select f1 from t1 group by f1 having max(f1)=f1;
drop table t1;
CREATE TABLE t1 ( a INT, b INT);
INSERT INTO t1 VALUES (1, 1), (2,2), (3, NULL);
SELECT b, COUNT(DISTINCT a) FROM t1 GROUP BY b HAVING b is NULL;
DROP TABLE t1;
CREATE TABLE t1
(
 id1 INT,
 id2 INT NOT NULL,
 INDEX id1(id2)
);
INSERT INTO t1 SET id1=1, id2=1;
INSERT INTO t1 SET id1=2, id2=1;
INSERT INTO t1 SET id1=3, id2=1;
SELECT t1.id1,
(SELECT 0 FROM DUAL
 WHERE t1.id1=t1.id1) AS amount FROM t1
WHERE t1.id2 = 1
HAVING amount > 0
ORDER BY t1.id1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, f3 INT);
INSERT INTO t1 VALUES (2,7,9), (4,7,9), (6,2,9), (17,0,9);
SELECT table1.f1, table2.f2
FROM t1 AS table1
JOIN t1 AS table2 ON table1.f3 = table2.f3
WHERE table2.f1 = 2
GROUP BY table1.f1, table2.f2
HAVING (table2.f2 = 8 AND table1.f1 >= 6);
SELECT table1.f1, table2.f2
FROM t1 AS table1
JOIN t1 AS table2 ON table1.f3 = table2.f3
WHERE table2.f1 = 2
GROUP BY table1.f1, table2.f2
HAVING (table2.f2 = 8 AND table1.f1 >= 6);
SELECT table1.f1, table2.f2
FROM t1 AS table1
JOIN t1 AS table2 ON table1.f3 = table2.f3
WHERE table2.f1 = 2
GROUP BY table1.f1, table2.f2
HAVING (table2.f2 = 8);
DROP TABLE t1;
CREATE TABLE t1(f1 INT, f2 INT);
INSERT INTO t1 VALUES (10,8);
CREATE TABLE t2 (f1 INT);
INSERT INTO t2 VALUES (5);
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 INT, f2 VARCHAR(1));
INSERT INTO t1 VALUES (16,'f');
INSERT INTO t1 VALUES (16,'f');
CREATE TABLE t2 (f1 INT, f2 VARCHAR(1));
INSERT INTO t2 VALUES (13,'f');
INSERT INTO t2 VALUES (20,'f');
CREATE TABLE t3 (f1 INT, f2 VARCHAR(1));
INSERT INTO t3 VALUES (7,'f');
DROP TABLES t1,t2,t3;
CREATE TABLE t1 (f1 INT, f2 VARCHAR(1));
INSERT INTO t1 VALUES (16,'d');
CREATE TABLE t2 (f1 INT, f2 VARCHAR(1));
INSERT INTO t2 VALUES (13,'e');
INSERT INTO t2 VALUES (20,'d');
SELECT MAX(t2.f2) FROM t2 JOIN t1 ON t1.f2
HAVING ('e' , 'd') IN
(SELECT ts1.f2, ts2.f2 FROM t2 ts1 JOIN t2 ts2 ON ts1.f1)
ORDER BY t1.f2;
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 INT(11), f2 VARCHAR(1), PRIMARY KEY (f1));
INSERT INTO t1 VALUES (1,'f');
CREATE TABLE t2 (f1 INT(11), f2 VARCHAR(1));
INSERT INTO t2 VALUES (2,'m');
INSERT INTO t2 VALUES (3,'m');
INSERT INTO t2 VALUES (11,NULL);
INSERT INTO t2 VALUES (12,'k');
SELECT MAX(t1.f1) field1
FROM t1 JOIN t2 ON t2.f2 LIKE 'x'
HAVING field1 < 7;
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 INT, f2 INT);
INSERT INTO t1 VALUES (1, 0), (2, 1), (3, 2);
CREATE TABLE t2 (f1 INT, f2 INT);
SELECT t1.f1
FROM t1
HAVING (3, 2) IN (SELECT f1, f2 FROM t2) AND t1.f1  >= 0
ORDER BY t1.f1;
SELECT t1.f1
FROM t1
HAVING (3, 2) IN (SELECT 4, 2) AND t1.f1  >= 0
ORDER BY t1.f1;
SELECT t1.f1
FROM t1
HAVING 2 IN (SELECT f2 FROM t2) AND t1.f1  >= 0
ORDER BY t1.f1;
DROP TABLE t1,t2;
CREATE TABLE t2 (
  f1 INT,
  PRIMARY KEY (f1)
);
INSERT INTO t2 VALUES (1), (2);
CREATE TABLE t1 (
  f1 INT,
  f2 VARCHAR(1),
  f3 VARCHAR(1),
  PRIMARY KEY (f1),
  KEY (f2, f1)
);
INSERT INTO t1 VALUES (8, 'g', 'g'), (11, 'a', 'a');
SELECT t1.f1 FROM t1 JOIN t2 ON t2.f1 = t1.f1
WHERE t1.f3 AND t1.f2 IN ('f')
HAVING (1 ,6) IN (SELECT 3, 6)
ORDER BY t1.f1;
DROP TABLE t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, i4 INT);
INSERT INTO t1 VALUES (2,7), (4,7), (6,2), (17,0);
SELECT MIN(table1.i4), MIN(table2.pk) as min_pk
FROM t1 as table1, t1 as table2
WHERE table1.pk = 1;
SELECT MIN(table1.i4), MIN(table2.pk) as min_pk
FROM t1 as table1, t1 as table2
WHERE table1.pk = 1
HAVING min_pk <= 10;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
insert into t1 values(1,10),(2,20),(3,30);
select a from t1 having a=3;
select a as x from t1 having x=3;
select avg(a) as x from t1 having x=2;
select a as foo, sum(b) as bar from t1 group by a having foo<10;
select a as foo, sum(b) as bar from t1
 group by a
 having bar>10
 order by foo+10;
select a as foo,
  (select t1_inner.b from t1 as t1_inner where
   t1_inner.a=t1_outer.a+1)
 as bar from t1 as t1_outer
 group by a
 having bar<30
 order by bar+5;
select a as foo,
  (select t1_inner.b from t1 as t1_inner where
   t1_inner.a=t1_outer.a+1)
 as bar from t1 as t1_outer
 group by foo
 having bar<30
 order by bar+5;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
SELECT a FROM (SELECT 1 FROM t1 AS From1) AS From2 
  NATURAL RIGHT OUTER JOIN t1 AS Outjoin3 
GROUP BY 1 HAVING (
  SELECT 1 FROM t1 AS Grouphaving4 GROUP BY 1 HAVING a);
SELECT a FROM (SELECT 1 FROM t1 AS From1) AS From2
  NATURAL RIGHT OUTER JOIN t1 AS Outjoin3
GROUP BY 1 HAVING
  sin((SELECT 1 FROM t1 AS Grouphaving4 GROUP BY 1 HAVING a));
CREATE TABLE t2 (a INT) ENGINE=INNODB;
SELECT Outjoin3.a FROM (SELECT 1 FROM t1 AS From1) AS From2 
NATURAL RIGHT OUTER JOIN t2 AS Outjoin3 
GROUP BY 1 HAVING (
SELECT 1 FROM t1 AS GroupHaving4 GROUP BY 1 HAVING a);
DROP TABLE t1, t2;
CREATE TABLE series (
  val INT(10) UNSIGNED NOT NULL
);
INSERT INTO series VALUES(1);
CREATE TABLE seq_calls (
  c INT
);
INSERT INTO seq_calls VALUES(0);
UPDATE series SET val=mod(val + 1, 2);
UPDATE seq_calls SET c=c+1;
CREATE TABLE t1 (t INT, u INT, KEY(t));
INSERT INTO t1 VALUES(10, 10), (11, 11), (12, 12), (12, 13),(14, 15), (15, 16),
                     (16, 17), (17, 18);
SELECT * FROM series, seq_calls;
SELECT * FROM series, seq_calls;
UPDATE series set val=0;
SELECT * FROM series, seq_calls;
UPDATE series set val=0;
SELECT * FROM series, seq_calls;
UPDATE series set val=1;
INSERT INTO t1 SELECT * FROM t1;
ALTER TABLE t1 ADD KEY(t, u);
SELECT * FROM series, seq_calls;
UPDATE series set val=0;
DROP TABLE t1;
DROP TABLE series, seq_calls;
CREATE TABLE t1 (t TEXT NOT NULL, u TEXT);
INSERT INTO t1 VALUES('2', '1'), ('3', '1'), ('4', '1');
SELECT * FROM t1 WHERE (t, u) in (SELECT a.t,  COUNT(DISTINCT a.u)
                                                       FROM t1 a, t1 b
                                                       GROUP BY a.t);
SELECT * FROM t1 WHERE (t, u) not in (SELECT a.t,  COUNT(DISTINCT a.u)
                                                       FROM t1 a, t1 b
                                                       GROUP BY a.t);
DROP TABLE t1;
CREATE TABLE t1 (col_varchar_key varchar(1) DEFAULT NULL,
                                 KEY col_varchar_key (col_varchar_key));
INSERT INTO t1 VALUES ('a'), ('b'), ('c'), ('h'), ('i'), ('i'), ('j');
SELECT SQL_BUFFER_RESULT col_varchar_key AS field1
  FROM t1 AS table1
  GROUP BY field1
  HAVING field1 = 'a';
DROP TABLE t1;
CREATE TABLE a(f INTEGER, g INTEGER) engine=innodb;
DROP TABLE a;
CREATE TABLE t1(c1 INT) ENGINE=INNODB;
CREATE TABLE t2(c2 INT) ENGINE=INNODB;
SELECT c1 FROM t1 WHERE EXISTS(SELECT * FROM t2 HAVING c2>0);
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(2);
SELECT c1 FROM t1 WHERE EXISTS(SELECT * FROM t2 HAVING c2>0);
DROP TABLE t1, t2;
CREATE TABLE CC (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_key varchar(1) NOT NULL,
  col_varchar varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
);
INSERT INTO CC VALUES
 (10,'v','v'),(18,'a','a'),(19,'v','v'),(20,'u','u'),(21,'s','s'),(22,'y','y'),
 (23,'z','z'),(28,'y','y');
SELECT MAX(col_varchar_key) AS field1 FROM CC AS alias1
 HAVING field1 <> 5;
DROP TABLE CC;
CREATE TABLE t (id INT PRIMARY KEY, value INT);
INSERT INTO t VALUES (1, 99), (2,98), (3, 97);
CREATE TABLE o(c INTEGER);
INSERT INTO o(c) VALUES(1), (2);
SELECT t1.id, (SELECT t2.value FROM t t2 WHERE t1.id = t2.id) AS sub_value
FROM t t1
HAVING sub_value = 99
ORDER BY value
LIMIT 1;
SELECT (SELECT (SELECT t2.value+o.c FROM t t2 WHERE t1.id = t2.id) AS sub_value
        FROM t t1
        HAVING sub_value = 99
        ORDER BY value
        LIMIT 1) AS sub_value
FROM o;
DROP TABLE t, o;
CREATE TABLE t(a INTEGER);
INSERT INTO t VALUES(1),(2);
CREATE VIEW v AS SELECT a FROM t HAVING 0<>1;
DROP VIEW v;
DROP TABLE t;
SELECT 1 HAVING COUNT(*) = 1;
SELECT 1 WHERE TRUE HAVING COUNT(*) = 1;
SELECT 1 WHERE FALSE HAVING COUNT(*) = 0;
SELECT 1 HAVING json_objectagg(utc_date(), 1416) <> 0;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1), (2);
SELECT DISTINCT
  COUNT(DISTINCT t1.a) AS da
FROM
  t1
  JOIN t1 AS t2 ON t1.a = t2.a
GROUP BY t1.a
HAVING COUNT(DISTINCT t1.a) = 1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT, f2 TEXT, f3 INT, PRIMARY KEY(f1));
CREATE TABLE t2 LIKE t1;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (f1 INTEGER);
SELECT SUM(t1.f1)+1 AS field1
FROM t1 JOIN t1 AS t2
GROUP BY t1.f1
HAVING field1 < 7
ORDER BY field1;
DROP TABLE t1;
CREATE TABLE t0 (c42 INT);
DROP TABLE t0;
