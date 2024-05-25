drop table if exists t1,t2,t3;
CREATE TABLE t1 (
  spID int(10) unsigned,
  userID int(10) unsigned,
  score smallint(5) unsigned,
  lsg char(40),
  date date
);
CREATE TABLE t2 (
  userID int(10) unsigned NOT NULL auto_increment,
  niName char(15),
  passwd char(8),
  mail char(50),
  isAukt enum('N','Y') DEFAULT 'N',
  vName char(30),
  nName char(40),
  adr char(60),
  plz char(5),
  ort char(35),
  land char(20),
  PRIMARY KEY (userID)
);
INSERT INTO t2 VALUES (1,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (2,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (3,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (4,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (5,'name','pass','mail','Y','v','n','adr','1','1','1');
SELECT t2.userid, MIN(t1.score) FROM t1, t2 WHERE t1.userID=t2.userID GROUP BY t2.userid;
SELECT t2.userid, MIN(t1.score) FROM t1, t2 WHERE t1.userID=t2.userID GROUP BY t2.userid ORDER BY NULL;
SELECT t2.userid, MIN(t1.score) FROM t1, t2 WHERE t1.userID=t2.userID AND t1.spID=2  GROUP BY t2.userid;
SELECT t2.userid, MIN(t1.score+0.0) FROM t1, t2 WHERE t1.userID=t2.userID AND t1.spID=2  GROUP BY t2.userid;
SELECT t2.userid, MIN(t1.score+0.0) FROM t1, t2 WHERE t1.userID=t2.userID AND t1.spID=2  GROUP BY t2.userid ORDER BY NULL;
drop table t1,t2;
CREATE TABLE t1 (
  cid mediumint(9) NOT NULL auto_increment,
  firstname varchar(32) DEFAULT '' NOT NULL,
  surname varchar(32) DEFAULT '' NOT NULL,
  PRIMARY KEY (cid)
);
INSERT INTO t1 VALUES (1,'That','Guy');
INSERT INTO t1 VALUES (2,'Another','Gent');
CREATE TABLE t2 (
  call_id mediumint(8) NOT NULL auto_increment,
  contact_id mediumint(8) DEFAULT '0' NOT NULL,
  PRIMARY KEY (call_id),
  KEY contact_id (contact_id)
);
lock tables t1 read,t2 write;
INSERT INTO t2 VALUES (10,2);
INSERT INTO t2 VALUES (18,2);
INSERT INTO t2 VALUES (62,2);
INSERT INTO t2 VALUES (91,2);
INSERT INTO t2 VALUES (92,2);
SELECT cid, CONCAT(firstname, ' ', surname), COUNT(call_id) FROM t1 LEFT JOIN t2 ON cid=contact_id WHERE firstname like '%foo%' GROUP BY cid;
SELECT cid, CONCAT(firstname, ' ', surname), COUNT(call_id) FROM t1 LEFT JOIN t2 ON cid=contact_id WHERE firstname like '%foo%' GROUP BY cid ORDER BY NULL;
SELECT HIGH_PRIORITY cid, CONCAT(firstname, ' ', surname), COUNT(call_id) FROM t1 LEFT JOIN t2 ON cid=contact_id WHERE firstname like '%foo%' GROUP BY cid ORDER BY surname, firstname;
drop table t2;
unlock tables;
drop table t1;
CREATE TABLE t2 (
  value tinytext,
  program varchar(64),
  initialowner tinytext NOT NULL,
  initialqacontact tinytext NOT NULL,
  description mediumtext NOT NULL
);
INSERT INTO t2 VALUES ('TestComponent','TestProduct','id0001','','');
INSERT INTO t2 VALUES ('BBBBBBBBBBBBB - conversion','AAAAA','id0001','','');
INSERT INTO t2 VALUES ('BBBBBBBBBBBBB - generic','AAAAA','id0001','','');
INSERT INTO t2 VALUES ('TestComponent2','TestProduct','id0001','','');
INSERT INTO t2 VALUES ('BBBBBBBBBBBBB - eeeeeeeee','AAAAA','id0001','','');
INSERT INTO t2 VALUES ('kkkkkkkkkkk lllllllllll','AAAAA','id0001','','');
INSERT INTO t2 VALUES ('Test Procedures','AAAAA','id0001','','');
INSERT INTO t2 VALUES ('Documentation','AAAAA','id0003','','');
INSERT INTO t2 VALUES ('DDDDDDDDD','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Eeeeeeee Lite','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Eeeeeeee Full','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Administration','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Distribution','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Setup','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Unspecified','CCC/CCCCCC','id0002','','');
INSERT INTO t2 VALUES ('Web Interface','AAAAAAAA-AAA','id0001','','');
INSERT INTO t2 VALUES ('Host communication','AAAAA','id0001','','');
create table t1 (foo int);
insert into t1 values (1);
select 1+1, "a",count(*) from t1 where foo in (2);
insert into t1 values (1);
select 1+1,"a",count(*) from t1 where foo in (2);
drop table t1;
CREATE TABLE t1 (
  spID int(10) unsigned,
  userID int(10) unsigned,
  score smallint(5) unsigned,
  key (spid),
  key (score)
);
INSERT INTO t1 VALUES (1,1,1),(2,2,2),(2,1,1),(3,3,3),(4,3,3),(5,3,3),(6,3,3),(7,3,3);
select userid,count(*) from t1 group by userid order by userid desc;
select userid,count(*) from t1 group by userid having (count(*)+1) IN (4,3) order by userid desc;
select userid,count(*) from t1 group by userid having 3  IN (1,COUNT(*)) order by userid desc;
select spid,count(*) from t1 where spid between 1 and 2 group by spid;
select spid,count(*) from t1 where spid between 1 and 2 group by spid order by spid desc;
select sql_big_result spid,sum(userid) from t1 group by spid order by spid desc;
select sql_big_result score,count(*) from t1 group by score order by score desc;
drop table t1;
create table t1 (a date default null, b date default null);
insert t1 values ('1999-10-01','2000-01-10'), ('1997-01-01','1998-10-01');
drop table t1;
CREATE TABLE t1 (a char(1));
INSERT INTO t1 VALUES ('A'),('B'),('A'),('B'),('A'),('B'),(NULL),('a'),('b'),(NULL),('A'),('B'),(NULL);
SELECT a FROM t1 GROUP BY a;
SELECT a,count(*) FROM t1 GROUP BY a;
SELECT binary a FROM t1 GROUP BY 1;
SELECT binary a,count(*) FROM t1 GROUP BY 1;
SELECT a FROM t1 GROUP BY a ORDER BY a;
SELECT a,count(*) FROM t1 GROUP BY a ORDER BY a;
SELECT binary a FROM t1 GROUP BY 1 ORDER BY 1;
SELECT binary a,count(*) FROM t1 GROUP BY 1 ORDER BY 1;
drop table t1;
CREATE TABLE t1 (
  `a` char(193) default NULL,
  `b` char(63) default NULL
);
INSERT INTO t1 VALUES ('abc','def'),('hij','klm');
SELECT CONCAT(a, b) FROM t1 GROUP BY 1;
SELECT CONCAT(a, b),count(*) FROM t1 GROUP BY 1;
SELECT CONCAT(a, b),count(distinct a) FROM t1 GROUP BY 1;
SELECT 1 FROM t1 GROUP BY CONCAT(a, b);
INSERT INTO t1 values ('hij','klm');
SELECT CONCAT(a, b),count(*) FROM t1 GROUP BY 1;
DROP TABLE t1;
create table t1 (One int unsigned, Two int unsigned, Three int unsigned, Four int unsigned);
insert into t1 values (1,2,1,4),(1,2,2,4),(1,2,3,4),(1,2,4,4),(1,1,1,4),(1,1,2,4),(1,1,3,4),(1,1,4,4),(1,3,1,4),(1,3,2,4),(1,3,3,4),(1,3,4,4);
select One, Two, sum(Four) from t1 group by One,Two;
drop table t1;
create table t1 (id integer primary key not null auto_increment, gender char(1));
insert into t1 values (NULL, 'M'), (NULL, 'F'),(NULL, 'F'),(NULL, 'F'),(NULL, 'M');
drop table t1,t2;
CREATE TABLE t1 (ID1 int, ID2 int, ID int NOT NULL AUTO_INCREMENT,PRIMARY KEY(ID
));
insert into t1 values (1,244,NULL),(2,243,NULL),(134,223,NULL),(185,186,NULL);
select S.ID as xID, S.ID1 as xID1 from t1 as S left join t1 as yS  on S.ID1 between yS.ID1 and yS.ID2;
select S.ID as xID, S.ID1 as xID1, repeat('*',count(distinct yS.ID)) as Level from t1 as S left join t1 as yS  on S.ID1 between yS.ID1 and yS.ID2 group by xID order by xID1;
drop table t1;
CREATE TABLE t1 (
  pid int(11) unsigned NOT NULL default '0',
  c1id int(11) unsigned default NULL,
  c2id int(11) unsigned default NULL,
  value int(11) unsigned NOT NULL default '0',
  UNIQUE KEY pid2 (pid,c1id,c2id),
  UNIQUE KEY pid (pid,value)
) ENGINE=INNODB;
INSERT INTO t1 VALUES (1, 1, NULL, 1),(1, 2, NULL, 2),(1, NULL, 3, 3),(1, 4, NULL, 4),(1, 5, NULL, 5);
CREATE TABLE t2 (
  id int(11) unsigned NOT NULL default '0',
  active enum('Yes','No') NOT NULL default 'Yes',
  PRIMARY KEY  (id)
) ENGINE=INNODB;
INSERT INTO t2 VALUES (1, 'Yes'),(2, 'No'),(4, 'Yes'),(5, 'No');
CREATE TABLE t3 (
  id int(11) unsigned NOT NULL default '0',
  active enum('Yes','No') NOT NULL default 'Yes',
  PRIMARY KEY  (id)
);
INSERT INTO t3 VALUES (3, 'Yes');
select * from t1 AS m LEFT JOIN t2 AS c1 ON m.c1id = 
c1.id AND c1.active = 'Yes' LEFT JOIN t3 AS c2 ON m.c2id = c2.id AND 
c2.active = 'Yes' WHERE m.pid=1  AND (c1.id IS NOT NULL OR c2.id IS NOT NULL);
select max(value) from t1 AS m LEFT JOIN t2 AS c1 ON 
m.c1id = c1.id AND c1.active = 'Yes' LEFT JOIN t3 AS c2 ON m.c2id = 
c2.id AND c2.active = 'Yes' WHERE m.pid=1  AND (c1.id IS NOT NULL OR c2.id IS 
NOT NULL);
drop table t1,t2,t3;
create table t1 (a blob null);
insert into t1 values (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(""),(""),(""),("b");
select a,count(*) from t1 group by a;
select a,count(*) from t1 group by a;
drop table t1;
create table t1 (a int not null, b int not null);
insert into t1 values (1,1),(1,2),(3,1),(3,2),(2,2),(2,1);
create table t2 (a int not null, b int not null, key(a));
insert into t2 values (1,3),(3,1),(2,2),(1,1);
select t1.a,t2.b from t1,t2 where t1.a=t2.a group by t1.a,t2.b;
select t1.a,t2.b from t1,t2 where t1.a=t2.a group by t1.a,t2.b ORDER BY NULL;
drop table t1,t2;
create table t1 (a int, b int);
insert into t1 values (1, 4),(10, 40),(1, 4),(10, 43),(1, 4),(10, 41),(1, 4),(10, 43),(1, 4);
select a, MAX(b), INTERVAL (MAX(b), 1,3,10,30,39,40,50,60,100,1000) from t1 group by a;
select a, MAX(b), CASE MAX(b) when 4 then 4 when 43 then 43 else 0 end from t1 group by a;
select a, MAX(b), FIELD(MAX(b), '43', '4', '5') from t1 group by a;
select a, MAX(b), CONCAT_WS(MAX(b), '43', '4', '5') from t1 group by a;
select a, MAX(b), ELT(MAX(b), 'a', 'b', 'c', 'd', 'e', 'f') from t1 group by a;
select a, MAX(b), MAKE_SET(MAX(b), 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') from t1 group by a;
drop table t1;
create table t1 (id int not null, qty int not null);
insert into t1 values (1,2),(1,3),(2,4),(2,5);
select id, sum(qty) as sqty, count(qty) as cqty from t1 group by id having sum(qty)>2 and cqty>1;
select id, sum(qty) as sqty from t1 group by id having sqty>2 and count(qty)>1;
select id, sum(qty) as sqty, count(qty) as cqty from t1 group by id having sqty>2 and cqty>1;
select id, sum(qty) as sqty, count(qty) as cqty from t1 group by id having sum(qty)>2 and count(qty)>1;
select count(*), case interval(qty,2,3,4,5,6,7,8) when -1 then NULL when 0 then "zero" when 1 then "one" when 2 then "two" end as category from t1 group by category;
select count(*), interval(qty,2,3,4,5,6,7,8) as category from t1 group by category;
drop table t1;
CREATE TABLE t1 (
  userid int(10) unsigned,
  score smallint(5) unsigned,
  key (score)
);
INSERT INTO t1 VALUES (1,1),(2,2),(1,1),(3,3),(3,3),(3,3),(3,3),(3,3);
SELECT userid,count(*) FROM t1 GROUP BY userid ORDER BY userid DESC;
DROP TABLE t1;
CREATE TABLE t1 (
  i int(11) default NULL,
  j int(11) default NULL
);
INSERT INTO t1 VALUES (1,2),(2,3),(4,5),(3,5),(1,5),(23,5);
DROP TABLE t1;
create table t1 (a int);
insert into t1 values(null);
select min(a) is null from t1;
select min(a) is null or null from t1;
select 1 and min(a) is null from t1;
drop table t1;
create table t1 ( col1 int, col2 int );
insert into t1 values (1,1),(1,2),(1,3),(2,1),(2,2);
select group_concat( distinct col1 ) as alias from t1
  group by col2 having alias like '%';
drop table t1;
CREATE TABLE t1 (a INTEGER, b INTEGER, c INTEGER);
INSERT INTO t1 (a,b) VALUES (1,2),(1,3),(2,5);
SELECT a, 0.1*0+1 r2, SUM(1) r1 FROM t1 WHERE a = 1 GROUP BY a HAVING r1>1 AND r2=1;
SELECT a, ROUND(RAND(100)*10) r2, SUM(1) r1 FROM t1 GROUP BY a;
SELECT a, ROUND(RAND(100)*10) r2, SUM(1) r1 FROM t1 GROUP BY a
  HAVING r1>=1 AND r2<=7 AND r2 > 0;
SELECT a, ROUND(RAND(100)*10) r2, SUM(1) r1 FROM t1 GROUP BY a
  HAVING r1>=1 AND (SELECT r2<=7 AND r2 > 0 FROM t1 AS t2 LIMIT 1);
SELECT a, ROUND(RAND(100)*10) r2, SUM(1) r1 FROM t1 WHERE a = 1
 GROUP BY a HAVING r1>1 AND r2<=2;
SELECT a, ROUND(RAND(100)*10) r2, SUM(1) r1 FROM t1 WHERE a = 1
 GROUP BY a HAVING r1>1 AND r2<=2 ORDER BY a+r2+r1;
SELECT a,SUM(b) FROM t1 WHERE a=1 GROUP BY c;
SELECT a*SUM(b) FROM t1 WHERE a=1 GROUP BY c;
SELECT SUM(a)*SUM(b) FROM t1 WHERE a=1 GROUP BY c;
SELECT a,SUM(b) FROM t1 WHERE a=1 GROUP BY c HAVING a=1;
SELECT a AS d,SUM(b) FROM t1 WHERE a=1 GROUP BY c HAVING d=1;
SELECT SUM(a)*SUM(b) AS d FROM t1 WHERE a=1 GROUP BY c HAVING d > 0;
SELECT a, ROUND(RAND(100)*10) r2 FROM t1;
SELECT ROUND(RAND(100)*10) r2 FROM t1 GROUP BY r2;
DROP TABLE t1;
CREATE TABLE t1(i INT);
INSERT INTO t1 VALUES (NULL),(1);
SELECT DISTINCT STD(i)+0 as splus0, i+0 as plain FROM t1 GROUP BY i;
DROP TABLE t1;
create table t1(a int) ENGINE=INNODB;
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(8),(9);
create table t2 (
  a int,
  b varchar(200) NOT NULL,
  c varchar(50) NOT NULL,
  d varchar(100) NOT NULL,
  primary key (a,b(132),c,d),
  key a (a,b)
) ENGINE=INNODB charset=utf8mb3;
insert into t2 select 
   x3.a,  -- 3
   concat('val-', x3.a + 3*x4.a), -- 12
   concat('val-', @a:=x3.a + 3*x4.a + 12*C.a), -- 120
   concat('val-', @a + 120*D.a)
from t1 x3, t1 x4, t1 C, t1 D where x3.a < 3 and x4.a < 4 and D.a < 4
order by x3.a, x4.a, C.a, D.a;
delete from t2  where a = 2 and b = 'val-2' order by a,b,c,d limit 30;
select c from t2 where a = 2 and b = 'val-2' group by c;
drop table t1,t2;
create table t1 (b int4 unsigned not null);
insert into t1 values(3000000000);
select * from t1;
select min(b) from t1;
drop table t1;
CREATE TABLE t1 (id int PRIMARY KEY, user_id int, hostname longtext);
INSERT INTO t1 VALUES
  (1, 7, 'cache-dtc-af05.proxy.aol.com'),
  (2, 3, 'what.ever.com'),
  (3, 7, 'cache-dtc-af05.proxy.aol.com'),
  (4, 7, 'cache-dtc-af05.proxy.aol.com');
SELECT hostname, COUNT(DISTINCT user_id) as no FROM t1
  WHERE hostname LIKE '%aol%'
    GROUP BY hostname;
DROP TABLE t1;
CREATE TABLE t1 (a  int, b int);
INSERT INTO t1 VALUES (1,2), (1,3);
DROP TABLE t1;
CREATE TABLE t1 (id INT, dt DATETIME);
INSERT INTO t1 VALUES ( 1, '2005-05-01 12:30:00' );
INSERT INTO t1 VALUES ( 1, '2005-05-01 12:30:00' );
INSERT INTO t1 VALUES ( 1, '2005-05-01 12:30:00' );
INSERT INTO t1 VALUES ( 1, '2005-05-01 12:30:00' );
DROP TABLE t1;
CREATE TABLE t1 (id varchar(20) NOT NULL);
INSERT INTO t1 VALUES ('trans1'), ('trans2');
CREATE TABLE t2 (id varchar(20) NOT NULL, err_comment blob NOT NULL);
INSERT INTO t2 VALUES ('trans1', 'a problem');
SELECT COUNT(DISTINCT(t1.id)), LEFT(err_comment, 256) AS comment
  FROM t1 LEFT JOIN t2 ON t1.id=t2.id GROUP BY comment;
DROP TABLE t1, t2;
create table t1 (f1 date);
insert into t1 values('2005-06-06');
insert into t1 values('2005-06-06');
select date(left(f1+0,8)) from t1 group by 1;
drop table t1;
CREATE TABLE t1 (n int);
INSERT INTO t1 VALUES (1);
SELECT n+1 AS n FROM t1 GROUP BY n;
DROP TABLE t1;
create table t1(f1 varchar(5) key);
insert into t1 values (1),(2);
select sql_buffer_result max(f1) is null from t1;
select sql_buffer_result max(f1)+1 from t1;
drop table t1;
CREATE TABLE t1(a INT);
SELECT a FROM t1 GROUP BY `a`;
SELECT a FROM t1 GROUP BY `a`;
SELECT a FROM t1 HAVING 'a' > 1;
SELECT a FROM t1 HAVING "a" > 1;
SELECT a FROM t1 HAVING `a` > 1;
SELECT a FROM t1 ORDER BY 'a' DESC;
SELECT a FROM t1 ORDER BY "a" DESC;
SELECT a FROM t1 ORDER BY `a` DESC;
DROP TABLE t1;
CREATE TABLE t1 (
    f1 int(10) unsigned NOT NULL auto_increment primary key,
    f2 varchar(100) NOT NULL default ''
);
CREATE TABLE t2 (
    f1 varchar(10) NOT NULL default '',
    f2 char(3) NOT NULL default '',
    PRIMARY KEY  (`f1`),
    KEY `k1` (`f2`,`f1`)
);
INSERT INTO t1 values(NULL, '');
INSERT INTO `t2` VALUES ('486878','WDT'),('486910','WDT');
SELECT SQL_BUFFER_RESULT avg(t2.f1) FROM t1, t2 where t2.f2 = 'SIR' GROUP BY t1.f1;
SELECT avg(t2.f1) FROM t1, t2 where t2.f2 = 'SIR' GROUP BY t1.f1;
DROP TABLE t1, t2;
create table t1 (c1 char(3), c2 char(3));
create table t2 (c3 char(3), c4 char(3));
insert into t1 values ('aaa', 'bb1'), ('aaa', 'bb2');
insert into t2 values ('aaa', 'bb1'), ('aaa', 'bb2');
select t1.c1 as c2 from t1, t2 where t1.c2 = t2.c4
group by t1.c1;
drop table t1, t2;
CREATE TABLE t1 (a tinyint(3), b varchar(255), PRIMARY KEY  (a));
INSERT INTO t1 VALUES (1,'-----'), (6,'Allemagne'), (17,'Autriche'), 
    (25,'Belgique'), (54,'Danemark'), (62,'Espagne'), (68,'France');
CREATE TABLE t2 (a tinyint(3), b tinyint(3), PRIMARY KEY  (a), KEY b (b));
INSERT INTO t2 VALUES (1,1), (2,1), (6,6), (18,17), (15,25), (16,25),
 (17,25), (10,54), (5,62),(3,68);
CREATE VIEW v1 AS select t1.a, concat(t1.b,'') AS b, t1.b as real_b from t1;
SELECT straight_join v1.a, v1.b, v1.real_b from t2, v1
where t2.b=v1.a GROUP BY t2.b;
SELECT straight_join v1.a, v1.b, v1.real_b from t2, v1
where t2.b=v1.a GROUP BY t2.b;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT PRIMARY KEY, b INT, key (b));
INSERT INTO t1 VALUES (1,      1);
INSERT INTO t1 SELECT  a + 1 , MOD(a + 1 , 20) FROM t1;
INSERT INTO t1 SELECT  a + 2 , MOD(a + 2 , 20) FROM t1;
INSERT INTO t1 SELECT  a + 4 , MOD(a + 4 , 20) FROM t1;
INSERT INTO t1 SELECT  a + 8 , MOD(a + 8 , 20) FROM t1;
INSERT INTO t1 SELECT  a + 16, MOD(a + 16, 20) FROM t1;
INSERT INTO t1 SELECT  a + 32, MOD(a + 32, 20) FROM t1;
INSERT INTO t1 SELECT  a + 64, MOD(a + 64, 20) FROM t1;
SELECT MIN(b), MAX(b) from t1;
SELECT b, sum(1) FROM t1 GROUP BY b;
SELECT SQL_BIG_RESULT b, sum(1) FROM t1 GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(2,1),(3,2),(4,2),(5,3),(6,3);
SELECT MAX(a)-MIN(a) FROM t1 GROUP BY b;
SELECT CEILING(MIN(a)) FROM t1 GROUP BY b;
SELECT CASE WHEN AVG(a)>=0 THEN 'Positive' ELSE 'Negative' END FROM t1 
 GROUP BY b;
SELECT a + 1 FROM t1 GROUP BY a;
SELECT (SELECT t1_outer.a FROM t1 AS t1_inner GROUP BY b LIMIT 1) 
  FROM t1 AS t1_outer;
SELECT 1 FROM t1 as t1_outer GROUP BY a 
  HAVING (SELECT t1_outer.a FROM t1 AS t1_inner GROUP BY b LIMIT 1);
SELECT (SELECT SUM(t1_inner.a) FROM t1 AS t1_inner LIMIT 1) 
  FROM t1 AS t1_outer GROUP BY t1_outer.b;
SELECT (SELECT SUM(t1_inner.a) FROM t1 AS t1_inner GROUP BY t1_inner.b LIMIT 1)
  FROM t1 AS t1_outer;
SELECT (SELECT SUM(t1_outer.a) FROM t1 AS t1_inner LIMIT 1) 
  FROM t1 AS t1_outer GROUP BY t1_outer.b;
SELECT 1 FROM t1 as t1_outer 
  WHERE (SELECT t1_outer.b FROM t1 AS t1_inner GROUP BY t1_inner.b LIMIT 1);
SELECT b FROM t1 GROUP BY b HAVING CEILING(b) > 0;
SELECT 1 FROM t1 GROUP BY b HAVING b = 2 OR b = 3 OR SUM(a) > 12;
SELECT 1 FROM t1 GROUP BY b HAVING ROW (b,b) = ROW (1,1);
DROP TABLE t1;
create table t1(f1 int, f2 int);
select * from t1 group by f1, f2;
drop table t1;
CREATE TABLE t1(
  id INT AUTO_INCREMENT PRIMARY KEY, 
  c1 INT NOT NULL, 
  c2 INT NOT NULL,
  UNIQUE KEY (c2,c1));
INSERT INTO t1(c1,c2) VALUES (5,1), (4,1), (3,5), (2,3), (1,3);
SELECT * FROM t1 ORDER BY c1;
SELECT * FROM t1 GROUP BY id ORDER BY c1;
SELECT * FROM t1 GROUP BY id ORDER BY id DESC;
SELECT * FROM t1 GROUP BY c2 ,c1, id ORDER BY c2, c1;
SELECT * FROM t1 GROUP BY c2, c1, id ORDER BY c2 DESC, c1;
SELECT * FROM t1 GROUP BY c2, c1, id ORDER BY c2 DESC, c1 DESC;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, c INT DEFAULT 0);
INSERT INTO t1 (a, b) VALUES (3,3), (2,2), (3,3), (2,2), (3,3), (4,4);
CREATE TABLE t2 SELECT * FROM t1;
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*);
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*) + 1;
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*) + a;
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*), 1;
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*), a;
SELECT COUNT(*) FROM t1 ORDER BY SUM(a);
SELECT COUNT(*) FROM t1 ORDER BY SUM(a + 1);
SELECT COUNT(*) FROM t1 ORDER BY SUM(a) + 1;
SELECT COUNT(*) FROM t1 ORDER BY SUM(a), b;
SELECT SUM(a) FROM t1 ORDER BY COUNT(b);
SELECT t1.a FROM t1 ORDER BY (SELECT SUM(t2.a) FROM t2);
SELECT t1.a FROM t1 ORDER BY (SELECT SUM(t2.a) FROM t2 ORDER BY t2.a);
SELECT t1.a FROM t1 GROUP BY t1.a
  HAVING t1.a IN (SELECT t2.a FROM t2 ORDER BY SUM(t1.b));
SELECT 1 FROM t1 GROUP BY t1.a
  HAVING (SELECT AVG(SUM(t1.b) + 1) FROM t2 ORDER BY SUM(t2.a) LIMIT 1);
SELECT 1 FROM t1 GROUP BY t1.a
  HAVING (SELECT AVG(SUM(t1.b) + t2.b) FROM t2 ORDER BY SUM(t2.a) LIMIT 1);
SELECT 1 FROM t1 GROUP BY t1.a
  HAVING (SELECT AVG(SUM(t1.b) + 1) FROM t2 ORDER BY t2.a LIMIT 1);
SELECT 1 FROM t1 GROUP BY t1.a
  HAVING (SELECT AVG(SUM(t1.b) + t2.b) FROM t2 ORDER BY t2.a LIMIT 1);
SELECT t1.a FROM t1 
  WHERE t1.a = (SELECT t2.a FROM t2 GROUP BY t2.a
                  ORDER BY SUM(t2.b), SUM(t1.b) LIMIT 1);
SELECT t1.a, SUM(t1.b) FROM t1 
  WHERE t1.a = (SELECT SUM(t2.b) FROM t2 GROUP BY t2.a
                  ORDER BY SUM(t2.b), SUM(t1.b) LIMIT 1)
  GROUP BY t1.a;
SELECT t1.a, SUM(t1.b) FROM t1 
  WHERE t1.a = (SELECT SUM(t2.b) FROM t2
                  ORDER BY SUM(t2.b) + SUM(t1.b) LIMIT 1)
  GROUP BY t1.a;
SELECT t1.a, SUM(t1.b) FROM t1 
  WHERE t1.a = (SELECT SUM(t2.b) FROM t2
                  ORDER BY SUM(t2.b + t1.a) LIMIT 1)
  GROUP BY t1.a;
SELECT t1.a FROM t1 GROUP BY t1.a
    HAVING (1, 1) = (SELECT SUM(t1.a), t1.a FROM t2 LIMIT 1);
select avg (
  (select
    (select sum(outr.a + innr.a) from t1 as innr limit 1) as tt
   from t1 as outr order by outr.a limit 1))
from t1 as most_outer;
select (select sum(outr.a + t1.a) from t1 limit 1) as tt from t1 as outr order by outr.a;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  int_nokey int(11) NOT NULL,
  int_key int(11) NOT NULL,
  varchar_key varchar(1) NOT NULL,
  varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY int_key (int_key),
  KEY varchar_key (varchar_key)
);
INSERT INTO t1 VALUES 
(1,5,5, 'h','h'),
(2,1,1, '{','{'),
(3,1,1, 'z','z'),
(4,8,8, 'x','x'),
(5,7,7, 'o','o'),
(6,3,3, 'p','p'),
(7,9,9, 'c','c'),
(8,0,0, 'k','k'),
(9,6,6, 't','t'),
(10,0,0,'c','c');
SELECT COUNT(varchar_key) AS x FROM t1 WHERE pk = 8 having 'foo'='bar';
drop table t1;
CREATE TABLE t1 (a INT, b INT,
                 PRIMARY KEY (a),
                 KEY i2(a,b));
INSERT INTO t1 VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8);
INSERT INTO t1 SELECT a + 8,b FROM t1;
INSERT INTO t1 SELECT a + 16,b FROM t1;
INSERT INTO t1 SELECT a + 32,b FROM t1;
INSERT INTO t1 SELECT a + 64,b FROM t1;
INSERT INTO t1 SELECT a + 128,b FROM t1 limit 16;
SELECT a FROM t1 IGNORE INDEX FOR ORDER BY (PRIMARY,i2) ORDER BY a;
CREATE TABLE t2 (a INT, b INT, KEY(a));
INSERT INTO t2 VALUES (1, 1), (2, 2), (3,3), (4,4);
DROP TABLE t1, t2;
CREATE TABLE t1(
  a INT, 
  b INT NOT NULL, 
  c INT NOT NULL, 
  d INT, 
  UNIQUE KEY (c,b)
);
INSERT INTO t1 VALUES (1,1,1,50), (1,2,3,40), (2,1,3,4);
CREATE TABLE t2(
  a INT,
  b INT,
  UNIQUE KEY(a,b)
);
INSERT INTO t2 VALUES (NULL, NULL), (NULL, NULL), (NULL, 1), (1, NULL), (1, 1), (1,2);
SELECT c,b,d FROM t1 GROUP BY c,b,d;
SELECT c,b,d FROM t1 GROUP BY c,b,d ORDER BY NULL;
SELECT c,b,d FROM t1 ORDER BY c,b,d;
SELECT c,b,d FROM t1 GROUP BY c,b;
SELECT c,b   FROM t1 GROUP BY c,b;
SELECT a,b from t2 ORDER BY a,b;
SELECT a,b from t2 GROUP BY a,b;
SELECT a from t2 GROUP BY a;
SELECT b from t2 GROUP BY b;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 ( a INT, b INT );
SELECT b c, (SELECT a FROM t1 WHERE b = c)
FROM t1;
SELECT b c, (SELECT a FROM t1 WHERE b = c)
FROM t1 
HAVING b = 10;
SELECT b c, (SELECT a FROM t1 WHERE b = c)
FROM t1;
SELECT b c, (SELECT a FROM t1 WHERE b = c)
FROM t1 
HAVING b = 10;
INSERT INTO t1 VALUES (1, 1);
SELECT b c, (SELECT a FROM t1 WHERE b = c)
FROM t1;
INSERT INTO t1 VALUES (2, 1);
DROP TABLE t1;
CREATE TABLE t1(i INT);
INSERT INTO t1 VALUES (1), (10);
SELECT COUNT(i) FROM t1;
SELECT COUNT(i) FROM t1 WHERE i > 1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (4, 40), (1, 10), (2, 20), (2, 20), (3, 30);
SELECT (SELECT t1.a) aa, COUNT(DISTINCT b) FROM t1 GROUP BY aa;
SELECT (SELECT (SELECT t1.a)) aa, COUNT(DISTINCT b) FROM t1 GROUP BY aa;
SELECT (SELECT tt.a FROM t1 tt LIMIT 1) aa, COUNT(DISTINCT b) FROM t1
  GROUP BY aa;
CREATE TABLE t2 SELECT DISTINCT a FROM t1;
SELECT (SELECT t2.a FROM t2 WHERE t2.a = t1.a) aa, b, COUNT(DISTINCT b)
  FROM t1 GROUP BY aa, b;
SELECT (SELECT t2.a FROM t2 WHERE t2.a = t1.a) aa, b, COUNT(         b)
  FROM t1 GROUP BY aa, b;
SELECT (SELECT t2.a FROM t2 WHERE t2.a = t1.a) aa, b, COUNT(DISTINCT b)
  FROM t1 GROUP BY aa, b ORDER BY -aa, -b;
SELECT (SELECT t2.a FROM t2 WHERE t2.a = t1.a) aa, b, COUNT(         b)
  FROM t1 GROUP BY aa, b ORDER BY -aa, -b;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t2 VALUES (1), (2);
SELECT MIN(t2.a) FROM t2 LEFT JOIN t1 ON t2.a = t1.a;
SELECT MAX(t2.a) FROM t2 LEFT JOIN t1 ON t2.a = t1.a;
DROP TABLE t1, t2;
CREATE TABLE t1 (a text, b varchar(10));
INSERT INTO t1 VALUES (repeat('1', 1300),'one'), (repeat('1', 1300),'two');
SELECT SUBSTRING(a,1,10), LENGTH(a), GROUP_CONCAT(b) FROM t1 GROUP BY a;
SELECT SUBSTRING(a,1,10), LENGTH(a), GROUP_CONCAT(b) FROM t1 GROUP BY a;
SELECT SUBSTRING(a,1,10), LENGTH(a) FROM t1 GROUP BY a;
SELECT SUBSTRING(a,1,10), LENGTH(a) FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1(f1 INT NOT NULL);
INSERT INTO t1 VALUES (16777214),(0);
SELECT COUNT(*) FROM t1 LEFT JOIN t1 t2
ON 1 WHERE t2.f1 > 1 GROUP BY t2.f1;
DROP TABLE t1;
CREATE TABLE t1 (i int);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (pk int PRIMARY KEY);
INSERT INTO t2 VALUES (10);
CREATE VIEW v1 AS SELECT t2.pk FROM t2;
SELECT v1.pk
FROM t1 LEFT JOIN v1 ON t1.i = v1.pk 
GROUP BY v1.pk;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  a INT,
  b INT,
  c INT,
  KEY (a, b)
);
INSERT INTO t1 VALUES
  ( 1, 1,  1 ),
  ( 1, 2,  2 ),
  ( 1, 3,  3 ),
  ( 1, 4,  6 ),
  ( 1, 5,  5 ),
  ( 1, 9, 13 ),

  ( 2, 1,  6 ),
  ( 2, 2,  7 ),
  ( 2, 3,  8 );
SELECT a, AVG(t1.b),
(SELECT t11.c FROM t1 t11 WHERE t11.a = t1.a AND t11.b = AVG(t1.b)) AS t11c,
(SELECT t12.c FROM t1 t12 WHERE t12.a = t1.a AND t12.b = AVG(t1.b)) AS t12c
FROM t1 GROUP BY a;
SELECT a, AVG(t1.b),
(SELECT t11.c FROM t1 t11 WHERE t11.a = t1.a AND t11.b = AVG(t1.b)) AS t11c,
(SELECT t12.c FROM t1 t12 WHERE t12.a = t1.a AND t12.b = AVG(t1.b)) AS t12c
FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (0),(0);
SELECT 1 FROM t1 GROUP BY IF(`a`,'','');
SELECT 1 FROM t1 GROUP BY SUBSTRING('',SLEEP(0),'');
SELECT 1 FROM t1 GROUP BY SUBSTRING(SYSDATE() FROM 'K' FOR 'jxW<');
DROP TABLE t1;
CREATE TABLE t1 (f1 int, f2 DATE);
SELECT MIN(f2),MAX(f2) FROM t1;
SELECT f1,MIN(f2),MAX(f2) FROM t1 GROUP BY 1;
DROP TABLE t1;
CREATE TABLE t1 ( f1 int, f2 time);
INSERT INTO t1 VALUES (1,'01:27:35'), (1,'06:11:01'), (2,'19:53:05'),
(2,'21:44:25'), (3,'10:55:12'), (3,'05:45:11'), (4,'00:25:00');
SELECT MIN(f2),MAX(f2) FROM t1;
SELECT f1,MIN(f2),MAX(f2) FROM t1 GROUP BY 1;
DROP TABLE t1;
CREATE TABLE t1 (
  pk INT NOT NULL,
  col_int_nokey INT,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (10,7);
INSERT INTO t1 VALUES (11,1);
INSERT INTO t1 VALUES (12,5);
INSERT INTO t1 VALUES (13,3);
SELECT pk AS field1, col_int_nokey AS field2 
FROM t1 
WHERE col_int_nokey > 0
GROUP BY field1, field2;
CREATE TABLE where_subselect
  SELECT pk AS field1, col_int_nokey AS field2
  FROM t1
  WHERE col_int_nokey > 0
  GROUP BY field1, field2;
SELECT * 
FROM where_subselect
WHERE (field1, field2) IN (
  SELECT pk AS field1, col_int_nokey AS field2
  FROM t1
  WHERE col_int_nokey > 0
  GROUP BY field1, field2
);
DROP TABLE t1;
DROP TABLE where_subselect;
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES (0);
CREATE TABLE t2(b INT, KEY(b));
INSERT INTO t2 VALUES (0),(0);
PREPARE stmt FROM '
SELECT 1 FROM t2
LEFT JOIN t1 ON NULL
GROUP BY t2.b, t1.a
HAVING a <> 2';
DEALLOCATE PREPARE stmt;
DROP TABLE t1, t2;
CREATE TABLE t1 (
pk INT, col_int_key INT,
col_varchar_key VARCHAR(1), col_varchar_nokey VARCHAR(1)
);
INSERT INTO t1 VALUES
(10,7,'v','v'),(11,0,'s','s'),(12,9,'l','l'),(13,3,'y','y'),(14,4,'c','c'),
(15,2,'i','i'),(16,5,'h','h'),(17,3,'q','q'),(18,1,'a','a'),(19,3,'v','v'),
(20,6,'u','u'),(21,7,'s','s'),(22,5,'y','y'),(23,1,'z','z'),(24,204,'h','h'),
(25,224,'p','p'),(26,9,'e','e'),(27,5,'i','i'),(28,0,'y','y'),(29,3,'w','w');
CREATE TABLE t2 (
pk INT, col_int_key INT,
col_varchar_key VARCHAR(1), col_varchar_nokey VARCHAR(1),
PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES
(1,4,'b','b'),(2,8,'y','y'),(3,0,'p','p'),(4,0,'f','f'),(5,0,'p','p'),
(6,7,'d','d'),(7,7,'f','f'),(8,5,'j','j'),(9,3,'e','e'),(10,188,'u','u'),
(11,4,'v','v'),(12,9,'u','u'),(13,6,'i','i'),(14,1,'x','x'),(15,5,'l','l'),
(16,6,'q','q'),(17,2,'n','n'),(18,4,'r','r'),(19,231,'c','c'),(20,4,'h','h'),
(21,3,'k','k'),(22,3,'t','t'),(23,7,'t','t'),(24,6,'k','k'),(25,7,'g','g'),
(26,9,'z','z'),(27,4,'n','n'),(28,4,'j','j'),(29,2,'l','l'),(30,1,'d','d'),
(31,2,'t','t'),(32,194,'y','y'),(33,2,'i','i'),(34,3,'j','j'),(35,8,'r','r'),
(36,4,'b','b'),(37,9,'o','o'),(38,4,'k','k'),(39,5,'a','a'),(40,5,'f','f'),
(41,9,'t','t'),(42,3,'c','c'),(43,8,'c','c'),(44,0,'r','r'),(45,98,'k','k'),
(46,3,'l','l'),(47,1,'o','o'),(48,0,'t','t'),(49,189,'v','v'),(50,8,'x','x'),
(51,3,'j','j'),(52,3,'x','x'),(53,9,'k','k'),(54,6,'o','o'),(55,8,'z','z'),
(56,3,'n','n'),(57,9,'c','c'),(58,5,'d','d'),(59,9,'s','s'),(60,2,'j','j'),
(61,2,'w','w'),(62,5,'f','f'),(63,8,'p','p'),(64,6,'o','o'),(65,9,'f','f'),
(66,0,'x','x'),(67,3,'q','q'),(68,6,'g','g'),(69,5,'x','x'),(70,8,'p','p'),
(71,2,'q','q'),(72,120,'q','q'),(73,25,'v','v'),(74,1,'g','g'),(75,3,'l','l'),
(76,1,'w','w'),(77,3,'h','h'),(78,153,'c','c'),(79,5,'o','o'),(80,9,'o','o'),
(81,1,'v','v'),(82,8,'y','y'),(83,7,'d','d'),(84,6,'p','p'),(85,2,'z','z'),
(86,4,'t','t'),(87,7,'b','b'),(88,3,'y','y'),(89,8,'k','k'),(90,4,'c','c'),
(91,6,'z','z'),(92,1,'t','t'),(93,7,'o','o'),(94,1,'u','u'),(95,0,'t','t'),
(96,2,'k','k'),(97,7,'u','u'),(98,2,'b','b'),(99,1,'m','m'),(100,5,'o','o');
SELECT SUM(alias2.col_varchar_nokey) , alias2.pk AS field2 FROM t1 AS alias1
STRAIGHT_JOIN t2 AS alias2 ON alias2.pk = alias1.col_int_key WHERE alias1.pk
GROUP BY field2 ORDER BY alias1.col_int_key,alias2.pk;
DROP TABLE t1,t2;
CREATE TABLE t1 (i int);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (pk int PRIMARY KEY);
INSERT INTO t2 VALUES (10);
CREATE VIEW v1 AS SELECT t2.pk FROM t2;
SELECT v1.pk
FROM t1 LEFT JOIN v1 ON t1.i = v1.pk 
GROUP BY v1.pk;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (vc varchar(1), INDEX vc_idx (vc));
INSERT INTO t1 VALUES (NULL), ('o'), (NULL), ('p'), ('c');
SELECT vc FROM t1 GROUP BY vc;
DROP TABLE t1;
CREATE TABLE t1 (col1 int, col2 int);
INSERT INTO t1 VALUES (10,1),(11,7);
CREATE TABLE t2 (col1 int, col2 int);
INSERT INTO t2 VALUES (10,8);
DROP TABLE t1,t2;
CREATE TABLE t1(
 col1 int, 
 INDEX idx (col1)
);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
   (11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT SQL_BIG_RESULT col1 AS field1, col1 AS field2
FROM v1 
GROUP BY field1, field2;
SELECT SQL_BIG_RESULT tbl1.col1 AS field1, tbl2.col1 AS field2
FROM t1 as tbl1, t1 as tbl2 
GROUP BY field1, field2
ORDER BY field1, field2
LIMIT 3;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE it (
  pk INT NOT NULL,
  col_int_nokey INT NOT NULL,
  PRIMARY KEY (pk)
) ENGINE=INNODB;
CREATE TABLE ot (
  pk int(11) NOT NULL,
  col_int_nokey int(11) NOT NULL,
  PRIMARY KEY (pk)
) ENGINE=INNODB;
INSERT INTO ot VALUES (10,8);
DROP TABLE it,ot;
CREATE TABLE t1 (i INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (j INT) ENGINE=INNODB;
INSERT INTO t2 VALUES (1),(2);
DROP TABLE t1,t2;
CREATE TABLE t1 (
  a varchar(1)
) ENGINE=INNODB;
INSERT INTO t1 VALUES ('a'), ('b');
CREATE TABLE t2 (
  a varchar(1),
  b int(11)
) ENGINE=INNODB;
INSERT INTO t2 VALUES ('a',1);
SELECT (SELECT MAX(b) FROM t2 WHERE t2.a != t1.a) as MAX 
FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  pk INT,
  col_int_key INT,
  col_int_nokey INT,
  col_varchar_key VARCHAR(10),
  col_varchar_nokey VARCHAR(10),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES (), ();
SELECT alias1.col_int_nokey AS field1,
  (SELECT alias2.col_int_key
   FROM t1 AS alias2
   WHERE alias1.col_varchar_key <= alias1.col_varchar_nokey
  ) AS field2
FROM t1 AS alias1
GROUP BY field1, field2;
CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES(3),(4);
DROP TABLE t1,t2;
CREATE TABLE t1 (  
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_datetime_key datetime NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_datetime_key (col_datetime_key),
  KEY col_varchar_key (col_varchar_key)
);
CREATE TABLE t2 (  
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk)
);
CREATE TABLE t3 (  
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
);
CREATE VIEW view1 AS SELECT * FROM t1;
SELECT
    alias1.col_datetime_key AS field1
FROM (
        view1 AS alias1,
        t3 AS alias2
    )
WHERE (
    (SELECT MIN(sq1_alias1.pk)
     FROM t2 AS sq1_alias1
    )
) OR (alias1.col_varchar_key = alias2.col_varchar_key
  AND alias1.col_varchar_key = 'j'
) AND alias1.pk IS NULL
GROUP BY
    field1;
DROP TABLE t1,t2,t3;
DROP VIEW view1;
CREATE TABLE t1 (
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
);
CREATE TABLE t2 (
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
);
CREATE ALGORITHM=MERGE VIEW view1 AS
  SELECT CONCAT( table1.col_varchar_nokey , table2.col_varchar_key ) AS
field1
  FROM
    t2 AS table1 JOIN t1 AS table2
    ON table2.col_varchar_nokey = table1.col_varchar_key 
       AND
       table2.col_varchar_key >= table1.col_varchar_nokey 
ORDER BY field1;
DROP TABLE t1,t2;
DROP VIEW view1;
CREATE TABLE t1 (col_varchar_nokey varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('v'),('c');
DROP TABLE t1;
create table t1(a int, b int);
select 1 from t1 group by b;
drop table t1;
CREATE TABLE t1 (pk int, i1 int,  v1 varchar(1), primary key (pk));
INSERT INTO t1 VALUES (0,2,'b'),(1,4,'a'),(2,0,'a'),(3,7,'b'),(4,7,'c');
SELECT a1.v1,a2.v1 FROM t1 AS a1 JOIN t1 AS a2 ON a2.pk = a1.i1 group by
a1.v1,a2.v1 ORDER BY             a2.v1 ASC;
DROP TABLE t1;
CREATE TABLE t1 (pk int(11) NOT NULL AUTO_INCREMENT, col_int_key int(11) NOT
NULL, col_varchar_key varchar(1) NOT NULL, col_varchar_nokey varchar(1) NOT
NULL, PRIMARY KEY (pk), KEY col_int_key (col_int_key), KEY col_varchar_key
(col_varchar_key,col_int_key));
CREATE TABLE t2 (pk int(11) NOT NULL AUTO_INCREMENT, col_int_key int(11) NOT
NULL, col_varchar_key varchar(1) NOT NULL, col_varchar_nokey varchar(1) NOT
NULL, PRIMARY KEY (pk), KEY col_int_key (col_int_key), KEY col_varchar_key
(col_varchar_key,col_int_key));
SELECT SUM(alias2.col_varchar_nokey) , alias2.pk AS field2 FROM t1 AS alias1
STRAIGHT_JOIN t2 AS alias2 ON alias2.pk = alias1.col_int_key WHERE alias1.pk
group by field2 ORDER BY alias1.col_int_key,alias2.pk;
DROP TABLE t1,t2;
CREATE TABLE t1 (pk int(11) NOT NULL AUTO_INCREMENT, col_int_key int(11) NOT
NULL, col_datetime_key datetime NOT NULL, col_varchar_key varchar(1) NOT
NULL, col_varchar_nokey varchar(1) NOT NULL, PRIMARY KEY (pk), KEY
col_int_key (col_int_key), KEY col_datetime_key (col_datetime_key), KEY
col_varchar_key (col_varchar_key,col_int_key));
CREATE TABLE t2 (pk int(11) NOT NULL AUTO_INCREMENT, col_int_key int(11) NOT
NULL, col_datetime_key datetime NOT NULL, col_varchar_key varchar(1) NOT
NULL, col_varchar_nokey varchar(1) NOT NULL, PRIMARY KEY (pk), KEY
col_int_key (col_int_key), KEY col_datetime_key (col_datetime_key), KEY
col_varchar_key (col_varchar_key,col_int_key));
DROP TABLE t1,t2;
create table t1 (a int, b int);
create table t2 (a int, b int);
DROP TABLE t1,t2;
create table t1 (branch varchar(40), id int);
DROP TABLE t1;
create table t1 (a int, b int);
insert into t1 values (1, 2), (1, 3), (null, null);
select sum(a), count(*) from t1 group by a;
select round(sum(a)), count(*) from t1 group by a;
select ifnull(a, 'xyz') from t1 group by a;
DROP TABLE t1;
CREATE TABLE t1 (
  a int,
  b varchar(1),
  KEY (b,a)
) charset utf8mb4;
INSERT INTO t1 VALUES (1,NULL),(0,'a'),(1,NULL),(0,'a');
INSERT INTO t1 VALUES (1,'a'),(0,'a'),(1,'a'),(0,'a');
SELECT SQL_BUFFER_RESULT MIN(a), b FROM t1 WHERE t1.b = 'a' GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (0);
SELECT 1 FROM t1 WHERE 1 > ALL(SELECT 1 FROM t1 WHERE a);
DROP TABLE t1;
CREATE TABLE t1 (
  i INT PRIMARY KEY AUTO_INCREMENT,
  kp1 INT,
  kp2 INT,
  INDEX idx_noncov(kp1),
  INDEX idx_cov(kp1,kp2)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (NULL, 1, 1);
INSERT INTO t1 SELECT NULL, kp1, kp2+1 from t1;
INSERT INTO t1 SELECT NULL, kp1, kp2+2 from t1;
INSERT INTO t1 SELECT NULL, kp1, kp2+4 from t1;
INSERT INTO t1 SELECT NULL, kp1, kp2 from t1;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER);
INSERT INTO t1 VALUES (1), (2);
SELECT SUM(a) FROM t1 ORDER BY COUNT(*);
SELECT COUNT(*) FROM t1 ORDER BY COUNT(*);
SELECT COUNT(*) AS c FROM t1 ORDER BY COUNT(*);
SELECT COUNT(*) AS c FROM t1 ORDER BY c;
SELECT a, COUNT(*) FROM t1 GROUP BY a ORDER BY COUNT(*);
SELECT a, COUNT(*) AS c FROM t1 GROUP BY a ORDER BY COUNT(*);
SELECT a, COUNT(*) AS c FROM t1 GROUP BY a ORDER BY c;
SELECT a AS c FROM t1 GROUP BY a ORDER BY COUNT(*);
SELECT 1 FROM t1 HAVING COUNT(*) > 1 ORDER BY COUNT(*);
SELECT (SELECT 1 AS foo ORDER BY a) AS x
FROM t1;
SELECT (SELECT 1 AS foo ORDER BY t1.a) AS x
FROM t1;
SELECT (SELECT 1 AS foo ORDER BY COUNT(a)) AS x
FROM t1;
SELECT (SELECT 1 AS foo ORDER BY COUNT(t1.a)) AS x
FROM t1;
SELECT SUM(a) FROM t1 ORDER BY (SELECT COUNT(t1.a) FROM t1 AS t2);
SELECT a FROM t1;
SELECT a FROM t1;
SELECT a FROM t1;
SELECT a FROM t1;
DROP TABLE t1;
CREATE TABLE r(c BLOB) ENGINE=INNODB;
INSERT INTO r VALUES('');
SELECT 1 FROM r GROUP BY MAKE_SET(1,c) WITH ROLLUP;
DROP TABLE r;
CREATE TABLE AA (
col_varchar_1024_latin1 varchar(1024)  CHARACTER SET latin1,
pk integer auto_increment,
col_varchar_1024_utf8_key varchar(1024)  CHARACTER SET utf8mb3,
col_varchar_1024_latin1_key varchar(1024)  CHARACTER SET latin1,
col_varchar_10_utf8_key varchar(10)  CHARACTER SET utf8mb3,
col_varchar_10_latin1_key varchar(10)  CHARACTER SET latin1,
col_int int,
col_varchar_10_latin1 varchar(10)  CHARACTER SET latin1,
col_varchar_10_utf8 varchar(10)  CHARACTER SET utf8mb3,
col_varchar_1024_utf8 varchar(1024)  CHARACTER SET utf8mb3,
col_int_key int,
primary key (pk),
key (col_varchar_1024_utf8_key ),
key (col_varchar_1024_latin1_key ),
key (col_varchar_10_utf8_key ),
key (col_varchar_10_latin1_key ),
key (col_int_key )) ENGINE=innodb ROW_FORMAT=DYNAMIC;
CREATE OR REPLACE VIEW view_AA AS SELECT * FROM AA;
CREATE TABLE B (
col_varchar_1024_latin1_key varchar(1024)  CHARACTER SET latin1,
col_varchar_10_latin1 varchar(10)  CHARACTER SET latin1,
col_varchar_10_utf8_key varchar(10)  CHARACTER SET utf8mb3,
col_int_key int,
col_varchar_1024_latin1 varchar(1024)  CHARACTER SET latin1,
col_varchar_1024_utf8_key varchar(1024)  CHARACTER SET utf8mb3,
col_varchar_10_utf8 varchar(10)  CHARACTER SET utf8mb3,
col_int int,
pk integer auto_increment,
col_varchar_10_latin1_key varchar(10)  CHARACTER SET latin1,
col_varchar_1024_utf8 varchar(1024)  CHARACTER SET utf8mb3,
key (col_varchar_1024_latin1_key ),
key (col_varchar_10_utf8_key ),
key (col_int_key ),
key (col_varchar_1024_utf8_key ),
primary key (pk),
key (col_varchar_10_latin1_key )) ENGINE=INNODB;
SELECT
DISTINCT table1 . pk AS field1
FROM  view_AA AS table1  LEFT  JOIN B AS table2
ON  table1 . col_varchar_10_latin1_key =  table2 .
col_varchar_1024_latin1_key
WHERE ( ( table2 . pk > table1 . col_int_key AND table1 . pk NOT
BETWEEN 3 AND ( 3 + 3 ) ) AND table2 . pk <> 6 )
GROUP BY table1 . pk;
DROP TABLE AA,B;
DROP VIEW view_AA;
CREATE TABLE t1(a INT, b INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1,2), (3,4);
SELECT
  EXISTS
  (
    SELECT 1
    FROM (SELECT a FROM t1) t_inner
    GROUP BY t_inner.a
    ORDER BY MIN(t_outer.b)
  )
FROM t1 t_outer;
DROP TABLE t1;
CREATE TABLE t1(cc CHAR(1), n CHAR(1), d CHAR(1));
CREATE OR REPLACE ALGORITHM = MERGE VIEW v1 AS
 SELECT * FROM t1 WHERE cc = 'AUS' ORDER BY n;
SELECT d, COUNT(*) FROM v1 GROUP BY d;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t0 ( a INT );
INSERT INTO t0 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
CREATE TABLE t1 (
  pk INT NOT NULL AUTO_INCREMENT,
  a INT,
  b INT,
  PRIMARY KEY (pk),
  KEY idx1 (a),
  KEY idx2 (b, a),
  KEY idx3 (a, b)
) ENGINE = InnoDB;
INSERT INTO t1 (a, b) SELECT t01.a, t02.a FROM t0 t01, t0 t02;
SELECT DISTINCT a, MAX(b) FROM t1 WHERE a >= 0 GROUP BY a,a;
DROP TABLE t0, t1;
CREATE TABLE t1(
 a INTEGER,
 b BLOB(1),
 c BLOB(1),
 PRIMARY KEY(a,b(1)),
 UNIQUE KEY (a,c(1))
);
INSERT INTO t1 VALUES(1,2,1),(2,4,1);
SELECT a, (SELECT SUM(a + c) FROM (SELECT b as c FROM t1) AS v1) FROM t1;
DROP TABLE t1;
CREATE TABLE cc (pk int,  i int, c varchar(1),
                 PRIMARY KEY (pk, i), KEY c_key(c)) ENGINE=InnoDB;
SELECT c, i, pk FROM cc WHERE (cc.pk = 1)  GROUP BY c, i, pk;
DROP TABLE cc;
CREATE TABLE t1
(
  a INT GENERATED ALWAYS AS (1) VIRTUAL,
  b INT GENERATED ALWAYS AS (a) VIRTUAL,
  c INT GENERATED ALWAYS AS (1) VIRTUAL
);
DROP TABLE t1;
CREATE TABLE t1
(
  f1 INTEGER NOT NULL,
  f2 DATETIME NOT NULL,
  f3 VARCHAR(1) NOT NULL,
  KEY (f3)
);
INSERT INTO t1(f1, f2, f3) VALUES
(5, '2001-07-25 08:40:24.058646', 'j'),
(2, '1900-01-01 00:00:00', 's'),
(4, '2001-01-20 12:47:23.022022', 'x');
CREATE TABLE t2 (f1 VARCHAR(1) NOT NULL);
DROP TABLE t1,t2;
CREATE TABLE t(txt TEXT, i INT);
INSERT INTO t VALUES ('a', 2), ('b', 8), ('b', 0), ('c', 2);
SELECT txt, AVG(i) a FROM t GROUP BY txt ORDER BY a, txt;
SELECT txt, VAR_POP(i) v FROM t GROUP BY txt ORDER BY v, txt;
SELECT txt, STDDEV_POP(i) s FROM t GROUP BY txt ORDER BY s, txt;
SELECT SQL_BUFFER_RESULT txt, AVG(i) a FROM t GROUP BY txt ORDER BY a, txt;
SELECT SQL_BUFFER_RESULT txt, VAR_POP(i) v FROM t GROUP BY txt ORDER BY v, txt;
SELECT SQL_BUFFER_RESULT txt, STDDEV_POP(i) s FROM t
GROUP BY txt ORDER BY s, txt;
DROP TABLE t;
CREATE TABLE t1 (col_varchar VARCHAR(10), col_int_key INT);
INSERT INTO t1 VALUES('r',83);
SELECT col_varchar as field1, MAX(col_int_key) AS field3 FROM t1
GROUP BY col_varchar HAVING (field1 >= 'i' OR field3 <= 9);
SELECT CONCAT(col_varchar) as field1, MAX(col_int_key) AS field3
FROM t1 GROUP BY col_varchar HAVING (field1 >= 'i' OR field3 <= 9);
DROP TABLE t1;
CREATE TABLE t (a INT);
INSERT INTO t VALUES (0), (1), (1), (2);
SELECT COUNT(*) AS c FROM t ORDER BY (SELECT 1 HAVING c);
SELECT COUNT(*) AS c FROM t ORDER BY c;
SELECT COUNT(*) AS c FROM t ORDER BY c+1;
SELECT COUNT(*) AS c FROM t ORDER BY c+c;
SELECT COUNT(*) AS c FROM t HAVING (SELECT 1 HAVING c);
SELECT COUNT(*) AS c FROM t HAVING c;
SELECT a, COUNT(*) AS c FROM t GROUP BY a WITH ROLLUP
HAVING (SELECT 1 HAVING c);
SELECT a, COUNT(*) AS c FROM t GROUP BY a WITH ROLLUP HAVING c;
SELECT (SELECT COUNT(*) AS c FROM t HAVING c <> 0);
SELECT (SELECT COUNT(*) FROM t HAVING COUNT(*) <> 0);
SELECT (SELECT COUNT(*) AS c FROM t ORDER BY c);
SELECT (SELECT COUNT(*) FROM t ORDER BY COUNT(*));
SELECT 1 FROM t t1 HAVING (SELECT SUM(t1.a) s FROM t t2
                                  GROUP BY (SELECT 1 HAVING s > 0)) > 0;
SELECT (SELECT SUM(a)) FROM t;
SELECT SUM(a) AS s, (SELECT SUM(a)) FROM t;
SELECT a, (SELECT SUM(a)) s FROM t GROUP BY a;
SELECT 1 FROM t t1 HAVING (SELECT SUM(t1.a) s FROM t t2 HAVING s > 5);
SELECT (SELECT SUM(t1.a) s FROM t t2 WHERE t2.a = 0 HAVING s > 3) FROM t t1;
SELECT 1 FROM t HAVING (SELECT SUM(a)) > 0;
SELECT (SELECT SUM(a)) FROM t;
SELECT SUM(a) AS s, (SELECT 1 HAVING s) FROM t;
SELECT SUM(a) AS s, (SELECT 1 HAVING s IS NULL) FROM t;
SELECT COUNT(a) AS c, (SELECT 1 HAVING c) FROM t;
SELECT COUNT(a) AS c, (SELECT 1 HAVING c = 0) FROM t;
SELECT a, COUNT(*) c FROM t GROUP BY a ORDER BY (SELECT -a HAVING c > 0);
SELECT * FROM t t1 WHERE (SELECT SUM(t1.a) s FROM t t2 HAVING s = 0);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s FROM t t2 ORDER BY s);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s FROM t t2 ORDER BY s + 1);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s);
SELECT 1 FROM t WHERE (SELECT SUM(a)) > 0;
SELECT 1 FROM t GROUP BY (SELECT SUM(a));
SELECT * FROM t t1 WHERE (SELECT SUM(t1.a) s FROM t t2 HAVING s = 0);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s FROM t t2 ORDER BY s);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s FROM t t2 ORDER BY s + 1);
SELECT 1 FROM t t1 GROUP BY (SELECT SUM(t1.a) s);
SELECT 1 FROM t WHERE (SELECT SUM(a)) > 0;
SELECT 1 FROM t GROUP BY (SELECT SUM(a));
DROP TABLE t;
CREATE TABLE t(d DATE, i INT);
INSERT INTO t VALUES(NULL,1),('2017-01-14',3);
SELECT WEEK(d)/10, GROUP_CONCAT(i) FROM t GROUP BY WEEK(d)/10;
SELECT WEEK(d)/10, GROUP_CONCAT(i) FROM t GROUP BY WEEK(d)/10 ORDER BY WEEK(d)/10 DESC;
DROP TABLE t;
CREATE TABLE t1 (i INTEGER NOT NULL, j INTEGER NOT NULL, key(i,j));
INSERT INTO t1 VALUES (1,2),(1,4),(1,3),(2,5),(5,3),(2,6),(6,2);
SELECT i, SUM(j) FROM t1 GROUP BY i;
SELECT i, SUM(j) FROM t1 GROUP BY i ORDER BY i;
SELECT i, SUM(j) FROM t1 GROUP BY i ORDER BY SUM(j);
ALTER TABLE t1 ADD UNIQUE INDEX (i,j);
SELECT i, SUM(j) FROM t1 GROUP BY j,i ORDER BY i,j;
DROP TABLE t1;
CREATE TABLE t1 (
	f1 INTEGER,
	f2 INTEGER,
	KEY k1 ( f1 )
);
INSERT INTO t1 VALUES ( 1, 1 );
INSERT INTO t1 VALUES ( 1, 2 );
INSERT INTO t1 VALUES ( 1, 3 );
INSERT INTO t1 VALUES ( 2, 1 );
INSERT INTO t1 VALUES ( 2, 2 );
INSERT INTO t1 VALUES ( 3, 5 );
SELECT f1, f1 + 1, COUNT(DISTINCT f2) AS x FROM t1 GROUP BY f1 ORDER BY x;
DROP TABLE t1;
CREATE TABLE t1 (
  vc varchar(255) DEFAULT NULL,
  b tinyint DEFAULT NULL
);
INSERT INTO t1 (vc, b) VALUES (1, true), (2, false), (3, true), (4, false);
INSERT INTO t1 (vc) VALUES (5), (6), (7), (8), (9), (10);
SELECT COUNT(b), COUNT(*)
FROM t1;
SELECT COUNT(b)
FROM t1
HAVING COUNT(1) > 0;
DROP TABLE t1;
CREATE TABLE d (pk INT PRIMARY KEY);
INSERT INTO d VALUES (1),(2),(3),(4),(5);
CREATE TABLE c (col_varchar VARCHAR(1));
INSERT INTO c VALUES ('a'),('b'),('c'),('d'),('e');
SELECT COUNT(pk) FROM d WHERE EXISTS (SELECT col_varchar FROM c);
DROP TABLE c, d;
CREATE TABLE t1 (
  f1 integer,
  f2 integer,
  f3 integer
);
SELECT * FROM t1 GROUP BY f3,f2,f1 WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 (
  id_aams int NOT NULL ,
  PRIMARY KEY (id_aams)
);
CREATE TABLE t2 (
  id int NOT NULL,
  id_game int DEFAULT NULL,
  code_id char(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY codeid (code_id,id_game)
);
select count(distinct x.id_aams)
from (select *
      from (select t1.id_aams, t2.*
            from t1 left join t2
                 on t2.code_id='G0000000012' and
                    t1.id_aams=t2.id_game
            where t1.id_aams=1715000360
            order by t2.id desc
           ) as g
      group by g.id_aams
      having g.id is null
     ) as x;
PREPARE stmt from "
select count(distinct x.id_aams)
from (select g.id_aams, g.id
      from (select t1.id_aams, t2.*
            from t1 left join t2
                 on t2.code_id='G0000000012' and
                    t1.id_aams=t2.id_game
            where t1.id_aams=1715000360
            order by t2.id desc
           ) as g
      group by g.id_aams
      having g.id is null
     ) as x";
DEALLOCATE PREPARE stmt;
DROP TABLE t1, t2;
CREATE TABLE w(a INTEGER);
INSERT INTO w VALUES (1),(2),(3),(4);
DROP TABLE w;
CREATE TABLE t1 (a DOUBLE);
INSERT INTO t1 ( a ) VALUES ( 0.1 );
SELECT TRUNCATE(a, 1) FROM t1 GROUP BY TRUNCATE(a, 1) WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER, b VARCHAR(1));
INSERT INTO t1 VALUES (1, 'x');
SELECT SUM(t1.a) AS field1, CONCAT(d1.b) AS field2
FROM (SELECT * FROM t1) AS d1, t1
GROUP BY field2 HAVING field2 > '' AND field1 < 4;
DROP TABLE t1;
CREATE TABLE t1 (
  a INTEGER,
  e INTEGER
);
INSERT INTO t1 VALUES (1,0);
INSERT INTO t1 VALUES (1,8388607);
DROP TABLE t1;
CREATE TABLE t1 (
  a INTEGER,
  b VARCHAR(1)
);
CREATE INDEX i1 ON t1 (b);
INSERT INTO t1 VALUES (1,'0');
INSERT INTO t1 VALUES (1,'y');
INSERT INTO t1 VALUES (1,'Q');
INSERT INTO t1 VALUES (1,'H');
INSERT INTO t1 VALUES (1,'j');
INSERT INTO t1 VALUES (1,'a');
INSERT INTO t1 VALUES (1,'b');
INSERT INTO t1 VALUES (1,'j');
INSERT INTO t1 VALUES (1,'q');
INSERT INTO t1 VALUES (1,'e');
DROP TABLE t1;
CREATE TABLE t1 (
  f1 INTEGER
);
SELECT
  (
    SELECT COUNT(*) +
      (
        SELECT COUNT(*)
        FROM t1
        WHERE f1 = c.f2
      )
    FROM t1
  )
  FROM (SELECT 555 AS f2) AS c;
DROP TABLE t1;
CREATE TABLE t(x INTEGER);
INSERT INTO t VALUES (1), (2), (3);
SELECT RAND(1) r, COUNT(*) FROM t GROUP BY x ORDER BY r;
DROP TABLE t;
CREATE TABLE t1 (
  a INTEGER,
  b INTEGER
);
SELECT t1.b
FROM t1, t1 AS t2
WHERE t1.a = t1.b AND t1.a = t2.b
GROUP BY t1.b
ORDER BY t2.b;
DROP TABLE t1;
CREATE TABLE t1(
  c1 smallint NOT NULL
);
INSERT INTO t1 VALUES(32767),(14742),(14743);
SELECT COUNT(*), SUM(c1), AVG(c1), MIN(c1), MAX(c1) FROM t1 WHERE c1 > 32767;
PREPARE stmt from
'SELECT COUNT(*), SUM(c1), AVG(c1), MIN(c1), MAX(c1) FROM t1 WHERE c1 > ?';
SELECT BIT_AND(c1), BIT_OR(c1), BIT_XOR(c1) FROM t1 WHERE c1 > 32767;
PREPARE stmt from
'SELECT BIT_AND(c1), BIT_OR(c1), BIT_XOR(c1) FROM t1 WHERE c1 > ?';
SELECT GROUP_CONCAT(c1), JSON_ARRAYAGG(c1), JSON_OBJECTAGG('key', c1)
FROM t1
WHERE c1 > 32767;
PREPARE stmt from
"SELECT GROUP_CONCAT(c1), JSON_ARRAYAGG(c1), JSON_OBJECTAGG('key', c1)
 FROM t1
 WHERE c1 > ?";
SELECT STDDEV_POP(c1), STDDEV_SAMP(c1), VAR_POP(c1), VAR_SAMP(c1)
FROM t1
WHERE c1 > 32767;
PREPARE stmt from
'SELECT STDDEV_POP(c1), STDDEV_SAMP(c1), VAR_POP(c1), VAR_SAMP(c1)
 FROM t1
 WHERE c1 > ?';
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (NULL), (1), (2);
SELECT DISTINCT a, COUNT(*) FROM t1 GROUP BY a WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1(id INT, b1 BIT, b9 BIT(9), b64 BIT(64));
INSERT INTO t1 VALUES
(1, b'0', b'000000000', b'0000000000000000000000000000000000000000000000000000000000000000'),
(2, b'1', b'100000000', b'1000000000000000000000000000000000000000000000000000000000000000');
CREATE INDEX i1 ON t1(id);
SELECT HEX(CONCAT(MIN(b1))), HEX(CONCAT(MIN(b9))), HEX(CONCAT(MIN(b64))) FROM t1 GROUP BY id;
SELECT HEX(CONCAT(MIN(b1))), HEX(CONCAT(MIN(b9))), HEX(CONCAT(MIN(b64))) FROM t1 IGNORE INDEX(i1) GROUP BY id;
DROP TABLE t1;
CREATE TABLE t1(f1 INTEGER);
INSERT INTO t1 VALUES(1);
SELECT SQL_BUFFER_RESULT MAX(f1)+1, 1 AS f2  FROM t1 GROUP BY f2;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b VARCHAR(1) );
INSERT INTO t1 VALUES (3, 'Q'), (4, '5');
CREATE TABLE t2 ( a INTEGER );
INSERT INTO t2 VALUES (3), (4);
SELECT
  t2d.a,
  SUM(t1.b) AS field2
FROM
  t1
  JOIN ( SELECT * FROM t2 ) AS t2d ON t1.a = t2d.a
GROUP BY t2d.a
HAVING t2d.a <> 3 OR field2 < 5;
DROP TABLE t1, t2;
CREATE TABLE t (i INTEGER, blobfield LONGTEXT);
INSERT INTO t VALUES (1, '');
PREPARE ps FROM '
SELECT d.i, COUNT(*)
FROM t, LATERAL (SELECT i, blobfield) AS d
GROUP BY d.i
HAVING d.i < 100
ORDER BY d.i
';
DEALLOCATE PREPARE ps;
DROP TABLE t;
CREATE TABLE t1 (a INTEGER PRIMARY KEY, b INTEGER);
INSERT INTO t1 VALUES (1, 2), (2, 1), (3, 1);
CREATE TABLE t2 (a INTEGER, b INTEGER, KEY (b));
INSERT INTO t2 VALUES (1, 11);
CREATE TABLE t3 (a INTEGER PRIMARY KEY, b INTEGER);
INSERT INTO t3 VALUES (1, 10), (2, 11), (3, 0), (4, 0), (5, 0), (6, 0);
SELECT t1.a, MAX(t2.a)
FROM t1 LEFT JOIN (t2 JOIN t3 ON t2.b = t3.b) ON t1.b = t3.a
GROUP BY t1.a;
SELECT SQL_BUFFER_RESULT t1.a, MAX(t2.a)
FROM t1 LEFT JOIN (t2 JOIN t3 ON t2.b = t3.b) ON t1.b = t3.a
GROUP BY t1.a;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (f1 INTEGER, PRIMARY KEY(f1));
SELECT SUM(t1.f1)
FROM t1 JOIN t1 AS t2
        ON t1.f1 = t2.f1
ORDER BY RANK() OVER(), CAST(t1.f1 AS UNSIGNED);
DROP TABLE t1;
CREATE TABLE t1(x INT PRIMARY KEY);
CREATE TABLE t2(x INT PRIMARY KEY);
CREATE TABLE t3(x INT);
INSERT INTO t1 VALUES (1);
SELECT t2.x
FROM
  t1
  LEFT JOIN t2
  LEFT JOIN t3 ON t3.x = t2.x ON t1.x = t3.x
WHERE t3.x IS NULL
GROUP BY t2.x
ORDER BY t2.x;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  id INT,
  x INT,
  PRIMARY KEY (id)
);
CREATE TABLE t2 (
  id INT
);
INSERT INTO t1 VALUES (1, 1), (2, 2);
INSERT INTO t2 VALUES (1), (2);
SELECT t1.x
FROM t1, t2
WHERE t1.id = t2.id
GROUP BY t1.x WITH ROLLUP;
DROP TABLE t1, t2;
CREATE TABLE t1 (x INT);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (pk INT PRIMARY KEY);
INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (6), (7), (8);
SELECT t1.x FROM t1, t2 WHERE t1.x = t2.pk
GROUP BY t1.x
HAVING (COUNT(*) = 3 AND COUNT(*) > 6) OR t1.x = 2;
DROP TABLE t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, x INT);
INSERT INTO t1(pk) VALUES (1), (2), (3), (4), (5);
CREATE TABLE t2 (x INT);
PREPARE ps FROM
'SELECT 1 FROM t1, (SELECT DISTINCT x FROM t2) AS ot2
 WHERE t1.pk = ot2.x GROUP BY ot2.x, t1.x';
DEALLOCATE PREPARE ps;
DROP TABLE t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, x INT);
INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3);
CREATE TABLE t2 (pk INT PRIMARY KEY);
INSERT INTO t2 VALUES (1), (2), (3), (4), (5);
SELECT DISTINCT t1.x FROM t1, t2 WHERE t1.x = t2.pk GROUP BY t1.pk;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT AUTO_INCREMENT PRIMARY KEY, b INT, KEY(b));
INSERT INTO t1(b)
WITH RECURSIVE qn(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<250)
SELECT n FROM qn;
INSERT INTO t1(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t1;
CREATE TABLE t2(b INT PRIMARY KEY, c INT);
INSERT INTO t2
WITH RECURSIVE qn(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<250)
SELECT n, n FROM qn;
CREATE TABLE t3(b INT PRIMARY KEY, d INT);
INSERT INTO t3
WITH RECURSIVE qn(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<250)
SELECT n, n FROM qn;
SELECT b, COUNT(*) FROM t1 LEFT JOIN t2 USING (b) LEFT JOIN t3 USING (b)
GROUP BY b;
DROP TABLE t1, t2, t3;
CREATE TABLE t1(x INT, y INT);
CREATE TABLE t2(x INT, y INT);
CREATE TABLE t3(id INT PRIMARY KEY, x INT, y INT);
INSERT INTO t1 VALUES (1, 3), (2, 3), (3, 2), (4, 3), (5, 1), (6, 3);
INSERT INTO t2 VALUES (1, 1), (2, 2), (1, 3);
INSERT INTO t3 VALUES (1, 1, 0), (2, 2, 0), (3, 3, 0),
                      (4, 4, 0), (5, 5, 0), (6, 6, 0);
SELECT t1.x, dt.* FROM t1, LATERAL (
  SELECT SQL_BIG_RESULT t2.y, SUM(t3.x)
  FROM t2, t3 WHERE t2.x = t3.id AND t2.y + t3.y < t1.y
  GROUP BY t2.y
) AS dt;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INTEGER PRIMARY KEY, b INTEGER);
INSERT INTO t1 VALUES  (1, 1), (2, 2), (3, 2);
CREATE TABLE t2 (a INTEGER PRIMARY KEY, b INTEGER);
INSERT INTO t2 VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);
SELECT t1.a, MAX(t2.b) FROM t1 LEFT JOIN t2 ON t1.b = t2.a AND t1.a <> 2
GROUP BY t1.a;
DROP TABLE t1, t2;
CREATE TABLE t(f FLOAT, d double, id INT);
INSERT INTO t VALUES (0.0, 0.0, 1),
  (ROUND(CAST(-.4 AS FLOAT)), ROUND(CAST(-.4 AS DOUBLE)), 2), # Insert -0.0
  (ROUND(CAST(-.4 AS FLOAT)), ROUND(CAST(-.4 AS DOUBLE)), 1), # Insert -0.0
  (100, 100, 100);
SELECT * FROM t;
SELECT f, SUM(id) FROM t GROUP BY f;
SELECT d, SUM(id) FROM t GROUP BY d;
SELECT f, SUM(id) FROM t GROUP BY id, f;
SELECT d, SUM(id) FROM t GROUP BY id, d;
SELECT DISTINCT f from t;
SELECT DISTINCT d from t;
SELECT DISTINCT id, f from t;
SELECT DISTINCT id, d from t;
SELECT COUNT(DISTINCT f), COUNT(DISTINCT d), AVG(DISTINCT f), AVG(DISTINCT d) FROM t;
SELECT COUNT(DISTINCT f, id), GROUP_CONCAT(DISTINCT f, id) FROM t;
SELECT COUNT(DISTINCT d, id), GROUP_CONCAT(DISTINCT d, id) FROM t;
DROP TABLE t;
CREATE TABLE product (
  value INT NOT NULL AUTO_INCREMENT,
  code VARCHAR(255),
  name VARCHAR(255),
  comment VARCHAR(255),
  platform VARCHAR(50),
  KEY idx_key (value)
);
INSERT INTO product(code, name) VALUES(@str, @str);
SELECT COUNT(*)
FROM ( SELECT ANY_VALUE(value)
       FROM product
       GROUP BY code, name, comment, platform ) derived;
DROP TABLE product;
