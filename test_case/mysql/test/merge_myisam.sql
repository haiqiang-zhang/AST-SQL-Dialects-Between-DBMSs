drop database if exists mysqltest;
create table t1 (a int not null primary key auto_increment, message char(20));
create table t2 (a int not null primary key auto_increment, message char(20));
INSERT INTO t1 (message) VALUES ("Testing"),("table"),("t1");
INSERT INTO t2 (message) VALUES ("Testing"),("table"),("t2");
create table t3 (a int not null, b char(20), key(a)) engine=MERGE UNION=(t1,t2);
drop table t3;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
create table t4 (a int not null, b char(10), key(a)) engine=MERGE UNION=(t1,t2);
create database mysqltest;
create table mysqltest.t6 (a int not null primary key auto_increment, message char(20));
drop database mysqltest;
create table t3 (c char(10)) union=(t1,t2) engine=merge;
select * from t1;
drop table t3,t2,t1;
CREATE TABLE t1 (incr int not null, othr int not null, primary key(incr));
CREATE TABLE t2 (incr int not null, othr int not null, primary key(incr));
CREATE TABLE t3 (incr int not null, othr int not null, primary key(incr))
ENGINE=MERGE UNION=(t1,t2);
INSERT INTO t1 VALUES ( 1,10),( 3,53),( 5,21),( 7,12),( 9,17);
INSERT INTO t2 VALUES ( 2,24),( 4,33),( 6,41),( 8,26),( 0,32);
INSERT INTO t1 VALUES (11,20),(13,43),(15,11),(17,22),(19,37);
INSERT INTO t2 VALUES (12,25),(14,31),(16,42),(18,27),(10,30);
drop table t3;
CREATE TABLE t3 (incr int not null, othr int not null, primary key(incr))
ENGINE=MERGE UNION=(t1,t2);
drop table t3,t2,t1;
create table t1 (a int not null, key(a)) engine=merge;
select * from t1;
drop table t1;
create table t1 (a int not null, b int not null, key(a,b));
create table t2 (a int not null, b int not null, key(a,b));
create table t3 (a int not null, b int not null, key(a,b)) ENGINE=MERGE UNION=(t1,t2);
insert into t1 values (1,2),(2,1),(0,0),(4,4),(5,5),(6,6);
insert into t2 values (1,1),(2,2),(0,0),(4,4),(5,5),(6,6);
drop table t3,t1,t2;
create table t3 (a int not null, b int not null, key(a,b)) UNION=(t1,t2) INSERT_METHOD=NO;
create table t5 (a int not null, b int not null auto_increment, primary key(a,b)) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=FIRST;
create table t6 (a int not null, b int not null auto_increment, primary key(a,b)) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;
select * from t3 order by b,a limit 3;
insert into t3 values (3,1),(3,2),(3,3),(3,4);
select * from t3 order by a,b;
select * from t3 order by a,b;
select 1;
CREATE TABLE t1 (  a int(11) NOT NULL default '0',  b int(11) NOT NULL default '0',  PRIMARY KEY  (a,b)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1), (2,1);
CREATE TABLE t2 (  a int(11) NOT NULL default '0',  b int(11) NOT NULL default '0',  PRIMARY KEY  (a,b)) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,2), (2,2);
select max(b) from t3 where a = 2;
select max(b) from t1 where a = 2;
drop table t3,t1,t2;
CREATE TABLE t1 (c1 INT NOT NULL);
CREATE TABLE t2 (c1 INT NOT NULL);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE TEMPORARY TABLE t3 (c1 INT NOT NULL) ENGINE=MRG_MYISAM UNION=(t1,t2);
CREATE TEMPORARY TABLE t4 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t5 (c1 INT NOT NULL) ENGINE=MyISAM;
INSERT INTO t4 VALUES (4);
INSERT INTO t5 VALUES (5);
CREATE TEMPORARY TABLE t6 (c1 INT NOT NULL) ENGINE=MRG_MYISAM UNION=(t4,t5);
SELECT * FROM t6;
DROP TABLE t6, t3, t1, t2, t4, t5;
create temporary table t1 (a int not null);
create temporary table t2 (a int not null);
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
drop table t3, t2, t1;
create table t1 (a int not null);
create temporary table t2 (a int not null) engine=myisam;
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
drop table t3;
create temporary table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
drop table t3, t2, t1;
CREATE TEMPORARY TABLE t1 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT NOT NULL);
INSERT INTO t3 VALUES (3), (33);
LOCK TABLES t3 READ;
UNLOCK TABLES;
CREATE TEMPORARY TABLE t4 (c1 INT NOT NULL) ENGINE=MERGE UNION=(t1,t2)
  INSERT_METHOD=LAST;
INSERT INTO t4 SELECT * FROM t3;
ALTER TABLE t4 UNION=(t1);
LOCK TABLES t4 WRITE;
ALTER TABLE t4 UNION=(t1,t2);
UNLOCK TABLES;
DROP TABLE t4, t3, t2, t1;
CREATE TABLE t1 (
  fileset_id tinyint(3) unsigned NOT NULL default '0',
  file_code varchar(32) NOT NULL default '',
  fileset_root_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (fileset_id,file_code),
  KEY files (fileset_id,fileset_root_id)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (2, '0000000111', 1), (2, '0000000112', 1), (2, '0000000113', 1),
(2, '0000000114', 1), (2, '0000000115', 1), (2, '0000000116', 1), (2, '0000000117', 1),
(2, '0000000118', 1), (2, '0000000119', 1), (2, '0000000120', 1);
CREATE TABLE t2 (
  fileset_id tinyint(3) unsigned NOT NULL default '0',
  file_code varchar(32) NOT NULL default '',
  fileset_root_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (fileset_id,file_code),
  KEY files (fileset_id,fileset_root_id)
) ENGINE=MRG_MyISAM UNION=(t1);
DROP TABLE t2, t1;
create table t1 (x int, y int, index xy(x, y));
create table t2 (x int, y int, index xy(x, y));
create table t3 (x int, y int, index xy(x, y)) engine=merge union=(t1,t2);
insert into t1 values(1, 2);
insert into t2 values(1, 3);
drop table t1,t2,t3;
create table t1 (a int);
create table t2 (a int);
insert into t1 values (0);
insert into t2 values (1);
drop table t1, t2;
create table t1 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=merge union=(t2,t3);
create table t2 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=myisam;
create table t3 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=myisam;
insert into t2 values ( null, '');
insert into t2 values ( 9999999999.999, '');
insert into t3 select * from t2;
select min(a), max(a) from t1;
select min(a), max(a) from t1;
drop table t1, t2, t3;
create table t1 (a int,b int,c int, index (a,b,c));
create table t2 (a int,b int,c int, index (a,b,c));
create table t3 (a int,b int,c int, index (a,b,c))
  engine=merge union=(t1 ,t2);
insert into t1 (a,b,c) values (1,1,0),(1,2,0);
insert into t2 (a,b,c) values (1,1,1),(1,2,1);
drop table t1, t2, t3;
CREATE TABLE t1 ( a INT AUTO_INCREMENT PRIMARY KEY, b VARCHAR(10), UNIQUE (b) )
  ENGINE=MyISAM;
CREATE TABLE t2 ( a INT AUTO_INCREMENT, b VARCHAR(10), INDEX (a), INDEX (b) )
  ENGINE=MERGE UNION (t1) INSERT_METHOD=FIRST;
INSERT INTO t2 (b) VALUES (1) ON DUPLICATE KEY UPDATE b=2;
INSERT INTO t2 (b) VALUES (1) ON DUPLICATE KEY UPDATE b=3;
SELECT b FROM t2;
DROP TABLE t1, t2;
create table t1(a int);
create table t2(a int);
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int) engine=merge union=(t1, t2) insert_method=first;
insert t2 select * from t2;
select * from t2;
select * from t1;
select * from t2;
drop table t1, t2, t3;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(2),(1);
CREATE TABLE t2(a INT, KEY(a)) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, t2;
CREATE TABLE t1(a INT) ENGINE=MEMORY;
CREATE TABLE t2(a INT) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, t2;
CREATE TABLE t2(a INT) ENGINE=MERGE UNION=(t3);
DROP TABLE t2;
CREATE TABLE t1(a INT, b TEXT);
CREATE TABLE tm1(a TEXT, b INT) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, tm1;
CREATE TABLE t1(a SMALLINT, b SMALLINT);
CREATE TABLE tm1(a INT) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, tm1;
CREATE TABLE t1(a SMALLINT, b SMALLINT, KEY(a, b));
CREATE TABLE tm1(a SMALLINT, b SMALLINT, KEY(a)) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, tm1;
CREATE TABLE t1(a SMALLINT, b SMALLINT, KEY(b));
CREATE TABLE tm1(a SMALLINT, b SMALLINT, KEY(a)) ENGINE=MERGE UNION=(t1);
DROP TABLE t1, tm1;
CREATE TABLE t1(c1 VARCHAR(1));
CREATE TABLE m1 LIKE t1;
ALTER TABLE m1 ENGINE=MERGE UNION=(t1);
DROP TABLE t1, m1;
CREATE TABLE t1(c1 VARCHAR(4), c2 TINYINT, c3 TINYINT, c4 TINYINT,
                c5 TINYINT, c6 TINYINT, c7 TINYINT, c8 TINYINT, c9 TINYINT);
CREATE TABLE m1 LIKE t1;
ALTER TABLE m1 ENGINE=MERGE UNION=(t1);
DROP TABLE t1, m1;
CREATE TABLE t1 (a VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_german2_ci,
                 b INT, INDEX(a,b));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
ALTER TABLE t3 ENGINE=MERGE UNION=(t1,t2);
INSERT INTO t1 VALUES ('ss',1);
INSERT INTO t2 VALUES ('ss',2),(0xDF,2);
DROP TABLE t1,t2,t3;
create table t1 (b bit(1));
create table t2 (b bit(1));
create table tm (b bit(1)) engine = merge union = (t1,t2);
drop table tm, t1, t2;
create table t1 (a int) insert_method = last engine = merge;
create table t2 (a int) engine = myisam;
alter table t1 union (t2);
insert into t1 values (1);
alter table t1 insert_method = no;
drop table t2;
drop table t1;
CREATE TABLE tm1(a INT) ENGINE=MERGE UNION=(t1, t2);
CREATE TABLE t1(a INT);
CREATE TABLE t2(a BLOB);
ALTER TABLE t2 MODIFY a INT;
DROP TABLE tm1, t1, t2;
CREATE TABLE t1(c1 INT);
CREATE TABLE t2 (c1 INT) ENGINE=MERGE UNION=(t1) INSERT_METHOD=FIRST;
DROP TABLE t1, t2;
CREATE TABLE t1 (id INT NOT NULL, ref INT NOT NULL, INDEX (id)) ENGINE=MyISAM;
CREATE TABLE t2 LIKE t1;
INSERT INTO t2 (id, ref) VALUES (1,3), (2,1), (3,2), (4,5), (4,4);
INSERT INTO t1 SELECT * FROM t2;
INSERT INTO t1 SELECT * FROM t2;
CREATE TABLE t3 (id INT NOT NULL, ref INT NOT NULL, INDEX (id)) ENGINE=MERGE
                                                                UNION(t1);
SELECT * FROM t3 AS a INNER JOIN t3 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t3;
DELETE FROM a USING t3 AS a INNER JOIN t3 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1(a INT);
CREATE TABLE m1(a INT) ENGINE=MERGE;
DROP TABLE m1;
CREATE TABLE m1(a INT) ENGINE=MERGE UNION=();
ALTER TABLE m1 UNION=(t1);
DROP TABLE t1, m1;
CREATE TABLE t1(a INT, KEY(a)) ENGINE=merge;
SELECT MAX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a VARCHAR(10));
CREATE TABLE m1(a INT) ENGINE=MERGE UNION=(t1, t2);
CREATE TABLE m2(a INT) ENGINE=MERGE UNION=(t1);
SELECT * FROM t1;
DROP TABLE t1, t2, m1, m2;
create table t1 (c1 int, index(c1));
create table t2 (c1 int, index(c1)) engine=merge union=(t1);
insert into t1 values (1);
insert into t1 values (1);
insert into t1 values (1);
drop table t1,t2;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1));
CREATE TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t1 VALUES (1);
UNLOCK TABLES;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
UNLOCK TABLES;
DROP TABLE t1, t2, t3;
CREATE TEMPORARY TABLE t1 (c1 INT, INDEX(c1)) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
UNLOCK TABLES;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE= MRG_MYISAM UNION= (t1) INSERT_METHOD= LAST;
INSERT INTO t2 VALUES (1);
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE= MRG_MYISAM UNION= (t1) INSERT_METHOD= LAST;
LOCK TABLE t1 WRITE;
UNLOCK TABLES;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
LOCK TABLE t1 WRITE;
SELECT * FROM t1;
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
CREATE TABLE t3 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
UNLOCK TABLES;
CREATE TABLE t4 (c1 INT);
INSERT INTO t4 VALUES (4);
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
DROP TABLE t4;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1, t2, t5;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
DROP TABLE t2;
SELECT * FROM t1;
UNLOCK TABLES;
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
UNLOCK TABLES;
DROP TABLE t2;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1));
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE TABLE t4 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t3,t2)
  INSERT_METHOD=LAST;
UNLOCK TABLES;
DROP TABLE t4;
CREATE TABLE t4 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2,t3)
  INSERT_METHOD=LAST;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
UNLOCK TABLES;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
UNLOCK TABLES;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
UNLOCK TABLES;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
CREATE TABLE t3 (c1 INT);
CREATE TABLE t4 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2,t3)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
UNLOCK TABLES;
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
UNLOCK TABLES;
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
SELECT @a;
SELECT @a;
UNLOCK TABLES;
SELECT @a;
INSERT INTO t3 VALUES (33);
SELECT @a;
SELECT @a;
INSERT INTO t3 VALUES (33);
SELECT @a;
UNLOCK TABLES;
INSERT INTO t3 VALUES (33);
INSERT INTO t3 VALUES (33);
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t2,t1)
  INSERT_METHOD=LAST;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (id INTEGER, grp TINYINT, id_rev INTEGER);
INSERT INTO t1 (id, grp, id_rev) VALUES (@id, @grp, @id_rev);
CREATE TABLE t2 SELECT * FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
INSERT INTO t2 (id, grp, id_rev) SELECT id, grp, id_rev FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
INSERT INTO t2 (id, grp, id_rev) SELECT id, grp, id_rev FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
CREATE TABLE t3 (id INTEGER, grp TINYINT, id_rev INTEGER)
  ENGINE= MRG_MYISAM UNION= (t1, t2);
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t2;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t2;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
INSERT INTO t2 VALUES (1);
SELECT * FROM t2;
LOCK TABLES t2 WRITE, t1 WRITE;
UNLOCK TABLES;
LOCK TABLES t2 WRITE, t1 WRITE;
UNLOCK TABLES;
DROP TABLE t1, t2;
CREATE TABLE t1 ( a INT ) ENGINE=MyISAM;
CREATE TABLE m1 ( a INT ) ENGINE=MRG_MYISAM UNION=(t1);
LOCK TABLES t1 WRITE, m1 WRITE;
UNLOCK TABLES;
DROP TABLE m1, t1;
CREATE TABLE t1 ( a INT ) ENGINE=MyISAM;
CREATE TABLE m1 ( a INT ) ENGINE=MRG_MYISAM UNION=(t1);
LOCK TABLES m1 WRITE, t1 WRITE;
UNLOCK TABLES;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE= MyISAM;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE= MRG_MYISAM UNION(t1, t2);
INSERT INTO t1 VALUES (1, 1);
INSERT INTO t2 VALUES (2, 2);
SELECT * FROM t3;
ALTER TABLE t1 ENGINE= MEMORY;
INSERT INTO t1 VALUES (0, 0);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 INT, KEY(c1));
CREATE TABLE t2 (c1 INT, KEY(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=FIRST;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
UNLOCK TABLES;
DROP TABLE t1, t2;
CREATE TABLE t1 (ID INT) ENGINE=MYISAM;
CREATE TABLE m1 (ID INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=FIRST;
INSERT INTO t1 VALUES ();
INSERT INTO m1 VALUES ();
LOCK TABLE t1 WRITE, m1 WRITE;
UNLOCK TABLES;
DROP TABLE t1, m1;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=FIRST;
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA = 'test' and TABLE_NAME='tm1';
DROP TABLE tm1;
CREATE TABLE t1(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t2(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t3(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t4(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2))
  ENGINE=MRG_MYISAM UNION=(t1, t2, t3);
INSERT INTO t1 VALUES (1,1), (1,2),(1,3), (1,4);
INSERT INTO t2 VALUES (2,1), (2,2),(2,3), (2,4);
INSERT INTO t3 VALUES (3,1), (3,2),(3,3), (3,4);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES(0),(1),(2),(3),(4);
CREATE TABLE m1(a INT, KEY(a)) ENGINE=MERGE UNION=(t1);
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
DROP TABLE t1, m1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(a INT, b INT, dummy CHAR(16) DEFAULT '', KEY(a), KEY(b));
INSERT INTO t2(a,b) VALUES
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(1,2);
CREATE TABLE t3(a INT, b INT, dummy CHAR(16) DEFAULT '', KEY(a), KEY(b))
ENGINE=MERGE UNION=(t2) INSERT_METHOD=FIRST;
UNLOCK TABLES;
DROP TABLE t1, t2, t3;
create table t1 (
        col1 int(10),
        primary key (col1)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TABLE m1 (
  col1 int(10) NOT NULL
) ENGINE=MRG_MyISAM DEFAULT CHARSET=latin1 INSERT_METHOD=LAST UNION=(t1);
insert into m1 (col1) values (1);
drop table m1, t1;
CREATE TABLE t1 (c1 INT PRIMARY KEY) ENGINE=MyISAM;
CREATE TABLE m1 (c1 INT NOT NULL) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1  VALUES (666);
SELECT * FROM m1;
SELECT * FROM m1;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT PRIMARY KEY) ENGINE=MyISAM;
CREATE TABLE m1 (c1 INT NOT NULL) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1  VALUES (666);
SELECT * FROM m1;
INSERT INTO m1 VALUES (666) ON DUPLICATE KEY UPDATE c1=c1+1;
SELECT * FROM m1;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT, c2 INT, UNIQUE (c1), UNIQUE (c2));
CREATE TABLE m1 (c1 INT, c2 INT, UNIQUE (c1)) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
DROP TABLE m1,t1;
CREATE TABLE t1 (c1 INT, c2 INT, UNIQUE (c1));
CREATE TABLE m1 (c1 INT, c2 INT, UNIQUE (c2)) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
DROP TABLE m1,t1;
CREATE TABLE t1 (
        col1 INT(10)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;
CREATE VIEW v1 as SELECT * FROM t1;
CREATE TABLE m1 (
        col1 INT(10)
)ENGINE=MRG_MyISAM DEFAULT CHARSET=latin1 INSERT_METHOD=LAST UNION=(v1);
DROP VIEW v1;
DROP TABLE m1, t1;
CREATE TABLE t1(c1 INT) ENGINE=MyISAM;
CREATE TABLE m1(c1 INT) ENGINE=MERGE UNION=(t1);
ALTER TABLE m1 ADD INDEX idx_c1(c1);
ALTER TABLE t1 ADD INDEX idx_c1(c1);
SELECT * FROM m1;
DROP TABLE m1;
DROP TABLE t1;
DROP TABLE IF EXISTS m1,t1;
CREATE TABLE t1(a int)engine=myisam;
CREATE TABLE t2(a int)engine=myisam;
CREATE TABLE t3(a int)engine=myisam;
CREATE TABLE t4(a int)engine=myisam;
CREATE TABLE t5(a int)engine=myisam;
CREATE TABLE t7(a int)engine=myisam;
CREATE TABLE m1(a int)engine=merge union=(t1,t2,t3,t4,t5,t6,t7);
DROP TABLE m1,t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE t1(a int);
CREATE TABLE t2(a int);
CREATE TABLE t3(a int) ENGINE = MERGE UNION(t1, t2);
DROP TABLE t1, t2, t3;
CREATE DATABASE `test/1`;
CREATE TABLE `test/1`.`t/1`(a INT);
DROP TABLE `test/1`.`t/1`;
DROP DATABASE `test/1`;
CREATE TABLE t1 (a INT) ENGINE=MYISAM;
INSERT INTO t1 VALUES(1);
CREATE TABLE t2 (b INT NOT NULL,c INT,d INT,e BLOB NOT NULL,
KEY idx0 (d, c)) ENGINE=MERGE;
DROP TABLE t2, t1;
DROP TABLE IF EXISTS m1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MYISAM;
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1) INSERT_METHOD=LAST;
LOCK TABLE m1 READ;
UNLOCK TABLES;
DROP TABLE m1,t1;
CREATE TABLE m1 (f1 BIGINT) ENGINE=MRG_MyISAM UNION(t1);
CREATE TABLE t1 (f1 BIGINT) ENGINE = MyISAM;
DROP TABLE m1, t1;
CREATE TEMPORARY TABLE m1 (f1 BIGINT) ENGINE=MRG_MyISAM UNION(t1);
CREATE TEMPORARY TABLE t1 (f1 BIGINT) ENGINE=MyISAM;
DROP TABLE m1, t1;
drop table if exists t_parent;
DROP DATABASE IF EXISTS mysql_test1;
CREATE DATABASE mysql_test1;
DROP DATABASE mysql_test1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
INSERT INTO t1 (c1) VALUES (1);
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2) INSERT_METHOD=FIRST;
CREATE TABLE t3 (c1 INT);
INSERT INTO t3 (c1) VALUES (1);
DROP TABLE tm1, t1, t2, t3;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2)
  INSERT_METHOD=FIRST;
INSERT INTO tm1 (c1) VALUES (1);
DROP TABLE tm1, t1, t2;
CREATE TEMPORARY TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2);
CREATE TEMPORARY TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (1);
INSERT INTO t2 (c1) VALUES (2);
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
LOCK TABLE tm1 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
LOCK TABLE tm1 WRITE;
UNLOCK TABLES;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
LOCK TABLE t2 WRITE;
INSERT INTO t2 VALUES (2);
SELECT * FROM t2;
UNLOCK TABLES;
DROP TABLE tm1, t1, t2;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
DROP TABLE tm1, t1;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t9 (c1 INT) ENGINE=MyISAM;
LOCK TABLE t9 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
DROP TABLE tm1, t1, t9;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t9 (c1 INT) ENGINE=MyISAM;
LOCK TABLE t9 WRITE;
UNLOCK TABLES;
DROP TABLE tm1, t1, t9;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
LOCK TABLE t2 WRITE;
INSERT INTO t2 VALUES (2);
SELECT * FROM tm1;
SELECT * FROM t2;
UNLOCK TABLES;
DROP TABLE tm1, t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
LOCK TABLE tm1 WRITE, t1 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
LOCK TABLE t1 WRITE, tm1 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
LOCK TABLE tm1 WRITE, t1 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
LOCK TABLE t1 WRITE, tm1 WRITE;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
UNLOCK TABLES;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t4 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t5 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2,t3,t4,t5)
  INSERT_METHOD=LAST;
LOCK TABLE tm1 WRITE, t1 WRITE, t2 WRITE, t3 WRITE, t4 WRITE, t5 WRITE;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(2);
INSERT INTO t3 VALUES(3);
INSERT INTO t4 VALUES(4);
INSERT INTO t5 VALUES(5);
UNLOCK TABLES;
SELECT * FROM tm1;
DROP TABLE tm1, t1, t2, t3, t4, t5;
CREATE TEMPORARY TABLE t1 (c1 INT);
CREATE TEMPORARY TABLE t2 (c1 INT);
ALTER TABLE t1 ENGINE=MERGE UNION(t_not_exists, t2);
DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1, t2, t3, t4, m1, m2;
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
INSERT INTO t1 VALUES (111, 121);
INSERT INTO m1 VALUES (211, 221);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
ALTER TABLE m1 RENAME m2;
SELECT * FROM m2;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
DROP TABLE m1;
ALTER TABLE m2 RENAME m1;
SELECT * FROM m1;
ALTER TABLE m1 ADD COLUMN c3 INT;
ALTER TABLE t1 ADD COLUMN c3 INT;
ALTER TABLE t2 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE m1 DROP COLUMN c3;
ALTER TABLE t1 DROP COLUMN c3;
ALTER TABLE t2 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3);
INSERT INTO m1 VALUES (311, 321);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
CREATE TEMPORARY TABLE t4 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3,t4);
INSERT INTO m1 VALUES (411, 421);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t4;
ALTER TABLE m1 ENGINE=MyISAM;
INSERT INTO m1 VALUES (511, 521);
SELECT * FROM m1;
ALTER TABLE m1 ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
CREATE TEMPORARY TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (611, 621);
SELECT * FROM m1;
DROP TABLE t1;
SELECT * FROM m1;
CREATE TABLE m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 ENGINE=MyISAM SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
DROP TABLE m2;
CREATE TABLE m2 LIKE m1;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 LIKE m1;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
LOCK TABLE m1 WRITE, m2 WRITE;
SELECT * FROM m1,m2 WHERE m1.c1=m2.c1;
UNLOCK TABLES;
DROP TABLE t1, t2, t3, t4, m1, m2;
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
INSERT INTO t1 VALUES (111, 121);
INSERT INTO m1 VALUES (211, 221);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
LOCK TABLE m1 WRITE, t1 WRITE, t2 WRITE;
ALTER TABLE m1 RENAME m2;
SELECT * FROM m2;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
DROP TABLE m1;
ALTER TABLE m2 RENAME m1;
SELECT * FROM m1;
ALTER TABLE m1 ADD COLUMN c3 INT;
ALTER TABLE t1 ADD COLUMN c3 INT;
ALTER TABLE t2 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE m1 DROP COLUMN c3;
ALTER TABLE t1 DROP COLUMN c3;
ALTER TABLE t2 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
UNLOCK TABLES;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3);
LOCK TABLE m1 WRITE;
INSERT INTO m1 VALUES (311, 321);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
CREATE TEMPORARY TABLE t4 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3,t4);
INSERT INTO m1 VALUES (411, 421);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t4;
ALTER TABLE m1 ENGINE=MyISAM;
INSERT INTO m1 VALUES (511, 521);
SELECT * FROM m1;
ALTER TABLE m1 ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
CREATE TEMPORARY TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (611, 621);
SELECT * FROM m1;
DROP TABLE t1;
SELECT * FROM m1;
CREATE TEMPORARY TABLE m2 ENGINE=MyISAM SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
SELECT * FROM m2;
LOCK TABLE m1 WRITE, m2 WRITE;
UNLOCK TABLES;
DROP TABLE m2;
LOCK TABLE m1 WRITE;
CREATE TEMPORARY TABLE m2 LIKE m1;
LOCK TABLE m1 WRITE, m2 WRITE;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
LOCK TABLE m1 WRITE, m2 WRITE;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
UNLOCK TABLES;
DROP TABLE t1, t2, t3, t4, m1, m2;
DROP TABLE IF EXISTS t1, t2, t3;
CREATE TABLE t1 (c1 int);
CREATE TABLE t2 (c1 int);
CREATE TABLE t3 (c1 int) ENGINE = MERGE UNION (t1,t2);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 int);
CREATE TABLE t2 (c1 int);
CREATE TABLE t3 (c1 int) ENGINE = MERGE UNION (t1,t2);
DROP TABLE t2;
DROP TABLE t1, t3;
create table t1 (c1 int not null);
create table t2 (c1 int not null);
create table t3 (c1 int not null);
create table t4 (c1 int not null) engine=merge union=(t1,t2) insert_method=last;
drop table t4, t3, t2, t1;
DROP TABLE IF EXISTS m1, t1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1);
UNLOCK TABLES;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1);
ALTER TABLE t1 ADD INDEX (c1);
ALTER TABLE t1 ADD INDEX (c1);
UNLOCK TABLES;
DROP TABLE m1, t1;
drop tables if exists t1, m1, m2;
create table t1 (i int) engine=myisam;
create table m1 (i int) engine=mrg_myisam union=(t1) insert_method=first;
create table m2 like m1;
drop tables m1, m2, t1;
drop table if exists t1, t2, t3, m1, m2;
create table t1 (a int);
create table t2 (a int);
create table t3 (b int);
create view v1 as select * from t3,t1;
create table m1 (a int) engine=merge union (t1, t2) insert_method=last;
create table m2 (a int) engine=merge union (t1, t2) insert_method=first;
create temporary table tmp (b int);
insert into tmp (b) values (1);
insert into t1 (a) values (1);
insert into t3 (b) values (1);
drop view v1;
drop temporary table tmp;
drop table t1, t2, t3, m1, m2;
DROP TABLE IF EXISTS t1, t2, t_not_exists;
CREATE TABLE t1(a INT);
ALTER TABLE t1 engine= MERGE UNION (t_not_exists);
DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT) engine= MERGE UNION (t1);
DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1, m1;
CREATE TABLE t1(a INT) engine=myisam;
CREATE TABLE m1(a INT) engine=merge UNION(t1);
LOCK TABLES t1 READ, m1 WRITE;
UNLOCK TABLES;
DROP TABLE m1, t1;
drop tables if exists t1, t2, t3, t4, m1;
create table t1(id int) engine=myisam;
create view t3 as select 1 as id;
create table t4(id int) engine=memory;
create table m1(id int) engine=merge union=(t1,t2,t3,t4);
drop tables m1, t1, t4;
drop view t3;
drop table if exists t1, t2, m1;
drop function if exists f1;
create table t1 (j int);
insert into t1 values (1);
create temporary table t2 (a int) engine=myisam;
insert into t2 values (1);
create temporary table m1 (a int) engine=merge union=(t2);
drop tables t2, m1;
create table t2 (a int) engine=myisam;
insert into t2 values (1);
create table m1 (a int) engine=merge union=(t2);
drop table m1;
create temporary table m1 (a int) engine=merge union=(t2);
drop tables t1, t2, m1;
create table t1 (a int) engine=myisam;
insert into t1 values (1);
create table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;
create temporary table t1 (a int) engine=myisam;
insert into t1 values (1);
create temporary table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;
create table t1 (a int) engine=myisam;
insert into t1 values (1);
create temporary table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS m1;
DROP TRIGGER IF EXISTS trg1;
DROP TABLE IF EXISTS q1;
DROP TABLE IF EXISTS q2;
CREATE TABLE t1(a INT);
CREATE TABLE m1(a INT) ENGINE = MERGE UNION (q1, q2);
DELETE FROM t1;
DROP TABLE t1;
DROP TABLE m1;
DROP TABLES IF EXISTS t1, t2, t3, t4;
CREATE TEMPORARY TABLE t1(i INT) ENGINE= MyISAM;
CREATE TEMPORARY TABLE t2(i INT) ENGINE= MERGE UNION= (t1) INSERT_METHOD= LAST;
ALTER TABLE t2 INSERT_METHOD= FIRST;
CREATE TABLE t3(i INT) ENGINE= MyISAM;
CREATE TABLE t4(i int) ENGINE= MERGE UNION= (t3) INSERT_METHOD= LAST;
ALTER TABLE t4 INSERT_METHOD= FIRST;
DROP TABLES t1, t2, t3, t4;
