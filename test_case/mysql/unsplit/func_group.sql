drop table if exists t1,t2;
create table t1 (grp int, a bigint unsigned, c char(10) not null);
insert into t1 values (1,1,"a");
insert into t1 values (2,2,"b");
insert into t1 values (2,3,"c");
insert into t1 values (3,4,"E");
insert into t1 values (3,5,"C");
insert into t1 values (3,6,"D");
select sum(a) from t1 where a > 10;
select a from t1 order by rand(10);
select count(distinct a),count(distinct grp) from t1;
insert into t1 values (null,null,'');
select sum(all a),count(all a),avg(all a),std(all a),variance(all a),bit_or(all a),bit_and(all a),min(all a),max(all a),min(all c),max(all c) from t1;
select grp, sum(a)+count(a)+avg(a)+std(a)+variance(a)+bit_or(a)+bit_and(a)+min(a)+max(a)+min(c)+max(c) as sum from t1 group by grp;
create table t2 (grp int, a bigint unsigned, c char(10));
insert into t2 select grp,max(a)+max(grp),max(c) from t1 group by grp;
select * from t2;
drop table t1,t2;
CREATE TABLE t1 (id int(11),value1 float(10,2));
INSERT INTO t1 VALUES (1,0.00),(1,1.00), (1,2.00), (2,10.00), (2,11.00), (2,12.00);
CREATE TABLE t2 (id int(11),name char(20));
INSERT INTO t2 VALUES (1,'Set One'),(2,'Set Two');
select id, avg(value1), std(value1), variance(value1) from t1 group by id;
drop table t1,t2;
create table t1 (id int not null);
create table t2 (id int not null,rating int null);
insert into t1 values(1),(2),(3);
insert into t2 values(1, 3),(2, NULL),(2, NULL),(3, 2),(3, NULL);
select t1.id, avg(rating) from t1 left join t2 on ( t1.id = t2.id ) group by t1.id;
drop table t1,t2;
create table t1 (a smallint(6) primary key, c char(10), b text);
INSERT INTO t1 VALUES (1,'1','1');
INSERT INTO t1 VALUES (2,'2','2');
INSERT INTO t1 VALUES (4,'4','4');
drop table t1;
CREATE TABLE t1 (d DATETIME, i INT);
INSERT INTO t1 VALUES (NOW(), 1);
SELECT COUNT(i), i, COUNT(i)*i FROM t1 GROUP BY i;
DROP TABLE t1;
create table t1 (
        num float(5,2),
        user char(20)
);
insert into t1 values (10.3,'nem'),(20.53,'monty'),(30.23,'sinisa');
insert into t1 values (30.13,'nem'),(20.98,'monty'),(10.45,'sinisa');
insert into t1 values (5.2,'nem'),(8.64,'monty'),(11.12,'sinisa');
drop table t1;
create table t1 (a1 int, a2 char(3), key k1(a1), key k2(a2));
insert into t1 values(10,'aaa'), (10,null), (10,'bbb'), (20,'zzz');
create table t2(a1 char(3), a2 int, a3 real, key k1(a1), key k2(a2, a1));
select * from t1;
select min(a2) from t1;
select max(t1.a1), max(t2.a2) from t1, t2;
insert into t2 values('AAA', 10, 0.5);
insert into t2 values('BBB', 20, 1.0);
select t1.a1, t1.a2, t2.a1, t2.a2 from t1,t2;
select t1.a1, t1.a2, t2.a1, t2.a2 from t1 left outer join t2 on t1.a1=10;
drop table t1,t2;
CREATE TABLE t1 (a int, b int);
select count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1;
insert into t1 values (1,null);
insert into t1 values (1,null);
insert into t1 values (2,null);
insert into t1 values (2,1);
insert into t1 values (3,1);
select SQL_BIG_RESULT a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b), bit_xor(b) from t1 group by a;
drop table t1;
create table t1 (col int);
insert into t1 values (-1), (-2), (-3);
select bit_and(col), bit_or(col) from t1;
drop table t1;
create table t1 (a int);
drop table t1;
create table t1(
  a1 char(3) primary key,
  a2 smallint,
  a3 char(3),
  a4 real,
  a5 date,
  key k1(a2,a3),
  key k2(a4,a1),
  key k3(a5,a1)
);
create table t2(
  a1 char(3) primary key,
  a2 char(17),
  a3 char(2),
  a4 char(3),
  key k1(a3, a2),
  key k2(a4)
);
insert into t1 values('AME',0,'SEA',0.100,date'1942-02-19');
insert into t1 values('HBR',1,'SEA',0.085,date'1948-03-05');
insert into t1 values('BOT',2,'SEA',0.085,date'1951-11-29');
insert into t1 values('BMC',3,'SEA',0.085,date'1958-09-08');
insert into t1 values('TWU',0,'LAX',0.080,date'1969-10-05');
insert into t1 values('BDL',0,'DEN',0.080,date'1960-11-27');
insert into t1 values('DTX',1,'NYC',0.080,date'1961-05-04');
insert into t1 values('PLS',1,'WDC',0.075,date'1949-01-02');
insert into t1 values('ZAJ',2,'CHI',0.075,date'1960-06-15');
insert into t1 values('VVV',2,'MIN',0.075,date'1959-06-28');
insert into t1 values('GTM',3,'DAL',0.070,date'1977-09-23');
insert into t1 values('SSJ',null,'CHI',null,date'1974-03-19');
insert into t1 values('KKK',3,'ATL',null,null);
insert into t1 values('XXX',null,'MIN',null,null);
insert into t1 values('WWW',1,'LED',null,null);
insert into t2 values('TKF','Seattle','WA','AME');
insert into t2 values('LCC','Los Angeles','CA','TWU');
insert into t2 values('DEN','Denver','CO','BDL');
insert into t2 values('SDC','San Diego','CA','TWU');
insert into t2 values('NOL','New Orleans','LA','GTM');
insert into t2 values('LAK','Los Angeles','CA','TWU');
insert into t2 values('AAA','AAA','AA','AME');
select * from t1;
select * from t2;
select min(a5), max(a5) from t1;
select (min(a4)+max(a4))/2 from t1;
select (min(a4)+max(a4))/2 from t1;
select concat(min(t1.a1),min(t2.a4)) from t1, t2 where t2.a4 <> 'AME';
drop table t1, t2;
create table t1 (a char(10));
insert into t1 values ('a'),('b'),('c');
select coercibility(max(a)) from t1;
drop table t1;
create table t1 (a char character set latin2);
insert into t1 values ('a'),('b');
select charset(max(a)), coercibility(max(a)),
       charset(min(a)), coercibility(min(a)) from t1;
create table t2 select max(a),min(a) from t1;
drop table t2;
create table t2 select concat(a) from t1;
drop table t2,t1;
create table t1 (a int);
insert into t1 values (1);
select max(a) as b from t1 having b=1;
select a from t1 having a=1;
drop table t1;
create table t1 (a int);
select variance(2) from t1;
select stddev(2) from t1;
drop table t1;
create table t1 (a int);
insert into t1 values (1),(2);
prepare stmt1 from 'SELECT COUNT(*) FROM t1';
deallocate prepare stmt1;
drop table t1;
create table t1 (a int, primary key(a));
insert into t1 values (1),(2);
prepare stmt1 from 'SELECT max(a) FROM t1';
deallocate prepare stmt1;
drop table t1;
CREATE TABLE t1 (a int primary key);
INSERT INTO t1 VALUES (1),(2),(3),(4);
SELECT MAX(a) FROM t1 WHERE a > 5;
SELECT MIN(a) FROM t1 WHERE a < 0;
DROP TABLE t1;
CREATE TABLE t1 (
  id int(10) unsigned NOT NULL auto_increment,
  val enum('one','two','three') NOT NULL default 'one',
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES
(1,'one'),(2,'two'),(3,'three'),(4,'one'),(5,'two');
drop table t1;
CREATE TABLE t1 (
  id int(10) unsigned NOT NULL auto_increment,
  val set('one','two','three') NOT NULL default 'one',
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES
(1,'one'),(2,'two'),(3,'three'),(4,'one'),(5,'two');
drop table t1;
create table t1(a int, b datetime);
insert into t1 values (1, NOW()), (2, NOW());
create table t2 select MAX(b) from t1 group by a;
drop table t1, t2;
create table t1(f1 datetime);
insert into t1 values (now());
create table t2 select f2 from (select max(now()) f2 from t1) a;
drop table t2;
create table t2 select f2 from (select now() f2 from t1) a;
drop table t2, t1;
CREATE TABLE t1(
  id int PRIMARY KEY,
  a  int,
  b  int,
  INDEX i_b_id(a,b,id),
  INDEX i_id(a,id)
);
INSERT INTO t1 VALUES 
  (1,1,4), (2,2,1), (3,1,3), (4,2,1), (5,1,1);
DROP TABLE t1;
CREATE TABLE t1(
  id int PRIMARY KEY,
  a  int,
  b  int,
  INDEX i_id(a,id),
  INDEX i_b_id(a,b,id)
);
INSERT INTO t1 VALUES 
  (1,1,4), (2,2,1), (3,1,3), (4,2,1), (5,1,1);
DROP TABLE t1;
CREATE TABLE t1 (id int PRIMARY KEY, b char(3), INDEX(b));
INSERT INTO t1 VALUES (1,'xx'), (2,'aa');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (id int PRIMARY KEY, b char(16), INDEX(b(4)));
INSERT INTO t1 VALUES (1, 'xxxxbbbb'), (2, 'xxxxaaaa');
DROP TABLE t1;
CREATE TABLE t1 (id int , b varchar(512), INDEX(b(250))) COLLATE latin1_bin;
INSERT INTO t1 VALUES
  (1,CONCAT(REPEAT('_', 250), "qq")), (1,CONCAT(REPEAT('_', 250), "zz")),
  (1,CONCAT(REPEAT('_', 250), "aa")), (1,CONCAT(REPEAT('_', 250), "ff"));
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(1,2),(2,3);
SELECT (SELECT COUNT(DISTINCT t1.b)) FROM t1 GROUP BY t1.a;
SELECT (SELECT COUNT(DISTINCT 12)) FROM t1 GROUP BY t1.a;
SELECT AVG(2), BIT_AND(2), BIT_OR(2), BIT_XOR(2), COUNT(*), COUNT(12),
       COUNT(DISTINCT 12), MIN(2),MAX(2),STD(2), VARIANCE(2),SUM(2),
       GROUP_CONCAT(2),GROUP_CONCAT(DISTINCT 2);
DROP TABLE t1;
create table t2 (ff double);
insert into t2 values (2.2);
select cast(sum(distinct ff) as decimal(5,2)) from t2;
create table t1 (df decimal(5,1));
insert into t1 values(1.1);
insert into t1 values(2.2);
select 1e8 * sum(distinct df) from t1;
select 1e8 * min(df) from t1;
create table t3 (ifl int);
insert into t3 values(1), (2);
drop table t1, t2, t3;
CREATE TABLE t1 (id int(11),value1 float(10,2));
INSERT INTO t1 VALUES (1,0.00),(1,1.00), (1,2.00), (2,10.00), (2,11.00), (2,12.00), (2,13.00);
select id, stddev_pop(value1), var_pop(value1), stddev_samp(value1), var_samp(value1) from t1 group by id;
DROP TABLE t1;
CREATE TABLE t1 (col1 decimal(16,12));
INSERT INTO t1 VALUES (-5.00000000001),(-5.00000000002),(-5.00000000003),(-5.00000000000),(-5.00000000001),(-5.00000000002);
insert into t1 select * from t1;
select col1,count(col1),sum(col1),avg(col1) from t1 group by col1;
DROP TABLE t1;
create table t1 (col1 decimal(16,12));
insert into t1 values (-5.00000000001);
insert into t1 values (-5.00000000001);
select col1,sum(col1),max(col1),min(col1) from t1 group by col1;
delete from t1;
insert into t1 values (5.00000000001);
insert into t1 values (5.00000000001);
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(400)) charset latin1;
INSERT INTO t1 (a) VALUES ("A"), ("a"), ("a "), ("a   "),
                          ("B"), ("b"), ("b "), ("b   ");
DROP TABLE t1;
CREATE TABLE t1 (a int, b int, c int);
INSERT INTO t1 (a, b, c) VALUES
  (1,1,1), (1,1,2), (1,1,3),
  (1,2,1), (1,2,2), (1,2,3),
  (1,3,1), (1,3,2), (1,3,3),
  (2,1,1), (2,1,2), (2,1,3),
  (2,2,1), (2,2,2), (2,2,3),
  (2,3,1), (2,3,2), (2,3,3),
  (3,1,1), (3,1,2), (3,1,3),
  (3,2,1), (3,2,2), (3,2,3),
  (3,3,1), (3,3,2), (3,3,3);
SELECT b/c as v, a FROM t1 ORDER BY v, a;
SELECT b/c as v, SUM(a) FROM t1 GROUP BY v;
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
INSERT INTO t1 VALUES (1,1), (2,2);
CREATE TABLE t2 (a INT PRIMARY KEY, b INT);
INSERT INTO t2 VALUES (1,1), (3,3);
DROP TABLE t1,t2;
create table t1 select variance(0);
drop table t1;
create table t1 select stddev(0);
drop table t1;
create table bug22555 (i smallint primary key auto_increment, s1 smallint, s2 smallint, e decimal(30,10), o double);
insert into bug22555 (s1, s2, e, o) values (53, 78, 11.4276528, 6.828112), (17, 78, 5.916793, 1.8502951), (18, 76, 2.679231, 9.17975591), (31, 62, 6.07831, 0.1), (19, 41, 5.37463, 15.1), (83, 73, 14.567426, 7.959222), (92, 53, 6.10151, 13.1856852), (7, 12, 13.92272, 3.442007), (92, 35, 11.95358909, 6.01376678), (38, 84, 2.572, 7.904571);
select std(s1/s2) from bug22555 group by i;
drop table bug22555;
create table bug22555 (i smallint, s1 smallint, s2 smallint, o1 double, o2 double, e1 decimal, e2 decimal);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
select i, count(*), std(o1/o2) from bug22555 group by i order by i;
select i, count(*), variance(s1/s2) from bug22555 group by i order by i;
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
select i, count(*), round(std(o1/o2), 16) from bug22555 group by i order by i;
select round(std(s1/s2), 17) from bug22555;
drop table bug22555;
create table bug22555 (s smallint, o double, e decimal);
insert into bug22555 values (1,1,1),(2,2,2),(3,3,3),(6,6,6),(7,7,7);
select var_samp(s), var_pop(s) from bug22555;
drop table bug22555;
create table bug22555 (s smallint, o double, e decimal);
insert into bug22555 values (null,null,null),(null,null,null);
select var_samp(s) as 'null', var_pop(s) as 'null' from bug22555;
select var_samp(o) as 'null', var_pop(o) as 'null' from bug22555;
select var_samp(e) as 'null', var_pop(e) as 'null' from bug22555;
insert into bug22555 values (1,1,1);
select var_samp(s) as 'null', var_pop(s) as '0' from bug22555;
select var_samp(o) as 'null', var_pop(o) as '0' from bug22555;
select var_samp(e) as 'null', var_pop(e) as '0' from bug22555;
insert into bug22555 values (2,2,2);
select var_samp(s) as '0.5', var_pop(s) as '0.25' from bug22555;
select var_samp(o) as '0.5', var_pop(o) as '0.25' from bug22555;
select var_samp(e) as '0.5', var_pop(e) as '0.25' from bug22555;
drop table bug22555;
create table t1 (a decimal(20));
insert into t1 values (12345678901234567890);
drop table t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
INSERT INTO t1 SELECT a, b+8       FROM t1;
INSERT INTO t1 SELECT a, b+16      FROM t1;
INSERT INTO t1 SELECT a, b+32      FROM t1;
INSERT INTO t1 SELECT a, b+64      FROM t1;
INSERT INTO t1 SELECT a, b+128     FROM t1;
INSERT INTO t1 SELECT a, b+256     FROM t1;
INSERT INTO t1 SELECT a, b+512     FROM t1;
INSERT INTO t1 SELECT a, b+1024    FROM t1;
INSERT INTO t1 SELECT a, b+2048    FROM t1;
INSERT INTO t1 SELECT a, b+4096    FROM t1;
INSERT INTO t1 SELECT a, b+8192    FROM t1;
INSERT INTO t1 SELECT a, b+16384   FROM t1;
INSERT INTO t1 SELECT a, b+32768   FROM t1;
SELECT a,COUNT(DISTINCT b) AS cnt FROM t1 GROUP BY a HAVING cnt > 50;
SELECT a,SUM(DISTINCT b) AS sumation FROM t1 GROUP BY a HAVING sumation > 50;
SELECT a,AVG(DISTINCT b) AS average FROM t1 GROUP BY a HAVING average > 50;
DROP TABLE t1;
CREATE TABLE t1 ( a INT, b INT, KEY(a) );
INSERT INTO t1 VALUES (NULL, 1), (NULL, 2);
CREATE TABLE t2( a INT, b INT, c INT, KEY(a, b) );
INSERT INTO t2 ( a, b, c ) VALUES ( 1, NULL, 2 ), ( 1, 3, 4 ), ( 1, 4, 4 );
CREATE TABLE t3 (a INT, b INT, c int, KEY(a, b));
INSERT INTO t3 VALUES (1, NULL, 1), (2, NULL, 2),  (2, NULL, 2),  (3, NULL, 3);
CREATE TABLE t4 (a INT, b INT, c int, KEY(a, b));
INSERT INTO t4 VALUES (1, 1, 1), (2, NULL, 2),  (2, NULL, 2),  (3, 1, 3);
SELECT MIN(b), min(c) FROM t4 where a = 2;
CREATE TABLE t5( a INT, b INT, KEY( a, b) );
INSERT INTO t5 VALUES( 1, 1 ), ( 1, 2 );
DROP TABLE t1, t2, t3, t4, t5;
CREATE TABLE t1 (a INT);
INSERT INTO t1 values (),(),();
DROP TABLE t1;
CREATE TABLE t1 (a int, b date NOT NULL, KEY k1 (a,b));
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
CREATE VIEW v1 AS SELECT a,(a + 1) AS y FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(a DOUBLE);
INSERT INTO t1 VALUES (10), (20);
SELECT AVG(a), CAST(AVG(a) AS DECIMAL) FROM t1;
DROP TABLE t1;
CREATE TABLE derived1 (a bigint(21));
INSERT INTO derived1 VALUES (2);
CREATE TABLE D (
  pk int(11) NOT NULL AUTO_INCREMENT,
  int_nokey int(11) DEFAULT NULL,
  int_key int(11) DEFAULT NULL,
  filler blob,
  PRIMARY KEY (pk),
  KEY int_key (int_key)
);
INSERT INTO D VALUES 
  (39,40,4,repeat('  X', 42)),
  (43,56,4,repeat('  X', 42)),
  (47,12,4,repeat('  X', 42)),
  (71,28,4,repeat('  X', 42)),
  (76,54,4,repeat('  X', 42)),
  (83,45,4,repeat('  X', 42)),
  (105,53,12,NULL);
DROP TABLE derived1;
DROP TABLE D;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1), (1,2), (1,3);
DROP TABLE t1;
CREATE TABLE t1 (
  pk INT NOT NULL,
  i INT,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (1,11),(2,12),(3,13);
DROP TABLE t1;
create table t1 (f1 year, f2 year, f3 date, f4 datetime);
insert into t1 values
  (98,1998,19980101,"1998-01-01 00:00:00"),
  ('00',2000,20000101,"2000-01-01 00:00:01"),
  (02,2002,20020101,"2002-01-01 23:59:59"),
  (60,2060,20600101,"2060-01-01 11:11:11"),
  (70,1970,19700101,"1970-11-11 22:22:22"),
  (NULL,NULL,NULL,NULL);
select a.f1 as a, b.f1 as b, a.f1 > b.f1 as gt,
       a.f1 < b.f1 as lt, a.f1<=>b.f1 as eq
from t1 a, t1 b;
select a.f1 as a, b.f2 as b, a.f1 > b.f2 as gt,
       a.f1 < b.f2 as lt, a.f1<=>b.f2 as eq
from t1 a, t1 b;
select a.f1 as a, b.f3 as b, a.f1 > b.f3 as gt,
       a.f1 < b.f3 as lt, a.f1<=>b.f3 as eq
from t1 a, t1 b;
select a.f1 as a, b.f4 as b, a.f1 > b.f4 as gt,
       a.f1 < b.f4 as lt, a.f1<=>b.f4 as eq
from t1 a, t1 b;
select *, f1 = f2 from t1;
drop table t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2);
SELECT MAX((SELECT 1 FROM t1 ORDER BY @var LIMIT 1)) m FROM t1 t2, t1 
       ORDER BY t1.a;
DROP TABLE t1;
SELECT RELEASE_LOCK('aaaaaaaaaaaaaaaaa');
CREATE TABLE t1 (a BIGINT UNSIGNED);
INSERT INTO t1 VALUES (18446668621106209655);
SELECT MAX(LENGTH(a)), LENGTH(MAX(a)), MIN(a), MAX(a), CONCAT(MIN(a)), CONCAT(MAX(a)) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(f1 YEAR);
INSERT INTO t1 VALUES (0000),(2001);
DROP TABLE t1;
CREATE TABLE t1(a int, KEY(a));
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
CREATE TABLE t1(c1 TIME NOT NULL);
INSERT INTO t1 VALUES('837:59:59');
INSERT INTO t1 VALUES('838:59:59');
DROP TABLE t1;
CREATE TABLE t1(c1 TIME NOT NULL);
INSERT INTO t1 VALUES('-00:00:01');
SELECT MAX(c1),MIN(c1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (col_int_nokey int(11));
INSERT INTO t1 VALUES (7),(8),(NULL);
SELECT AVG(DISTINCT col_int_nokey) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a int, KEY (a));
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
DROP TABLE t1;
CREATE TABLE t1 (
  a BLOB,
  b INT)
engine=innodb;
INSERT INTO t1 VALUES ('a', 0);
SELECT 0 FROM t1
WHERE 0 = (SELECT group_concat(b)
           FROM t1 t GROUP BY t1.a);
DROP TABLE t1;
CREATE TABLE e1(pk INT, col_date DATE);
CREATE TABLE b1(i INT);
CREATE TABLE bb4(col_int_key INT, KEY(col_int_key)) ENGINE=MYISAM;
INSERT INTO bb4 VALUES(4);
UPDATE IGNORE e1 AS outr1, b1 AS outr2 SET outr1.col_date =
JSON_SET(outr1.col_date, CONCAT('$','[',1,']','.','cdate'), '2007-07-12')
WHERE outr1.pk <= ANY ( SELECT DISTINCT innr1.col_int_key AS y FROM bb4
AS innr2 LEFT JOIN bb4 AS innr1 ON (innr2.col_int_key <> innr1.col_int_key)
WHERE innr1.col_int_key= 4);
DROP TABLE e1, b1, bb4;
CREATE TABLE t1(pk INT, KEY(pk)) ENGINE=MYISAM;
DROP TABLE t1;
CREATE TABLE t1 (
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
CREATE TABLE t2 (
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (4,1,2);
CREATE TABLE t3 (
  col_int int(11) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
INSERT INTO t3 VALUES (3,9,1);
CREATE TABLE t4 (
  col_int_key int(11) DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
SELECT (
  SELECT MIN(subquery1_t1.col_int_key)
  FROM t3 AS subquery1_t1
    RIGHT JOIN t1 AS subquery1_t2
      STRAIGHT_JOIN t4 AS subquery1_t3
      ON (subquery1_t3.pk = subquery1_t2.col_int_key)
    ON (subquery1_t3.col_int_key = subquery1_t2.col_int)
  WHERE subquery1_t1.col_int_key >= table1.col_int
    AND subquery1_t3.pk > table1.pk
)
FROM t2 AS table1;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  id BIGINT NOT NULL AUTO_INCREMENT,
  f1 BIGINT,
  PRIMARY KEY(id),
  INDEX ix_fd2 (f1)
);
INSERT INTO t1 VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER,f2 INTEGER);
INSERT INTO t1 VALUES (1,10),(1,20),(2,NULL),(2,NULL),(3,50);
SELECT f1, STD(f2) FROM t1 GROUP BY f1 WITH ROLLUP HAVING STD(f2) IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (
  i8 BIGINT UNIQUE,
  dc DECIMAL(10,4) UNIQUE,
  f8 DOUBLE UNIQUE,
  vc VARCHAR(10) UNIQUE
);
INSERT INTO t1 VALUES(123456, 123456.7890, 123456, '123456');
PREPARE si8 FROM 'SELECT MAX(i8) FROM t1 WHERE i8 > ?';
PREPARE ei8 FROM 'EXPLAIN SELECT MAX(i8) FROM t1 WHERE i8 > ?';
PREPARE sdc FROM 'SELECT MAX(dc) FROM t1 WHERE dc > ?';
PREPARE edc FROM 'EXPLAIN SELECT MAX(dc) FROM t1 WHERE dc > ?';
PREPARE sf8 FROM 'SELECT MAX(f8) FROM t1 WHERE f8 > ?';
PREPARE ef8 FROM 'EXPLAIN SELECT MAX(f8) FROM t1 WHERE f8 > ?';
PREPARE svc FROM 'SELECT MAX(vc) FROM t1 WHERE vc > ?';
PREPARE evc FROM 'EXPLAIN SELECT MAX(vc) FROM t1 WHERE vc > ?';
DROP TABLE t1;
CREATE TABLE tr (c1 INT);
INSERT INTO tr VALUES (1);
UPDATE tr SET c1 = c1 + 1;
UPDATE tr SET c1 = 1;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (10);
INSERT INTO t1 VALUES (11);
DROP TABLE t1, tr;
CREATE TABLE t1(value double);
INSERT INTO t1 VALUES
(9.33174e+07),
(4.5e+95),
(7.31463e+09),
(1.79769e+308),
(-2.59078e+12),
(2.34165e+21),
(-1.79769e+308),
(0.0);
DROP TABLE t1;
CREATE TABLE t2(grp int, value double);
INSERT INTO t2 VALUES
(0, 9.33174e+07),
(1, 4.5e+95),
(0, 7.31463e+09),
(1, 1.79769e+308),
(0, -2.59078e+12),
(1, 2.34165e+21),
(0, -1.79769e+308),
(1, 0.0);
DROP TABLE t2;
