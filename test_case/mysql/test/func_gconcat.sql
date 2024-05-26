select grp,group_concat(c) from t1 group by grp;
select grp, group_concat(a separator "")+0 from t1 group by grp;
select grp, group_concat(a separator "")+0.0 from t1 group by grp;
select grp, ROUND(group_concat(a separator "")) from t1 group by grp;
drop table t1;
create table t1 (grp int, c char(10));
insert into t1 values (1,NULL),(2,"b"),(2,NULL),(3,"E"),(3,NULL),(3,"D"),(3,NULL),(3,NULL),(3,"D"),(4,""),(5,NULL);
drop table t1;
create table t1 ( URL_ID int(11), URL varchar(80));
create table t2 ( REQ_ID int(11), URL_ID int(11));
insert into t1 values (4,'www.host.com'), (5,'www.google.com'),(5,'www.help.com');
insert into t2 values (1,4), (5,4), (5,5);
select REQ_ID, Group_Concat(URL) as URL from t1, t2 where
t2.URL_ID = t1.URL_ID group by REQ_ID;
select REQ_ID, Group_Concat(URL) as URL, Min(t1.URL_ID) urll,
Max(t1.URL_ID) urlg from t1, t2 where t2.URL_ID = t1.URL_ID group by REQ_ID;
drop table t1;
drop table t2;
create table t1 (id int, name varchar(16));
insert into t1 values (1,'longername'),(1,'evenlongername');
select ifnull(group_concat(concat(t1.id, ':', t1.name)), 'shortname') as 'without distinct: how it should be' from t1;
select distinct ifnull(group_concat(concat(t1.id, ':', t1.name)), 'shortname') as 'with distinct: cutoff at length of shortname' from t1;
drop table t1;
create table t1(id int);
create table t2(id int);
insert into t1 values(0),(1);
drop table t1;
drop table t2;
create table t1 (bar varchar(32));
insert into t1 values('test1'),('test2');
drop table t1;
create table t1 (a int, a1 varchar(10));
create table t2 (a0 int);
insert into t1 values (0,"a"),(0,"b"),(1,"c");
insert into t2 values (1),(2),(3);
drop table t1, t2;
CREATE TABLE t1 (id1 tinyint(4) NOT NULL, id2 tinyint(4) NOT NULL);
INSERT INTO t1 VALUES (1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(2, 1),(2, 2),(2, 3);
CREATE TABLE t2 (id1 tinyint(4) NOT NULL);
INSERT INTO t2 VALUES (1),(2),(3),(4),(5);
SELECT t1.id1, GROUP_CONCAT(t1.id2 ORDER BY t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 AND t1.id1=1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2 ORDER BY t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2 ORDER BY t1.id2 DESC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2 ORDER BY 6-t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2,6-t1.id2 ORDER BY 6-t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2,6-t1.id2 ORDER BY 6-t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
SELECT t1.id1, GROUP_CONCAT(t1.id2,"/",6-t1.id2 ORDER BY 1+0,6-t1.id2,t1.id2 ASC) AS concat_id FROM t1, t2 WHERE t1.id1 = t2.id1 GROUP BY t1.id1;
drop table t1,t2;
create table t1 (s1 char(10), s2 int not null);
insert into t1 values ('a',2),('b',2),('c',1),('a',3),('b',4),('c',4);
drop table t1;
create table t1 (a int, c int);
insert into t1 values (1, 2), (2, 3), (2, 4), (3, 5);
create table t2 (a int, c int);
insert into t2 values (1, 5), (2, 4), (3, 3), (3,3);
select group_concat(c order by (select c from t2 where t2.a=t1.a limit 1)) as grp from t1;
select group_concat(c order by (select mid(group_concat(c order by a),1,5) from t2 where t2.a=t1.a)) as grp from t1;
select group_concat(c order by (select mid(group_concat(c order by a),1,5) from t2 where t2.a=t1.a) desc) as grp from t1;
select t1.a, group_concat(c order by (select c from t2 where t2.a=t1.a limit 1)) as grp from t1 group by 1;
select t1.a, group_concat(c order by (select mid(group_concat(c order by a),1,5) from t2 where t2.a=t1.a)) as grp from t1 group by 1;
select t1.a, group_concat(c order by (select mid(group_concat(c order by a),1,5) from t2 where t2.a=t1.a) desc) as grp from t1 group by 1;
select group_concat(c order by (select concat(5-t1.c,group_concat(c order by a)) from t2 where t2.a=t1.a)) as grp from t1;
select group_concat(c order by (select concat(t1.c,group_concat(c)) from t2 where a=t1.a)) as grp from t1;
select a,c,(select group_concat(c order by a) from t2 where a=t1.a) as grp from t1 order by grp;
drop table t1,t2;
CREATE TABLE t1 ( a int );
CREATE TABLE t2 ( a int );
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1), (2);
SELECT GROUP_CONCAT(t1.a*t2.a ORDER BY t2.a) FROM t1, t2 GROUP BY t1.a;
DROP TABLE t1, t2;
CREATE TABLE t1 (a char(4));
INSERT INTO t1 VALUES ('John'), ('Anna'), ('Bill');
SELECT GROUP_CONCAT(a SEPARATOR '||') AS names FROM t1 
  HAVING names LIKE '%An%';
SELECT GROUP_CONCAT(a SEPARATOR '###') AS names FROM t1 
  HAVING LEFT(names, 1) ='J';
DROP TABLE t1;
CREATE TABLE t1 ( a int, b TEXT );
INSERT INTO t1 VALUES (1,'First Row'), (2,'Second Row');
DROP TABLE t1;
CREATE TABLE t1 (A_ID INT NOT NULL,A_DESC CHAR(3) NOT NULL,PRIMARY KEY (A_ID));
INSERT INTO t1 VALUES (1,'ABC'), (2,'EFG'), (3,'HIJ');
CREATE TABLE t2 (A_ID INT NOT NULL,B_DESC CHAR(3) NOT NULL,PRIMARY KEY (A_ID,B_DESC));
INSERT INTO t2 VALUES (1,'A'),(1,'B'),(3,'F');
SELECT t1.A_ID, GROUP_CONCAT(t2.B_DESC) AS B_DESC FROM t1 LEFT JOIN t2 ON t1.A_ID=t2.A_ID GROUP BY t1.A_ID ORDER BY t1.A_DESC;
DROP TABLE t1;
DROP TABLE t2;
create table t1 (a int, b text);
insert into t1 values (1, 'bb'), (1, 'ccc'), (1, 'a'), (1, 'bb'), (1, 'ccc');
insert into t1 values (2, 'BB'), (2, 'CCC'), (2, 'A'), (2, 'BB'), (2, 'CCC');
insert into t1 values (1, concat(repeat('1', 300), '2')), 
(1, concat(repeat('1', 300), '2')), (1, concat(repeat('0', 300), '1')), 
(2, concat(repeat('1', 300), '2')), (2, concat(repeat('1', 300), '2')), 
(2, concat(repeat('0', 300), '1'));
drop table t1;
create table t1 (a varchar(255) character set cp1250 collate cp1250_general_ci,
                 b varchar(255) character set koi8r);
insert into t1 values ('xxx','yyy');
select collation(a) from t1;
create table t2 select group_concat(a) as a from t1;
drop table t1;
drop table t2;
CREATE TABLE t1 (a CHAR(10) CHARACTER SET cp850);
SELECT a FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (id int);
SELECT GROUP_CONCAT(id) AS gc FROM t1 HAVING gc IS NULL;
DROP TABLE t1;
create table t2 (a int, b int);
insert into t2 values (1,1), (2,2);
select  b x, (select group_concat(b) from t2) from  t2;
drop table t2;
create table t1 (d int not null auto_increment,primary key(d), a int, b int, c int);
insert into t1(a,b) values (1,3), (1,4), (1,2), (2,7), (1,1), (1,2), (2,3), (2,3);
select d,a,b from t1 order by a;
drop table t1;
create table t1 (a char(3), b char(20), primary key (a, b));
insert into t1 values ('ABW', 'Dutch'), ('ABW', 'English');
drop table t1;
CREATE TABLE t1 (
  aID smallint(5) unsigned NOT NULL auto_increment,
  sometitle varchar(255) NOT NULL default '',
  bID smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (aID),
  UNIQUE KEY sometitle (sometitle)
);
INSERT INTO t1 SET sometitle = 'title1', bID = 1;
INSERT INTO t1 SET sometitle = 'title2', bID = 1;
CREATE TABLE t2 (
  bID smallint(5) unsigned NOT NULL auto_increment,
  somename varchar(255) NOT NULL default '',
  PRIMARY KEY  (bID),
  UNIQUE KEY somename (somename)
);
INSERT INTO t2 SET somename = 'test';
SELECT COUNT(*), GROUP_CONCAT(DISTINCT t2.somename SEPARATOR ' |')
  FROM t1 JOIN t2 ON t1.bID = t2.bID;
INSERT INTO t2 SET somename = 'test2';
DELETE FROM t2 WHERE somename = 'test2';
DROP TABLE t1,t2;
select * from (select group_concat('c') from DUAL) t;
create table t1 ( a int not null default 0);
select * from (select group_concat(a) from t1) t2;
drop table t1;
CREATE TABLE t1 (id int, a varchar(9));
INSERT INTO t1 VALUES
  (2, ''), (1, ''), (2, 'x'), (1, 'y'), (3, 'z'), (3, '');
DROP TABLE t1;
create table t1(f1 int);
insert into t1 values(1),(2),(3);
select count(distinct (f1+1)) from t1 group by f1 with rollup;
drop table t1;
create table t1 (f1 int unsigned, f2 varchar(255));
insert into t1 values (1,repeat('a',255)),(2,repeat('b',255));
drop table t1;
create table t1 (a char, b char);
insert into t1 values ('a', 'a'), ('a', 'b'), ('b', 'a'), ('b', 'b');
create table t2 select group_concat(b) as a from t1 where a = 'a';
create table t3 (select group_concat(a) as a from t1 where a = 'a') union
                (select group_concat(b) as a from t1 where a = 'b');
select charset(a) from t2;
drop table t1, t2, t3;
create table t1 (c1 varchar(10), c2 int);
drop table t1;
CREATE TABLE t1 (a INT(10), b LONGTEXT, PRIMARY KEY (a));
INSERT INTO t1 VALUES (1,REPEAT(CONCAT('A',CAST(CHAR(0) AS BINARY),'B'), 40000));
INSERT INTO t1 SELECT a + 1, b FROM t1;
SELECT a, CHAR_LENGTH(b) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a int, b int);
INSERT INTO t1 VALUES (2,1), (1,2), (2,2), (1,3);
DROP TABLE t1;
create table t1
(
  x text character set utf8mb3 not null,
  y integer not null
);
insert into t1 values (repeat('a', 1022), 0), (repeat(_utf8mb3 0xc3b7, 4), 0);
select @x:=group_concat(x) from t1 group by y;
select @@group_concat_max_len, length(@x), char_length(@x), right(@x,12), right(HEX(@x),12);
drop table t1;
create table t1 (f1 int unsigned, f2 varchar(255));
insert into t1 values (1,repeat('a',255)),(2,repeat('b',255));
drop table t1;
CREATE TABLE t1(a TEXT, b CHAR(20));
INSERT INTO t1 VALUES ("one.1","one.1"),("two.2","two.2"),("one.3","one.3");
DROP TABLE t1;
CREATE TABLE t1( a VARCHAR( 10 ), b INT );
INSERT INTO t1 VALUES ( repeat( 'a', 10 ), 1), 
                      ( repeat( 'b', 10 ), 2);
DROP TABLE t1;
CREATE TABLE t1( a TEXT, b INTEGER );
INSERT INTO t1 VALUES ( 'a', 0 ), ( 'b', 1 );
CREATE TABLE t2( a TEXT );
INSERT INTO t2 VALUES( REPEAT( 'a', 5000 ) );
INSERT INTO t2 VALUES( REPEAT( 'b', 5000 ) );
INSERT INTO t2 VALUES( REPEAT( 'a', 5000 ) );
SELECT LENGTH( GROUP_CONCAT( DISTINCT a ) ) FROM t2;
CREATE TABLE t3( a TEXT, b INT  );
INSERT INTO t3 VALUES( REPEAT( 'a', 65534 ), 1 );
INSERT INTO t3 VALUES( REPEAT( 'a', 65535 ), 2 );
INSERT IGNORE INTO t3 VALUES( REPEAT( 'a', 65536 ), 3 );
DROP TABLE t1, t2, t3;
create table t1 (id int, name varchar(20)) DEFAULT CHARSET=utf8mb3;
drop table t1;
create table t1(a bit not null);
insert ignore into t1 values (), (), ();
drop table t1;
create table t1(a bit(2) not null);
insert into t1 values (1), (0), (0), (3), (1);
drop table t1;
create table t1(a bit(2), b varchar(10), c bit);
insert into t1 values (1, 'a', 0), (0, 'b', 1), (0, 'c', 0), (3, 'd', 1),
(1, 'e', 1), (3, 'f', 1), (0, 'g', 1);
drop table t1;
create table t1 (f1 char(20));
insert into t1 values (''),('');
drop table t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1, 1), (2, 2), (2, 3);
CREATE TABLE t2 (a INT, b INT, c INT, d INT);
INSERT INTO t2 VALUES (1,1, 1,1), (1,1, 2,2), (1,2, 2,1), (2,1, 1,2);
CREATE TABLE t3 (a INT, b INT, c INT);
INSERT INTO t3 VALUES (1, 1, 1), (2, 1, 2), (3, 2, 1);
DROP TABLE t1, t2, t3;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (),();
SELECT s1.d1 FROM
(
 SELECT
  t1.a as d1,
  GROUP_CONCAT(DISTINCT t1.a) AS d2
 FROM
  t1 AS t1,
  t1 AS t2
 GROUP BY 1
) AS s1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES(1);
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, KEY(a));
CREATE TABLE t2 (b INT);
INSERT INTO t1 VALUES (NULL), (8), (2);
INSERT INTO t2 VALUES (4), (10);
SELECT 1 FROM t1 WHERE t1.a NOT IN
(
  SELECT GROUP_CONCAT(DISTINCT t1.a)
  FROM  t1 WHERE t1.a IN   
  (
    SELECT b FROM t2
  ) 
  AND NOT t1.a >= (SELECT t1.a FROM t1 LIMIT 1)
  GROUP BY t1.a
);
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES (),();
SELECT 1 FROM
 (SELECT DISTINCT GROUP_CONCAT(td.f1) FROM t1,t1 AS td GROUP BY td.f1) AS d,t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (0), (0);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2);
PREPARE stmt FROM "SELECT GROUP_CONCAT(t1.a ORDER BY t1.a) FROM t1 JOIN t1 t2 GROUP BY t1.a WITH ROLLUP";
DEALLOCATE PREPARE stmt;
DROP TABLE t1;
CREATE TABLE t1(f1 int);
INSERT INTO t1 values (0),(0);
DROP TABLE t1;
CREATE TABLE t1(a INT);
DROP TABLE t1;
DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (a VARCHAR(6), b INT);
CREATE TABLE t2 (a VARCHAR(6), b INT);
INSERT INTO t1 VALUES ('111111', 1);
INSERT INTO t1 VALUES ('222222', 2);
INSERT INTO t1 VALUES ('333333', 3);
INSERT INTO t1 VALUES ('444444', 4);
INSERT INTO t1 VALUES ('555555', 5);
INSERT INTO t2 SELECT GROUP_CONCAT(a), b FROM t1 GROUP BY b;
UPDATE t1 SET a = '11111' WHERE b = 1;
UPDATE t1 SET a = '22222' WHERE b = 2;
INSERT INTO t2 SELECT GROUP_CONCAT(a), b FROM t1 GROUP BY b;
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 LONGTEXT , f2  INTEGER);
INSERT INTO t1 VALUES (REPEAT('a', 500000), 0), (REPEAT('b', 500000), 1), (REPEAT('c', 500000), 2);
SELECT SUBSTRING(GROUP_CONCAT(DISTINCT f1 ORDER BY f1 DESC), 1, 5) FROM t1;
INSERT INTO t1 VALUES (REPEAT('a', 499999), 3), (REPEAT('b', 500000), 4);
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(1000), b INT);
INSERT INTO t1 VALUES ('a', 1), ('b', 2), ('a', 3), ('b', 5), ('c', 5);
DROP TABLE t1;
CREATE TABLE t1 (c VARCHAR(40) NULL DEFAULT NULL) CHARACTER SET utf8mb4;
CREATE TABLE t2 AS SELECT GROUP_CONCAT(t.c) as c FROM t1 t;
CREATE TABLE t3 AS SELECT GROUP_CONCAT(t.c) as c
FROM t1 t
UNION
SELECT '' as c;
INSERT INTO t1 VALUES ('abcdefghijk'), ('pqrstuvwxyz'), ('124567890'), ('010011000111');
INSERT INTO t1 VALUES ('abcdefghijk'), ('pqrstuvwxyz'), ('124567890'), ('010011000111');
SELECT GROUP_CONCAT(t.c) as c
FROM t1 t;
SELECT GROUP_CONCAT(t.c) as c
FROM t1 t
UNION
SELECT '' as c;
DROP TABLE t1, t2, t3;
CREATE TABLE t2 (grp INT, a CHAR(2));
INSERT INTO t2 VALUES (1,"a"), (2,"2"), (2,"4"), (3,"c");
SELECT grp, GROUP_concat(a SEPARATOR "") + 1.0  FROM t2 GROUP BY grp;
DROP TABLE t2;
prepare s from 'DO GROUP_CONCAT((SELECT COUNT(1)) ORDER BY 1)';
deallocate prepare s;
CREATE TABLE t1 (name VARCHAR(100), square GEOMETRY);
INSERT INTO t1 VALUES
  ("center", ST_GeomFromText('POLYGON (( 0 0, 0 2, 2 2, 2 0, 0 0))')),
  ("small",  ST_GeomFromText('POLYGON (( 0 0, 0 1, 1 1, 1 0, 0 0))')),
  ("big",    ST_GeomFromText('POLYGON (( 0 0, 0 3, 3 3, 3 0, 0 0))')),
  ("up",     ST_GeomFromText('POLYGON (( 0 1, 0 3, 2 3, 2 1, 0 1))')),
  ("up2",    ST_GeomFromText('POLYGON (( 0 2, 0 4, 2 4, 2 2, 0 2))')),
  ("up3",    ST_GeomFromText('POLYGON (( 0 3, 0 5, 2 5, 2 3, 0 3))')),
  ("down",   ST_GeomFromText('POLYGON (( 0 -1, 0  1, 2  1, 2 -1, 0 -1))')),
  ("down2",  ST_GeomFromText('POLYGON (( 0 -2, 0  0, 2  0, 2 -2, 0 -2))')),
  ("down3",  ST_GeomFromText('POLYGON (( 0 -3, 0 -1, 2 -1, 2 -3, 0 -3))')),
  ("right",  ST_GeomFromText('POLYGON (( 1 0, 1 2, 3 2, 3 0, 1 0))')),
  ("right2", ST_GeomFromText('POLYGON (( 2 0, 2 2, 4 2, 4 0, 2 0))')),
  ("right3", ST_GeomFromText('POLYGON (( 3 0, 3 2, 5 2, 5 0, 3 0))')),
  ("left",   ST_GeomFromText('POLYGON (( -1 0, -1 2,  1 2,  1 0, -1 0))')),
  ("left2",  ST_GeomFromText('POLYGON (( -2 0, -2 2,  0 2,  0 0, -2 0))')),
  ("left3",  ST_GeomFromText('POLYGON (( -3 0, -3 2, -1 2, -1 0, -3 0))'));
CREATE VIEW v AS SELECT * FROM t1;
prepare s from '
SELECT GROUP_CONCAT(a2.name ORDER BY a2.name) AS mbrcontains
FROM v a1 JOIN v a2 ON MBRContains(a1.square, a2.square)
WHERE a1.name = "center"
GROUP BY a1.name';
deallocate prepare s;
DROP VIEW v;
DROP TABLE t1;
CREATE TABLE t1 (
  o_id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  PRIMARY KEY (o_id)
);
DROP TABLE t1;
CREATE VIEW v(c0) AS SELECT group_concat((SELECT 1), 1);
DROP VIEW v;
CREATE TABLE customer (
  c_id int NOT NULL,
  c_name varchar(255) NOT NULL,
  PRIMARY KEY (c_id)
);
INSERT INTO customer VALUES (1,'Messi'),(2,'Pele'),(3,'Maradona');
CREATE TABLE employee (
  seq_id bigint NOT NULL,
  c_id int NOT NULL,
  emp_id int NOT NULL,
  emp_name varchar(30) DEFAULT NULL,
  PRIMARY KEY (seq_id)
);
INSERT INTO employee VALUES (1,1,10,'Zico'),(2,3,30,'Ronaldo');
SELECT mc.c_id,
       GROUP_CONCAT(e.emp_name order by e.emp_id separator ',') AS gc
FROM customer AS mc LEFT JOIN employee AS e
     ON mc.c_id = e.c_id AND e.seq_id = 2
WHERE mc.c_id = 2
GROUP BY mc.c_id;
PREPARE ps FROM
"SELECT mc.c_id,
       GROUP_CONCAT(e.emp_name order by e.emp_id separator ',') AS gc
FROM customer AS mc LEFT JOIN employee AS e
     ON mc.c_id = e.c_id AND e.seq_id = ?
WHERE mc.c_id = ?
GROUP BY mc.c_id";
DROP TABLE customer, employee;
