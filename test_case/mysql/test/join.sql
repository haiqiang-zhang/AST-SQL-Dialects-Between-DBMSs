SELECT * FROM t1 JOIN t2;
SELECT * FROM t1 INNER JOIN t2;
SELECT * from t1 JOIN t2 USING (S1);
SELECT * FROM t1 INNER JOIN t2 USING (S1);
SELECT * from t1 CROSS JOIN t2;
SELECT * from t1 LEFT JOIN t2 USING(S1);
SELECT * from t1 LEFT JOIN t2 ON(t2.S1=2);
SELECT * from t1 RIGHT JOIN t2 USING(S1);
drop table t1,t2;
create table t1 (id int primary key);
create table t2 (id int);
insert into t1 values (75);
insert into t1 values (79);
insert into t1 values (78);
insert into t1 values (77);
insert into t1 values (104);
insert into t1 values (103);
insert into t1 values (102);
insert into t1 values (101);
insert into t1 values (105);
insert into t1 values (106);
insert into t1 values (107);
insert into t2 values (107),(75),(1000);
select t1.id, t2.id from t1, t2 where t2.id = t1.id;
select t1.id, count(t2.id) from t1,t2 where t2.id = t1.id group by t1.id;
select t1.id,t2.id from t2 left join t1 on t1.id>=74 and t1.id<=0 where t2.id=75 and t1.id is null;
drop table t1,t2;
CREATE TABLE t2 (
  id int(11) NOT NULL auto_increment,
  category int(11) DEFAULT '0' NOT NULL,
  county int(11) DEFAULT '0' NOT NULL,
  state int(11) DEFAULT '0' NOT NULL,
  phones int(11) DEFAULT '0' NOT NULL,
  nophones int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (id),
  KEY category (category,county,state)
);
INSERT INTO t2 VALUES (3,2,11,12,5400,7800);
INSERT INTO t2 VALUES (4,2,25,12,6500,11200);
INSERT INTO t2 VALUES (5,1,37,6,10000,12000);
create table t1 (a int primary key);
insert into t1 values(1),(2);
select t1.a from t1 as t1 left join t1 as t2 using (a) left join t1 as t3 using (a) left join t1 as t4 using (a) left join t1 as t5 using (a) left join t1 as t6 using (a) left join t1 as t7 using (a) left join t1 as t8 using (a) left join t1 as t9 using (a) left join t1 as t10 using (a) left join t1 as t11 using (a) left join t1 as t12 using (a) left join t1 as t13 using (a) left join t1 as t14 using (a) left join t1 as t15 using (a) left join t1 as t16 using (a) left join t1 as t17 using (a) left join t1 as t18 using (a) left join t1 as t19 using (a) left join t1 as t20 using (a) left join t1 as t21 using (a) left join t1 as t22 using (a) left join t1 as t23 using (a) left join t1 as t24 using (a) left join t1 as t25 using (a) left join t1 as t26 using (a) left join t1 as t27 using (a) left join t1 as t28 using (a) left join t1 as t29 using (a) left join t1 as t30 using (a) left join t1 as t31 using (a);
select a from t1 as t1 left join t1 as t2 using (a) left join t1 as t3 using (a) left join t1 as t4 using (a) left join t1 as t5 using (a) left join t1 as t6 using (a) left join t1 as t7 using (a) left join t1 as t8 using (a) left join t1 as t9 using (a) left join t1 as t10 using (a) left join t1 as t11 using (a) left join t1 as t12 using (a) left join t1 as t13 using (a) left join t1 as t14 using (a) left join t1 as t15 using (a) left join t1 as t16 using (a) left join t1 as t17 using (a) left join t1 as t18 using (a) left join t1 as t19 using (a) left join t1 as t20 using (a) left join t1 as t21 using (a) left join t1 as t22 using (a) left join t1 as t23 using (a) left join t1 as t24 using (a) left join t1 as t25 using (a) left join t1 as t26 using (a) left join t1 as t27 using (a) left join t1 as t28 using (a) left join t1 as t29 using (a) left join t1 as t30 using (a) left join t1 as t31 using (a);
drop table t1;
CREATE TABLE t1 (
  a int(11) NOT NULL,
  b int(11) NOT NULL,
  PRIMARY KEY  (a,b)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(2,3);
DROP TABLE t1, t2;
CREATE TABLE t1 (d DATE NOT NULL);
CREATE TABLE t2 (d DATE NOT NULL);
INSERT INTO t1 (d) VALUES ('2001-08-01'),('1000-01-01');
SELECT * FROM t1 LEFT JOIN t2 USING (d) WHERE t2.d IS NULL;
SELECT * FROM t1 LEFT JOIN t2 USING (d) WHERE d IS NULL;
SELECT * from t1 WHERE t1.d IS NULL;
SELECT * FROM t1 WHERE 1/0 IS NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  Document_ID varchar(50) NOT NULL default '',
  Contractor_ID varchar(6) NOT NULL default '',
  Language_ID char(3) NOT NULL default '',
  Expiration_Date datetime default NULL,
  Publishing_Date datetime default NULL,
  Title text,
  Column_ID varchar(50) NOT NULL default '',
  PRIMARY KEY  (Language_ID,Document_ID,Contractor_ID)
);
INSERT INTO t1 VALUES ('xep80','1','ger','2001-12-31 20:00:00','2001-11-12 10:58:00','Kartenbestellung - jetzt auch online','anle'),('','999998','',NULL,NULL,NULL,'');
CREATE TABLE t2 (
  Contractor_ID char(6) NOT NULL default '',
  Language_ID char(3) NOT NULL default '',
  Document_ID char(50) NOT NULL default '',
  CanRead char(1) default NULL,
  Customer_ID int(11) NOT NULL default '0',
  PRIMARY KEY  (Contractor_ID,Language_ID,Document_ID,Customer_ID)
);
INSERT INTO t2 VALUES ('5','ger','xep80','1',999999),('1','ger','xep80','1',999999);
CREATE TABLE t3 (
  Language_ID char(3) NOT NULL default '',
  Column_ID char(50) NOT NULL default '',
  Contractor_ID char(6) NOT NULL default '',
  CanRead char(1) default NULL,
  Active char(1) default NULL,
  PRIMARY KEY  (Language_ID,Column_ID,Contractor_ID)
);
INSERT INTO t3 VALUES ('ger','home','1','1','1'),('ger','Test','1','0','0'),('ger','derclu','1','0','0'),('ger','clubne','1','0','0'),('ger','philos','1','0','0'),('ger','clubko','1','0','0'),('ger','clubim','1','1','1'),('ger','progra','1','0','0'),('ger','progvo','1','0','0'),('ger','progsp','1','0','0'),('ger','progau','1','0','0'),('ger','progku','1','0','0'),('ger','progss','1','0','0'),('ger','nachl','1','0','0'),('ger','mitgli','1','0','0'),('ger','mitsu','1','0','0'),('ger','mitbus','1','0','0'),('ger','ergmar','1','1','1'),('ger','home','4','1','1'),('ger','derclu','4','1','1'),('ger','clubne','4','0','0'),('ger','philos','4','1','1'),('ger','clubko','4','1','1'),('ger','clubim','4','1','1'),('ger','progra','4','1','1'),('ger','progvo','4','1','1'),('ger','progsp','4','1','1'),('ger','progau','4','0','0'),('ger','progku','4','1','1'),('ger','progss','4','1','1'),('ger','nachl','4','1','1'),('ger','mitgli','4','0','0'),('ger','mitsu','4','0','0'),('ger','mitbus','4','0','0'),('ger','ergmar','4','1','1'),('ger','progra2','1','0','0'),('ger','archiv','4','1','1'),('ger','anmeld','4','1','1'),('ger','thema','4','1','1'),('ger','edito','4','1','1'),('ger','madis','4','1','1'),('ger','enma','4','1','1'),('ger','madis','1','1','1'),('ger','enma','1','1','1'),('ger','vorsch','4','0','0'),('ger','veranst','4','0','0'),('ger','anle','4','1','1'),('ger','redak','4','1','1'),('ger','nele','4','1','1'),('ger','aukt','4','1','1'),('ger','callcenter','4','1','1'),('ger','anle','1','0','0');
delete from t1 where Contractor_ID='999998';
insert into t1 (Contractor_ID) Values ('999998');
SELECT DISTINCT COUNT(t1.Title) FROM t1,
t2, t3 WHERE 
t1.Document_ID='xep80' AND t1.Contractor_ID='1' AND 
t1.Language_ID='ger' AND '2001-12-21 23:14:24' >= 
Publishing_Date AND '2001-12-21 23:14:24' <= Expiration_Date AND 
t1.Document_ID = t2.Document_ID AND 
t1.Language_ID = t2.Language_ID AND 
t1.Contractor_ID = t2.Contractor_ID AND ( 
t2.Customer_ID = '4'  OR 
t2.Customer_ID = '999999'  OR 
t2.Customer_ID = '1' )AND t2.CanRead 
= '1'  AND t1.Column_ID=t3.Column_ID AND 
t1.Language_ID=t3.Language_ID AND ( 
t3.Contractor_ID = '4'  OR 
t3.Contractor_ID = '999999'  OR 
t3.Contractor_ID = '1') AND 
t3.CanRead='1' AND t3.Active='1';
drop table t1,t2,t3;
CREATE TABLE t1 (
  t1_id int(11) default NULL,
  t2_id int(11) default NULL,
  type enum('Cost','Percent') default NULL,
  cost_unit enum('Cost','Unit') default NULL,
  min_value double default NULL,
  max_value double default NULL,
  t3_id int(11) default NULL,
  item_id int(11) default NULL
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (12,5,'Percent','Cost',-1,0,-1,-1),(14,4,'Percent','Cost',-1,0,-1,-1),(18,5,'Percent','Cost',-1,0,-1,-1),(19,4,'Percent','Cost',-1,0,-1,-1),(20,5,'Percent','Cost',100,-1,22,291),(21,5,'Percent','Cost',100,-1,18,291),(22,1,'Percent','Cost',100,-1,6,291),(23,1,'Percent','Cost',100,-1,21,291),(24,1,'Percent','Cost',100,-1,9,291),(25,1,'Percent','Cost',100,-1,4,291),(26,1,'Percent','Cost',100,-1,20,291),(27,4,'Percent','Cost',100,-1,7,202),(28,1,'Percent','Cost',50,-1,-1,137),(29,2,'Percent','Cost',100,-1,4,354),(30,2,'Percent','Cost',100,-1,9,137),(93,2,'Cost','Cost',-1,10000000,-1,-1);
CREATE TABLE t2 (
  id int(10) unsigned NOT NULL auto_increment,
  name varchar(255) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,'s1'),(2,'s2'),(3,'s3'),(4,'s4'),(5,'s5');
select t1.*, t2.*  from t1, t2 where t2.id=t1.t2_id limit 2;
drop table t1,t2;
CREATE TABLE t1 (
  siteid varchar(25) NOT NULL default '',
  emp_id varchar(30) NOT NULL default '',
  rate_code varchar(10) default NULL,
  UNIQUE KEY site_emp (siteid,emp_id),
  KEY siteid (siteid)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('rivercats','psmith','cust'), ('rivercats','KWalker','cust');
CREATE TABLE t2 (
  siteid varchar(25) NOT NULL default '',
  rate_code varchar(10) NOT NULL default '',
  base_rate float NOT NULL default '0',
  PRIMARY KEY  (siteid,rate_code),
  FULLTEXT KEY rate_code (rate_code)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES ('rivercats','cust',20);
SELECT emp.rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE emp.emp_id = 'psmith' AND lr.siteid = 'rivercats';
SELECT emp.rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE lr.siteid = 'rivercats' AND emp.emp_id = 'psmith';
SELECT rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE emp.emp_id = 'psmith' AND siteid = 'rivercats';
SELECT rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE siteid = 'rivercats' AND emp.emp_id = 'psmith';
drop table t1,t2;
CREATE TABLE t1 (ID INTEGER NOT NULL PRIMARY KEY, Value1 VARCHAR(255));
CREATE TABLE t2 (ID INTEGER NOT NULL PRIMARY KEY, Value2 VARCHAR(255));
INSERT INTO t1 VALUES (1, 'A');
INSERT INTO t2 VALUES (1, 'B');
SELECT * FROM t1 NATURAL JOIN t2 WHERE 1 AND (Value1 = 'A' AND Value2 <> 'B');
SELECT * FROM t1 NATURAL JOIN t2 WHERE 1 AND Value1 = 'A' AND Value2 <> 'B';
SELECT * FROM t1 NATURAL JOIN t2 WHERE (Value1 = 'A' AND Value2 <> 'B') AND 1;
drop table t1,t2;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
CREATE TABLE t3 (c int);
SELECT * FROM t1 NATURAL JOIN t2 NATURAL JOIN t3;
DROP TABLE t1, t2, t3;
create table t1 (i int);
create table t2 (i int);
create table t3 (i int);
insert into t1 values(1),(2);
insert into t2 values(2),(3);
insert into t3 values (2),(4);
select * from t1 natural left join t2;
select * from t1 left join t2 on (t1.i=t2.i);
select * from t1 natural left join t2 natural left join t3;
select * from t1 left join t2 on (t1.i=t2.i) left join t3 on (t2.i=t3.i);
select * from t3 natural right join t2;
select * from t3 right join t2 on (t3.i=t2.i);
select * from t3 natural right join t2 natural right join t1;
select * from t3 right join t2 on (t3.i=t2.i) right join t1 on (t2.i=t1.i);
select * from t1,t2 natural left join t3 order by t1.i,t2.i,t3.i;
select * from t1,t2 left join t3 on (t2.i=t3.i) order by t1.i,t2.i,t3.i;
select t1.i,t2.i,t3.i from t2 natural left join t3,t1 order by t1.i,t2.i,t3.i;
select t1.i,t2.i,t3.i from t2 left join t3 on (t2.i=t3.i),t1 order by t1.i,t2.i,t3.i;
select * from t1,t2 natural right join t3 order by t1.i,t2.i,t3.i;
select * from t1,t2 right join t3 on (t2.i=t3.i) order by t1.i,t2.i,t3.i;
select t1.i,t2.i,t3.i from t2 natural right join t3,t1 order by t1.i,t2.i,t3.i;
select t1.i,t2.i,t3.i from t2 right join t3 on (t2.i=t3.i),t1 order by t1.i,t2.i,t3.i;
drop table t1,t2,t3;
CREATE TABLE t1 (a int, b int default 0, c int default 1);
INSERT INTO t1 (a) VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO t1 (a) SELECT a + 8 FROM t1;
INSERT INTO t1 (a) SELECT a + 16 FROM t1;
CREATE TABLE t2 (a int, d int, e int default 0);
INSERT INTO t2 (a, d) VALUES (1,1),(2,2),(3,3),(4,4);
INSERT INTO t2 (a, d) SELECT a+4, a+4 FROM t2;
INSERT INTO t2 (a, d) SELECT a+8, a+8 FROM t2;
SELECT STRAIGHT_JOIN t2.e FROM t1,t2 WHERE t2.d=1 AND t1.b=t2.e
  ORDER BY t1.b, t1.c;
SELECT STRAIGHT_JOIN t2.e FROM t1,t2 WHERE t2.d=1 AND t1.b=t2.e
  ORDER BY t1.b, t1.c;
DROP TABLE t1,t2;
create table t1 (c int, b int);
create table t2 (a int, b int);
create table t3 (b int, c int);
create table t4 (y int, c int);
create table t5 (y int, z int);
create table t6 (a int, c int);
insert into t1 values (10,1);
insert into t1 values (3 ,1);
insert into t1 values (3 ,2);
insert into t2 values (2, 1);
insert into t3 values (1, 3);
insert into t3 values (1,10);
insert into t4 values (11,3);
insert into t4 values (2, 3);
insert into t5 values (11,4);
insert into t6 values (2, 3);
create algorithm=merge view v1a as
select * from t1 natural join t2;
create algorithm=merge view v1b(a,b,c) as
select * from t1 natural join t2;
create algorithm=merge view v1c as
select b as a, c as b, a as c from t1 natural join t2;
create algorithm=merge view v1d(b, a, c) as
select a as c, c as b, b as a from t1 natural join t2;
create algorithm=merge view v2a as
select t1.c, t1.b, t2.a from t1 join (t2 join t4 on b + 1 = y) on t1.c = t4.c;
create algorithm=merge view v2b as
select t1.c as b, t1.b as a, t2.a as c
from t1 join (t2 join t4 on b + 1 = y) on t1.c = t4.c;
create algorithm=merge view v3a as
select * from t1 natural join t2 natural join t3;
create algorithm=merge view v3b as
select * from t1 natural join (t2 natural join t3);
create algorithm=merge view v4 as
select * from v2a natural join v3a;
select * from (t1 natural join t2) natural join (t3 natural join t4);
select * from (t1 natural join t2) natural left join (t3 natural join t4);
select * from (t3 natural join t4) natural right join (t1 natural join t2);
select * from (t1 natural left join t2) natural left join (t3 natural left join t4);
select * from (t4 natural right join t3) natural right join (t2 natural right join t1);
select * from t1 natural join t2 natural join t3 natural join t4;
select * from ((t1 natural join t2) natural join t3) natural join t4;
select * from t1 natural join (t2 natural join (t3 natural join t4));
select * from t5 natural right join (t4 natural right join ((t2 natural right join t1) natural right join t3));
select * from (t1 natural join t2), (t3 natural join t4);
select * from t5 natural join ((t1 natural join t2), (t3 natural join t4));
select * from  ((t1 natural join t2),  (t3 natural join t4)) natural join t5;
select * from t5 natural join ((t1 natural join t2) cross join (t3 natural join t4));
select * from  ((t1 natural join t2) cross join (t3 natural join t4)) natural join t5;
select * from (t1 join t2 using (b)) join (t3 join t4 using (c)) using (c);
select * from (t1 join t2 using (b)) natural join (t3 join t4 using (c));
select a,b,c from (t1 natural join t2) natural join (t3 natural join t4)
where b + 1 = y or b + 10 = y group by b,c,a having min(b) < max(y) order by a;
select * from (t1 natural join t2) natural left join (t3 natural join t4)
where b + 1 = y or b + 10 = y group by b,c,a,y having min(b) < max(y) order by a, y;
select * from (t3 natural join t4) natural right join (t1 natural join t2)
where b + 1 = y or b + 10 = y group by b,c,a,y having min(b) < max(y) order by a, y;
select * from t1 natural join t2 where t1.c > t2.a;
select * from t1 natural join t2 where t1.b > t2.b;
select * from t1 natural left join (t4 natural join t5) where t5.z is not NULL;
select * from t1 join (t2 join t4 on b + 1 = y) on t1.c = t4.c;
select * from (t2 join t4 on b + 1 = y) join t1 on t1.c = t4.c;
select * from t1 natural join (t2 join t4 on b + 1 = y);
select * from (t1 cross join t2) join (t3 cross join t4) on (a < y and t2.b < t3.c);
select * from (t1, t2) join (t3, t4) on (a < y and t2.b < t3.c);
select * from (t1 natural join t2) join (t3 natural join t4) on a = y;
select * from ((t3 join (t1 join t2 on c > a) on t3.b < t2.a) join t4 on y > t1.c) join t5 on z = t1.b + 3;
select * from t1 natural join t2 where t1.b > 0;
select * from t1 natural join (t4 natural join t5) where t4.y > 7;
select * from (t4 natural join t5) natural join t1 where t4.y > 7;
select * from t1 natural left join (t4 natural join t5) where t4.y > 7;
select * from (t4 natural join t5) natural right join t1 where t4.y > 7;
select * from (t1 natural join t2) join (t3 natural join t4) on t1.b = t3.b;
select t1.*, t2.* from t1 natural join t2;
select t1.*, t2.*, t3.*, t4.* from (t1 natural join t2) natural join (t3 natural join t4);
select * from (select * from t1 natural join t2) as t12
              natural join
              (select * from t3 natural join t4) as t34;
select * from (select * from t1 natural join t2) as t12
              natural left join
              (select * from t3 natural join t4) as t34;
select * from (select * from t3 natural join t4) as t34
              natural right join
              (select * from t1 natural join t2) as t12;
select * from v1a;
select * from v1b;
select * from v1c;
select * from v1d;
select * from v2a;
select * from v2b;
select * from v3a;
select * from v3b;
select * from v4;
select * from v1a natural join v2a;
select v2a.* from v1a natural join v2a;
select * from v1b join v2a on v1b.b = v2a.c;
select * from v1c join v2a on v1c.b = v2a.c;
select * from v1d join v2a on v1d.a = v2a.c;
select * from v1a join (t3 natural join t4) on a = y;
select 
 statistics.TABLE_NAME, statistics.COLUMN_NAME, statistics.TABLE_CATALOG, statistics.TABLE_SCHEMA, statistics.NON_UNIQUE, statistics.INDEX_SCHEMA, statistics.INDEX_NAME, statistics.SEQ_IN_INDEX, statistics.COLLATION, statistics.SUB_PART, statistics.PACKED, statistics.NULLABLE, statistics.INDEX_TYPE, statistics.COMMENT, 
 columns.TABLE_CATALOG, columns.TABLE_SCHEMA, columns.COLUMN_DEFAULT, columns.IS_NULLABLE, columns.DATA_TYPE, columns.CHARACTER_MAXIMUM_LENGTH, columns.CHARACTER_OCTET_LENGTH, columns.NUMERIC_PRECISION, columns.NUMERIC_SCALE, columns.CHARACTER_SET_NAME, columns.COLLATION_NAME, columns.COLUMN_TYPE, columns.COLUMN_KEY, columns.EXTRA, columns.PRIVILEGES, columns.COLUMN_COMMENT
 from information_schema.statistics join information_schema.columns using(table_name,column_name) where table_name='user';
drop table t1;
drop table t2;
drop table t3;
drop table t4;
drop table t5;
drop table t6;
drop view v1a;
drop view v1b;
drop view v1c;
drop view v1d;
drop view v2a;
drop view v2b;
drop view v3a;
drop view v3b;
drop view v4;
create table t1 (a1 int, a2 int);
create table t2 (a1 int, b int);
create table t3 (c1 int, c2 int);
create table t4 (c2 int);
insert into t1 values (1,1);
insert into t2 values (1,1);
insert into t3 values (1,1);
insert into t4 values (1);
select * from t1 join t2 using (a1) join t3 on b=c1 join t4 using (c2);
select * from t3 join (t1 join t2 using (a1)) on b=c1 join t4 using (c2);
select a2 from t1 join t2 using (a1) join t3 on b=c1 join t4 using (c2);
select a2 from t3 join (t1 join t2 using (a1)) on b=c1 join t4 using (c2);
select a2 from ((t1 join t2 using (a1)) join t3 on b=c1) join t4 using (c2);
select a2 from ((t1 natural join t2) join t3 on b=c1) natural join t4;
drop table t1,t2,t3,t4;
create table t1 (c int, b int);
create table t2 (a int, b int);
create table t3 (b int, c int);
create table t4 (y int, c int);
create table t5 (y int, z int);
insert into t1 values (3,2);
insert into t2 values (1,2);
insert into t3 values (2,3);
insert into t4 values (1,3);
insert into t5 values (1,4);
prepare stmt1 from "select * from ((t3 natural join (t1 natural join t2))
natural join t4) natural join t5";
select * from ((t3 natural join (t1 natural join t2)) natural join t4)
  natural join t5;
drop table t1, t2, t3, t4, t5;
CREATE TABLE t1 (ID INTEGER, Name VARCHAR(50));
CREATE TABLE t2 (Test_ID INTEGER);
CREATE VIEW v1 (Test_ID, Description) AS SELECT ID, Name FROM t1;
CREATE TABLE tv1 SELECT Description AS Name FROM v1 JOIN t2
 USING (Test_ID);
CREATE TABLE tv2 SELECT Description AS Name FROM v1 JOIN t2
 ON v1.Test_ID = t2.Test_ID;
DROP VIEW v1;
DROP TABLE t1,t2,tv1,tv2;
create table t1 (a int, b int);
insert into t1 values 
  (NULL, 1),
  (NULL, 2),
  (NULL, 3),
  (NULL, 4);
create table t2 (a int not null, primary key(a));
insert into t2 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t3 (a int not null, primary key(a));
insert into t3 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
select * from t1, t2, t3 where t3.a=t1.a and t2.a=t1.b;
drop table t1, t2, t3;
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2 (a int, b int, filler char(100), key(a), key(b));
create table t3 (a int, b int, filler char(100), key(a), key(b));
insert into t2 
  select @a:= A.a + 10*(B.a + 10*C.a), @a, 'filler' from t1 A, t1 B, t1 C;
insert into t3 select * from t2 where a < 800;
drop table t1, t2, t3;
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2 (a int, b int, primary key(a));
insert into t2 select @v:=A.a+10*B.a, @v  from t1 A, t1 B;
select 'The cost of accessing t1 (dont care if it changes' '^';
select 'vv: Following query must use ALL(t1), eq_ref(A), eq_ref(B): vv' Z;
select '^^: The above should be ~= 8 + cost(select * from t1). Value less than 8 is an error' Z;
drop table t1, t2;
CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
CREATE TABLE t2 (c INT PRIMARY KEY, d INT);
INSERT INTO t1 VALUES(1,NULL),(2,NULL),(3,NULL),(4,NULL);
INSERT INTO t1 SELECT a + 4, b FROM t1;
INSERT INTO t1 SELECT a + 8, b FROM t1;
INSERT INTO t1 SELECT a + 16, b FROM t1;
INSERT INTO t1 SELECT a + 32, b FROM t1;
INSERT INTO t1 SELECT a + 64, b FROM t1;
INSERT INTO t2 SELECT a, b FROM t1;
SELECT * FROM t1 JOIN t2 ON b=c ORDER BY a LIMIT 2;
SELECT * FROM t1 JOIN t2 ON a=c ORDER BY a LIMIT 2;
SELECT * FROM t1 JOIN t2 ON b=c ORDER BY a;
SELECT * FROM t1 JOIN t2 ON a=c ORDER BY a;
DROP TABLE IF EXISTS t1,t2;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
CREATE TABLE t3 (a INT, INDEX (a));
CREATE TABLE t4 (a INT);
CREATE TABLE t5 (a INT);
CREATE TABLE t6 (a INT);
INSERT INTO t1 VALUES (1), (1), (1);
INSERT INTO t2 VALUES
(2), (2), (2), (2), (2), (2), (2), (2), (2), (2);
INSERT INTO t3 VALUES
(3), (3), (3), (3), (3), (3), (3), (3), (3), (3);
SELECT * 
FROM 
  t1 JOIN t2 ON t1.a = t2.a 
  LEFT JOIN 
  (
   (
    t3 LEFT JOIN t4 ON t3.a = t4.a
   ) 
   LEFT JOIN 
   (
     t5 LEFT JOIN t6 ON t5.a = t6.a
   ) 
   ON t4.a = t5.a
  ) 
  ON t1.a = t3.a;
SELECT * 
FROM 
  t1 JOIN t2 ON t1.a = t2.a 
  LEFT JOIN 
  (
   (
    t3 LEFT JOIN t4 ON t3.a = t4.a
   ) 
   LEFT JOIN 
   (
     t5 LEFT JOIN t6 ON t5.a = t6.a
   ) 
   ON t4.a = t5.a
  ) 
  ON t1.a = t3.a;
DROP TABLE t1,t2,t3,t4,t5,t6;
CREATE TABLE t1(f1 INT);
INSERT INTO t1 VALUES (1),(2);
CREATE VIEW v1 AS SELECT 1 FROM t1 LEFT JOIN t1 AS t2 on 1=1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a TINYINT, b TEXT, KEY (a));
INSERT INTO t1 VALUES (0,''),(0,'');
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL, PRIMARY KEY (a,b));
INSERT INTO t1 VALUES (0,0), (1,1);
SELECT * FROM t1 STRAIGHT_JOIN t1 t2 ON t1.a=t2.a AND t1.a=t2.b ORDER BY t2.a, t1.a;
DROP TABLE t1;
CREATE TABLE t1 (f1 int);
CREATE TABLE t2 (f1 int);
INSERT INTO t2  VALUES (1);
CREATE VIEW v1 AS SELECT * FROM t2;
PREPARE stmt FROM 'UPDATE t2 AS A NATURAL JOIN v1 B SET B.f1 = 1';
DEALLOCATE PREPARE stmt;
DROP VIEW v1;
DROP TABLE t1, t2;
CREATE TABLE t1(a CHAR(9),b INT,KEY(b),KEY(a)) ENGINE=MYISAM;
CREATE TABLE t2(a CHAR(9),b INT,KEY(b),KEY(a)) ENGINE=MYISAM;
INSERT INTO t1 VALUES ('1',null),(null,null);
INSERT INTO t2 VALUES ('1',null),(null,null);
CREATE TABLE mm1(a CHAR(9),b INT,KEY(b),KEY(a))
ENGINE=MERGE  UNION=(t1,t2);
SELECT t1.a FROM mm1,t1;
DROP TABLE t1, t2, mm1;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (), ();
SELECT 1 FROM t1
GROUP BY
GREATEST(t1.a,
         (SELECT 1 FROM
          (SELECT t1.b FROM t1,t1 t2
           ORDER BY t1.a, t1.a LIMIT 1) AS d)
        );
DROP TABLE t1;
CREATE TABLE t1(c INT);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
CREATE TABLE t1 (
  c1 INTEGER NOT NULL
);
INSERT INTO t1 VALUES (1),(2),(3);
CREATE TABLE t2 (
  pk INTEGER NOT NULL,
  c1 INTEGER NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES (1,4),(3,5),(2,6);
SELECT t2.pk, t2.c1 FROM t2, t1 
WHERE t2.pk = t1.c1 AND t2.pk >= 2;
CREATE VIEW v_t2 AS SELECT * FROM t2;
SELECT v_t2.pk, v_t2.c1 FROM v_t2, t1 
WHERE v_t2.pk = t1.c1 AND v_t2.pk >= 2;
DROP VIEW v_t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (  
  pk INTEGER NOT NULL,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (7,8,1), (8,2,2);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT t1.pk
FROM v1, t1
WHERE (v1.i2 = 211 AND v1.i2 > 7)
   OR (t1.i1 < 3 AND v1.i2 < 10);
DROP VIEW v1;
DROP TABLE t1;
create table t1(c1 int primary key, c2 char(10)) engine=myisam;
create table t2(c1 int primary key, c2 char(10), ref_t1 int) engine=myisam;
create table t3(c1 int primary key, c2 char(10), ref_t1 int) engine=myisam;
create table t4(c1 int primary key, c2 char(10), ref_t1 int) engine=myisam;
insert into t1 values(1,'a');
insert into t2 values(1,'a', 1);
insert into t3 values(1,'a', 1);
insert into t3 values(2,'b',2);
insert into t4 values(1,'a', 1);
insert into t4 values(2,'a', 2);
insert into t4 values(3,'a', 3);
insert into t4 values(4,'a', 4);
insert into t1 values(2,'b');
insert into t1 values(3,'c');
drop table t1,t2,t3,t4;
CREATE TABLE t1(a INTEGER) engine=innodb;
SELECT 1
FROM (SELECT 1 FROM t1 WHERE a) AS q
     NATURAL LEFT JOIN t1
     NATURAL LEFT JOIN t1 AS t2;
SELECT 1
FROM t1
     NATURAL RIGHT JOIN t1 AS t2
     NATURAL RIGHT JOIN (SELECT 1 FROM t1 WHERE a) AS q;
DROP TABLE t1;
CREATE TABLE t1
(pk INTEGER,
 dummy VARCHAR(64),
 col_check TINYINT,
 PRIMARY KEY(pk)
) engine=innodb;
INSERT INTO t1 VALUES (13, '13', 13);
CREATE VIEW v1 AS
SELECT *
FROM t1
WHERE pk BETWEEN 13 AND 14;
PREPARE st1 FROM "
UPDATE v1 AS a NATURAL JOIN v1 AS b
SET a.dummy = '', b.col_check = NULL ";
DEALLOCATE PREPARE st1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1
(pk INT,
 col_int_key INT DEFAULT NULL,
 col_varchar_10_latin1_key VARCHAR(10) DEFAULT NULL,
 col_varchar_255_utf8 VARCHAR(255) CHARACTER SET utf8mb3 DEFAULT NULL,
 col_int INT DEFAULT NULL,
 col_datetime_key datetime DEFAULT NULL,
 col_varchar_255_latin1_key VARCHAR(255) DEFAULT NULL,
 col_date_key date DEFAULT NULL,
 col_datetime datetime DEFAULT NULL,
 PRIMARY KEY (pk),
 KEY col_date_key (col_date_key)
) charset latin1 ENGINE=MyISAM;
INSERT INTO t1 VALUES
(8,9,'h','FDUMQ',-1356726272,'2007-09-02 05:48:23','she','2002-04-02','2002-12-20 17:54:07');
CREATE TABLE t2
(pk INT,
 col_int INT DEFAULT NULL,
 col_int_key INT DEFAULT NULL,
 PRIMARY KEY (pk)
) charset latin1 ENGINE=MyISAM;
CREATE TABLE t3
(col_int INT DEFAULT NULL,
 col_int_key INT DEFAULT NULL,
 pk INT,
 PRIMARY KEY (pk),
 KEY test_idx (col_int_key,pk,col_int)
) charset latin1 ENGINE=InnoDB;
INSERT INTO t3 VALUES
 (NULL,9, 41), (NULL,-1596719104, 48), (-1068105728,9, 49);
CREATE TABLE t4
(col_varchar_255_latin1_key VARCHAR(255) DEFAULT NULL,
 pk INT,
 PRIMARY KEY (pk)
) charset latin1 ENGINE=MyISAM;
INSERT INTO t4 VALUES ('RUXDY',8);
SELECT alias1.pk AS field5
FROM t3 AS alias1
     LEFT JOIN t4 AS alias2
       LEFT JOIN t4 AS alias3
         LEFT JOIN t1 AS alias4
           LEFT JOIN t2 AS alias5
           ON alias4.pk = alias5.col_int_key
         ON alias3.pk = alias5.col_int
       ON alias2.col_varchar_255_latin1_key = alias4.col_varchar_10_latin1_key
       RIGHT JOIN t1 AS alias6
       ON alias4.pk = alias6.pk
       RIGHT JOIN t4 AS alias7
       ON alias6.pk = alias7.pk
     ON alias1.col_int_key = alias6.col_int_key
WHERE alias1.col_int > 5 OR
      alias5.col_int > 5;
DROP TABLE t1, t2, t3, t4;
create table parent(a int primary key, b int, c int, d int) engine=innodb;
create table eq_child(a int, b int, c int, d int, primary key(a,b)) engine=innodb;
insert into parent values (1,1,1,1);
insert into eq_child select * from parent;
drop table parent, eq_child;
CREATE TABLE t (i INTEGER PRIMARY KEY AUTO_INCREMENT, j INTEGER, KEY(j)) ENGINE=InnoDB;
INSERT INTO t VALUES (NULL, NULL);
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
INSERT INTO t SELECT NULL, NULL FROM t;
SELECT t1.i AS a, (SELECT t2.i FROM t t2 WHERE t1.j = t2.j ORDER BY j DESC, i DESC LIMIT 1) AS b FROM t t1;
DROP TABLE t;
create table t(a int, b int);
insert into t values(1,10),(2,20);
select t1.*, (select count(*)
               from t t2
               left join t t3 on t3.a>t2.a-t1.a)
 from t t1;
select t1.a, (select count(*)
               from t t2
               left join t t3 on t3.a>t2.a-t1.a)
 from t t1
 group by t1.a;
create view v1 as select * from t;
select v1.*, (select count(*)
               from t t2
               left join t t3 on t3.a>t2.a-v1.a)
 from v1;
drop view v1;
select t1.*, (select * from
                (select count(*)
                 from t t2
                 left join t t3 on t3.a>t2.a-t1.a) as dt)
 from t t1;
select t1.*, dt.c
 from t t1,
 lateral
 (select count(*) as c
  from t t2
  left join t t3 on t3.a>t2.a-t1.a) as dt;
select t1.*, dt.c
 from t t1 cross join
 lateral
 (select count(*) as c
  from t t2
  left join t t3 on t3.a>t2.a-t1.a) as dt;
select t1.*, dt.c
 from t t1 join
 lateral
 (select count(*) as c
  from t t2
  left join t t3 on t3.a>t2.a-t1.a) as dt
 on true;
select t1.* from t t0 cross join t t1 join t t2
                                      on 100=(select count(*)
                                              from t t3
                                                   left join t t4
                                                   on t4.a>t3.a-t0.a);
drop table t;
create table t(a int);
insert into t values(1),(2);
select * from t t1
 where t1.a in (select dt.a
                from t t2
                left join (select * from t t3 where t3.a>t1.a) dt
                on true);
drop table t;
CREATE TABLE t1 (
  a INTEGER
);
CREATE TABLE t2 (
  pk INTEGER NOT NULL,
  a INTEGER
);
SELECT * FROM
  (
    t2 LEFT JOIN t2 AS t3 ON t2.pk IS NULL
  ) LEFT JOIN t1 ON t1.a = t3.a;
DROP TABLE t1, t2;
CREATE TABLE t1 ( pk INTEGER );
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 ( pk INTEGER );
SELECT * FROM t1 LEFT JOIN t2 ON TRUE WHERE t2.pk <=> 3;
DROP TABLE t1, t2;
CREATE TABLE A ( pk INTEGER );
SELECT t1.pk FROM A t1, A t2, A t3, A t4, A t5 GROUP BY t1.pk;
DROP TABLE A;
CREATE TABLE t (
  a BIT(50),
  b VARCHAR(22772) character set ucs2,
  c INTEGER,
  d TINYBLOB,
  PRIMARY KEY (a),
  KEY i0001 (c,d(163))
);
INSERT INTO t VALUES (1,'',1,'1');
INSERT INTO t VALUES (0x03ffffffffffff,'2',0,'2');
DROP TABLE t;
CREATE TABLE t1 (
 ts datetime,
 x integer,
 y integer
);
INSERT INTO t1 VALUES ('2020-11-20 10:38:31',1,2);
CREATE TABLE t2 (
 x integer,
 ts datetime,
 KEY i1 (x)
);
INSERT INTO t2 VALUES (1,'2020-11-16 14:18:55');
CREATE TABLE t3 (
 ts datetime,
 y integer,
 z INTEGER,
 KEY i2 (y,ts)
);
INSERT INTO t3 VALUES ('2020-12-29 18:23:02',2,100);
CREATE TABLE t4 (
  z INTEGER
);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 ( a INTEGER );
INSERT INTO t1 VALUES (0), (0), (0), (1), (1), (0), (1), (0);
SELECT * FROM
  t1, t1 AS t2, t1 AS t3
  WHERE ((t1.a = 5 AND t3.a < t1.a) OR t1.a > 0) AND t3.a <= t2.a;
DROP TABLE t1;
CREATE TABLE t1 ( a VARCHAR(10) );
CREATE TABLE t2 ( a VARCHAR(10) );
INSERT INTO t1 VALUES ('x');
SELECT *
  FROM t1
  LEFT JOIN t2 ON TRUE
  LEFT JOIN ( t1 AS t1i JOIN t2 AS t2i ON t1i.a = t2i.a ) ON t2.a = t2i.a
  WHERE t1i.a = '' OR t2i.a = '';
DROP TABLE t1, t2;
CREATE TABLE t1 (
  a INTEGER NOT NULL,
  KEY (a)
);
INSERT INTO t1 VALUES (1), (2);
SELECT *
FROM t1 LEFT JOIN t1 AS t2 ON TRUE
WHERE t1.a IS NULL OR t1.a = t2.a
ORDER BY t2.a;
SELECT t1.a
FROM t1 LEFT JOIN t1 AS t2 ON t1.a = t2.a
WHERE t1.a IS NULL OR t1.a = t2.a
GROUP BY t1.a;
DROP TABLE t1;
CREATE TABLE t1 (c1 INTEGER, c2 INTEGER, c3 INTEGER, c4 INTEGER, c5 INTEGER, c6 INTEGER, c7 INTEGER, c8 INTEGER, c9 INTEGER, c10 INTEGER, c11 INTEGER, c12 INTEGER, c13 INTEGER, c14 INTEGER, c15 INTEGER, c16 INTEGER, c17 INTEGER, c18 INTEGER, c19 INTEGER, c20 INTEGER, c21 INTEGER, c22 INTEGER, c23 INTEGER, c24 INTEGER, c25 INTEGER, c26 INTEGER, c27 INTEGER, c28 INTEGER, c29 INTEGER, c30 INTEGER, c31 INTEGER, c32 INTEGER, c33 INTEGER, c34 INTEGER, c35 INTEGER, c36 INTEGER, c37 INTEGER, c38 INTEGER, c39 INTEGER, c40 INTEGER, c41 INTEGER, c42 INTEGER, c43 INTEGER, c44 INTEGER, c45 INTEGER, c46 INTEGER, c47 INTEGER, c48 INTEGER, c49 INTEGER, c50 INTEGER, c51 INTEGER, c52 INTEGER, c53 INTEGER, c54 INTEGER, c55 INTEGER, c56 INTEGER, c57 INTEGER, c58 INTEGER, c59 INTEGER, c60 INTEGER, c61 INTEGER);
SELECT *
FROM t1
NATURAL JOIN (
  SELECT t2.*
  FROM t1 AS t2 JOIN t1 AS t3 ON t3.c1 = t2.c1
  WHERE t2.c3 <> ANY (SELECT c3 FROM t1)
) AS d1;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
SELECT *
FROM t1 AS outer_t1
WHERE EXISTS (
  SELECT t2.a
  FROM t1
  LEFT JOIN t1 AS t2 ON t2.a = outer_t1.a
);
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
SELECT *
FROM (t1 STRAIGHT_JOIN t1 AS t2) JOIN t1 AS t3 ON t1.a = t3.a
WHERE t2.a = t3.a
ORDER BY t1.a;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER, b INTEGER);
SELECT *
FROM (t1 STRAIGHT_JOIN t1 AS t2 ON t1.b = t2.b) JOIN t1 AS t3 ON t1.a = t3.b
WHERE t1.a < t2.b AND t2.a < t3.b
ORDER BY t1.b;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
SELECT *
FROM t1
LEFT JOIN t1 AS t2 ON t1.a = t2.a
LEFT JOIN t1 AS t3 ON t2.a = t3.a
WHERE t2.a = t3.a OR t2.a <> t2.a;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (1,2);
SELECT * FROM t1, t1 AS t2, t1 AS t3 WHERE t1.a = t2.a AND t1.a = t3.b AND t1.a = t3.a;
DROP TABLE t1;
CREATE TABLE t1 ( pk INTEGER );
SELECT * FROM
  t1
  JOIN t1 AS t2 ON t1.pk = t2.pk
  JOIN t1 AS t3
  LEFT JOIN t1 AS t4 ON t2.pk = t3.pk AND t4.pk = 135;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
SELECT *
  FROM
    t1
    JOIN t1 AS t2 ON t1.a = t2.b
    LEFT JOIN t1 AS t3 ON t2.b = t3.b
    LEFT JOIN (
      t1 AS t4
      JOIN t1 AS t5 ON t4.b = t5.b
    ) ON t2.b = t4.a
  WHERE t1.b >= 6 OR t3.b <> t4.b;
DROP TABLE t1;
CREATE TABLE t1(a INT NOT NULL, b INT, PRIMARY KEY(a));
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
DROP TABLE t1;
CREATE TABLE t1 (
  a VARCHAR(1),
  b INTEGER
);
SELECT *
FROM
  t1
  JOIN t1 AS t2 ON t1.b = t2.b
  JOIN t1 AS t3
  JOIN (
    t1 AS t4 STRAIGHT_JOIN t1 AS t5 ON t4.a = t5.b
  ) ON t1.b = t4.b
WHERE t1.a = t5.b;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1), (2), (3), (4);
SELECT *
  FROM
    t1
    LEFT JOIN (
      t1 AS t2
      LEFT JOIN t1 AS t3 ON FALSE
    ) ON t1.a <=> t3.a
  WHERE t1.a <=> t3.a;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(x INT);
INSERT INTO t2 VALUES(2),(3);
DROP TABLE t1,t2;
CREATE TABLE t1(
 k INTEGER PRIMARY KEY,
 t2ref INTEGER
);
INSERT INTO t1 VALUES(1,1), (2,NULL), (3,3);
CREATE TABLE t2(
 k INTEGER PRIMARY KEY,
 d INTEGER,
 t3ref INTEGER NOT NULL
);
INSERT INTO t2 VALUES(1,11,1), (3,33,3);
CREATE TABLE t3(
 k INTEGER UNIQUE,
 e INTEGER
);
INSERT INTO t3 VALUES(1,111), (3,333);
SELECT t1.k, dt.d, t3.e
FROM t1
     LEFT JOIN (SELECT t2.*
                FROM t2
               ) AS dt
     ON t1.t2ref = dt.k
     LEFT JOIN t3
     ON dt.t3ref = t3.k;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INTEGER );
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
SELECT * FROM
  t1
  STRAIGHT_JOIN t1 AS t2 ON t1.b = t2.b
  JOIN (t1 AS t3 JOIN t1 AS t4 ON t3.a = t4.a AND t3.b = t4.b) ON t2.b = t3.b AND t2.a < t3.a
ORDER BY t2.b;
DROP TABLE t1;
CREATE TABLE t1 ( i INTEGER );
INSERT INTO t1 VALUES (1), (2);
SELECT * FROM
  t1 LEFT JOIN (SELECT i FROM t1 WHERE FALSE) AS d1 ON t1.i = d1.i
WHERE NOT EXISTS (SELECT 1 FROM t1 AS inner_t1 WHERE i = d1.i);
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER, c INTEGER, d INTEGER, e INTEGER, f INTEGER, g INTEGER, h INTEGER, i INTEGER, j INTEGER, k INTEGER, l INTEGER, m INTEGER, n INTEGER, o INTEGER, p INTEGER, q INTEGER, r INTEGER, s INTEGER, t INTEGER, u INTEGER, v INTEGER, w INTEGER, KEY (a) );
SELECT 1
FROM t1 NATURAL JOIN t1 AS t2 NATURAL JOIN t1 AS t3
WHERE
  t1.a <> ( SELECT SUM(a) FROM t1 );
DROP TABLE t1;
CREATE TABLE t1 (
  f1 INTEGER
);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TABLE t2 (
  pk INTEGER,
  blobfield LONGTEXT
);
INSERT INTO t2 VALUES (4, '');
SELECT *
FROM t1, t2, LATERAL (
  SELECT pk, blobfield
  GROUP BY pk, blobfield WITH ROLLUP
) AS d1
ORDER BY t1.f1, t2.pk;
DROP TABLE t1, t2;
CREATE TABLE t ( a INTEGER, b INTEGER );
SELECT *
FROM
  t AS t1
  JOIN (
    t AS t2
    LEFT JOIN t AS t3 ON t2.a = t3.a AND t2.b = t3.b
    JOIN t AS t4 ON t2.b = t4.a AND t2.b = t4.b
  ) ON t1.b = t2.b;
DROP TABLE t;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (3, 2);
CREATE TABLE t2 ( a INTEGER, b INTEGER, KEY (a) );
INSERT INTO t2 VALUES (3, 0);
INSERT INTO t2 VALUES (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0), (4, 0);
CREATE TABLE t3 ( a INTEGER, b INTEGER, c INTEGER );
INSERT INTO t3 VALUES (1, 0, 2);
SELECT
  t2.b, t3.a, t3.b
FROM t1
  JOIN t2 ON t1.a = t2.a
  JOIN t3 ON t1.b = t3.c AND t2.b = t3.a
WHERE t2.b = t3.b;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INTEGER );
SELECT
  1
  FROM
    t1
    JOIN t1 AS t2
    LEFT JOIN (
      t1 AS t3
      JOIN ( SELECT * FROM t1 WHERE FALSE ) AS empty_subq
    ) ON empty_subq.a = t3.a
  WHERE NOT EXISTS (SELECT 9) OR empty_subq.a = t2.a;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER, KEY (b) );
INSERT INTO t1 VALUES (1,1), (2,2);
SELECT 1
FROM
  t1
  JOIN (t1 AS t2 LEFT JOIN t1 AS t3 ON t2.b = t3.b) ON (t2.b = t3.b OR t1.a = 125)
WHERE
  t1.a = 143;
DROP TABLE t1;
CREATE TABLE t1 (i SMALLINT, INDEX a (i));
CREATE TABLE t2 (i SMALLINT UNSIGNED);
INSERT INTO t1 VALUES (-32768), (32767);
INSERT INTO t2 VALUES (65535);
SELECT * FROM t1 JOIN t2 ON t2.i > t1.i;
DROP TABLE t1, t2;
CREATE TABLE t1 ( a INTEGER );
CREATE TABLE t2 ( a INTEGER, b INTEGER, c INTEGER );
CREATE TABLE t3 ( a INTEGER );
CREATE TABLE t4 ( a INTEGER, b INTEGER, c INTEGER );
SELECT
  1
FROM
  t1
  JOIN t2 ON t1.a = t2.a
  JOIN t3 ON t2.a = t3.a
  JOIN t4 ON t3.a = t4.a AND t2.b = t4.b AND t2.c = t4.c;
DROP TABLE t1,t2,t3,t4;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  a INTEGER,
  INDEX (pk)
);
SELECT
  1
FROM
  t1
  LEFT JOIN t1 AS t2 ON t1.a = t2.a
  JOIN t1 AS t3 ON t2.a = t3.a
WHERE
  t2.a < t2.a OR t2.pk IS NULL
GROUP BY t2.a;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
INSERT INTO t1 VALUES (5);
CREATE TABLE t2 ( a INTEGER, b INTEGER );
INSERT INTO t2 VALUES (6, 1);
CREATE TABLE t3 ( a INTEGER, b INTEGER );
INSERT INTO t3 VALUES (2, 1);
SELECT t1.a AS field1, t2.a AS field2
FROM
  t1
  JOIN t2 ON t1.a = t2.a
  WHERE t2.b IN (
    SELECT inner_a1.b
    FROM t3 AS inner_a1 JOIN t3 AS inner_a2 ON inner_a1.b = inner_a2.b
    WHERE inner_a1.a = t2.a
  );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (a INTEGER);
INSERT INTO t2 VALUES (1);
CREATE TABLE t3 (a INTEGER);
INSERT INTO t3 VALUES (1);
CREATE TABLE t4 (a INTEGER);
INSERT INTO t4 VALUES (2);
SELECT * FROM t1 LEFT JOIN (t2 LEFT JOIN (t3 JOIN t4 ON t3.a = t4.a)
ON t4.a = t2.a) ON t1.a = t2.a;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (k INT, KEY(k)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 (pk INTEGER AUTO_INCREMENT, col_int INT, col_date DATE,
                 PRIMARY KEY (pk));
INSERT INTO t1 (pk, col_int, col_date) VALUES (1, NULL, '1997-04-21');
CREATE TABLE t2(pk INTEGER AUTO_INCREMENT, PRIMARY KEY (pk));
INSERT INTO t2 (pk) VALUES (1);
SELECT DISTINCT t1.col_int
FROM t2 LEFT OUTER JOIN t1 ON t2.pk = t1.col_int
WHERE CAST(t2.pk AS SIGNED INTEGER) <> t1.col_date;
DROP TABLE t1;
DROP TABLE t2;
