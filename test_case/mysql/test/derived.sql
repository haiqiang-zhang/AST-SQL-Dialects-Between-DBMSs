select * from (select 2 from DUAL) b;
CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
CREATE TABLE t2 (a int not null, b char (10) not null);
insert into t2 values (3,'c'),(4,'d'),(5,'f'),(6,'e');
select t1.a,t3.y from t1,(select a as y from t2  where b='c') as t3  where t1.a = t3.y;
select t1.a,t3.a from t1,(select * from t2  where b='c') as t3  where t1.a = t3.a;
CREATE TABLE t3 (a int not null, b char (10) not null);
insert into t3 values (3,'f'),(4,'y'),(5,'z'),(6,'c');
select t1.a,t4.y from t1,(select t2.a as y from t2,(select t3.b from t3 where t3.a>3) as t5  where t2.b=t5.b) as t4  where t1.a = t4.y;
SELECT a,2 as a FROM (SELECT '1' as a) b HAVING a=2;
SELECT a,2 as a FROM (SELECT '1' as a) b HAVING a=1;
select * from t1 as x1, (select * from t1) as x2;
drop table if exists  t2,t3;
select * from (select 1) as a;
select a from (select 1 as a) as b;
select 1 from (select 1) as a;
select * from (select * from t1 union select * from t1) a;
select * from (select * from t1 union all select * from t1) a;
select * from (select * from t1 union all select * from t1 limit 2) a;
select * from (select * from t1 intersect all select * from t1 order by a,b limit 2) a;
select * from (select * from t1 except all select * from t1 limit 2) a;
CREATE TABLE t2 (a int not null);
insert into t2 values(1);
select * from (select * from t1 where t1.a=(select a from t2 where t2.a=t1.a)) a;
select * from (select * from t1 where t1.a=(select t2.a from t2 where t2.a=t1.a) union select t1.a, t1.b from t1) a;
drop table t1, t2;
create table t1(a int not null, t char(8), index(a));
SELECT * FROM (SELECT * FROM t1) as b ORDER BY a  ASC LIMIT 0,20;
drop table t1;
SELECT * FROM (SELECT (SELECT * FROM (SELECT 1 as a) as a )) as b;
select * from (select 1 as a) b  left join (select 2 as a) c using(a);
create table t1 (id int);
insert into t1 values (1),(2),(3);
drop table t1;
create table t1 (mat_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, matintnum CHAR(6) NOT NULL, test MEDIUMINT UNSIGNED NULL) charset utf8mb4;
create table t2 (mat_id MEDIUMINT UNSIGNED NOT NULL, pla_id MEDIUMINT UNSIGNED NOT NULL);
insert into t1 values (NULL, 'a', 1), (NULL, 'b', 2), (NULL, 'c', 3), (NULL, 'd', 4), (NULL, 'e', 5), (NULL, 'f', 6), (NULL, 'g', 7), (NULL, 'h', 8), (NULL, 'i', 9);
insert into t2 values (1, 100), (1, 101), (1, 102), (2, 100), (2, 103), (2, 104), (3, 101), (3, 102), (3, 105);
SELECT STRAIGHT_JOIN d.pla_id, m2.mat_id FROM t1 m2 INNER JOIN (SELECT mp.pla_id, MIN(m1.matintnum) AS matintnum FROM t2 mp INNER JOIN t1 m1 ON mp.mat_id=m1.mat_id GROUP BY mp.pla_id) d ON d.matintnum=m2.matintnum;
SELECT STRAIGHT_JOIN d.pla_id, m2.test FROM t1 m2  INNER JOIN (SELECT mp.pla_id, MIN(m1.matintnum) AS matintnum FROM t2 mp INNER JOIN t1 m1 ON mp.mat_id=m1.mat_id GROUP BY mp.pla_id) d ON d.matintnum=m2.matintnum;
drop table t1,t2;
SELECT a.x FROM (SELECT 1 AS x) AS a HAVING a.x = 1;
create table t1 select 1 as a;
select 2 as a from (select * from t1) b;
select 2 as a from (select * from t1) b;
drop table t1;
create table t1 (a int);
insert into t1 values (1),(2),(3);
drop table t1;
create table t1 (E1 INTEGER UNSIGNED NOT NULL, E2 INTEGER UNSIGNED NOT NULL, E3 INTEGER UNSIGNED NOT NULL, PRIMARY KEY(E1)
);
insert into t1 VALUES(1,1,1), (2,2,1);
select count(*) from t1 INNER JOIN (SELECT A.E1, A.E2, A.E3 FROM t1 AS A WHERE A.E3 = (SELECT MAX(B.E3) FROM t1 AS B WHERE A.E2 = B.E2)) AS themax ON t1.E1 = themax.E2 AND t1.E1 = t1.E2;
drop table t1;
create table t1 (a int);
insert into t1 values (1),(2);
select * from ( select * from t1 union select * from t1) a,(select * from t1 union select * from t1) b;
drop table t1;
CREATE TABLE `t1` (
  `N` int(11) unsigned NOT NULL default '0',
  `M` tinyint(1) default '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `t1` (N, M) VALUES (1, 0),(1, 0),(1, 0),(2, 0),(2, 0),(3, 0);
UPDATE `t1` AS P1 INNER JOIN (SELECT N FROM `t1` GROUP BY N HAVING Count(M) > 1) AS P2 ON P1.N = P2.N SET P1.M = 2;
select * from t1;
delete P1.* from `t1` AS P1 INNER JOIN (SELECT N FROM `t1` GROUP BY N HAVING Count(M) > 1) AS P2 ON P1.N = P2.N;
select * from t1;
drop table t1;
CREATE TABLE t1 (
  OBJECTID int(11) NOT NULL default '0',
  SORTORDER int(11) NOT NULL auto_increment,
  KEY t1_SortIndex (SORTORDER),
  KEY t1_IdIndex (OBJECTID)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TABLE t2 (
  ID int(11) default NULL,
  PARID int(11) default NULL,
  UNIQUE KEY t2_ID_IDX (ID),
  KEY t2_PARID_IDX (PARID)
) engine=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t2 VALUES (1000,0),(1001,0),(1002,0),(1003,0),(1008,1),(1009,1),(1010,1),(1011,1),(1016,2);
CREATE TABLE t3 (
  ID int(11) default NULL,
  DATA decimal(10,2) default NULL,
  UNIQUE KEY t3_ID_IDX (ID)
) engine=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t3 VALUES (1000,0.00),(1001,0.25),(1002,0.50),(1003,0.75),(1008,1.00),(1009,1.25),(1010,1.50),(1011,1.75);
select 497, TMP.ID, NULL from (select 497 as ID, MAX(t3.DATA) as DATA      from t1 join t2 on (t1.ObjectID = t2.ID) join t3 on (t1.ObjectID = t3.ID) group by t2.ParID order by DATA DESC) as TMP;
drop table t1, t2, t3;
CREATE TABLE t1 (name char(1) default NULL, val int(5) default NULL);
INSERT INTO t1 VALUES ('a',1),  ('a',2),  ('a',2),  ('a',2),  ('a',3),  ('a',6), ('a',7), ('a',11), ('a',11), ('a',12), ('a',13), ('a',13), ('a',20), ('b',2), ('b',3), ('b',4), ('b',5);
SELECT s.name, AVG(s.val) AS median FROM (SELECT x.name, x.val FROM t1 x, t1 y WHERE x.name=y.name GROUP BY x.name, x.val HAVING SUM(y.val <= x.val) >= COUNT(*)/2 AND SUM(y.val >= x.val) >= COUNT(*)/2) AS s GROUP BY s.name;
drop table t1;
create table t2 (a int, b int, primary key (a));
insert into t2 values (1,7),(2,7);
drop table t2;
create table t1 (a integer, b integer);
insert into t1 values (1,4), (2,2),(2,2), (4,1),(4,1),(4,1),(4,1);
select distinct sum(b) from t1 group by a;
select distinct sum(b) from (select a,b from t1) y group by a;
drop table t1;
CREATE TABLE t1 (a char(10), b char(10));
INSERT INTO t1 VALUES ('root','localhost'), ('root','%');
DROP TABLE t1;
create table t1(a int);
create table t2(a int);
create table t3(a int);
insert into t1 values(1),(1);
insert into t2 values(2),(2);
insert into t3 values(3),(3);
select * from t1 union distinct select * from t2 union all select * from t3;
select * from (select * from t1 union distinct select * from t2 union all select * from t3) X;
drop table t1, t2, t3;
create table t1 (a int);
create table t2 (a int);
drop table t1,t2;
create table t1 (ID int unsigned not null auto_increment,
                 DATA varchar(5) not null, primary key (ID));
create table t2 (ID int unsigned not null auto_increment,
                 DATA varchar(5) not null, FID int unsigned not null,
                 primary key (ID));
select A.* from (t1 inner join (select * from t2) as A on t1.ID = A.FID);
select t2.* from ((select * from t1) as A inner join t2 on A.ID = t2.FID);
select t2.* from (select * from t1) as A inner join t2 on A.ID = t2.FID;
drop table t1, t2;
SELECT 0 FROM
(SELECT 0) t01, (SELECT 0) t02, (SELECT 0) t03, (SELECT 0) t04, (SELECT 0) t05,
(SELECT 0) t06, (SELECT 0) t07, (SELECT 0) t08, (SELECT 0) t09, (SELECT 0) t10,
(SELECT 0) t11, (SELECT 0) t12, (SELECT 0) t13, (SELECT 0) t14, (SELECT 0) t15,
(SELECT 0) t16, (SELECT 0) t17, (SELECT 0) t18, (SELECT 0) t19, (SELECT 0) t20,
(SELECT 0) t21, (SELECT 0) t22, (SELECT 0) t23, (SELECT 0) t24, (SELECT 0) t25,
(SELECT 0) t26, (SELECT 0) t27, (SELECT 0) t28, (SELECT 0) t29, (SELECT 0) t30,
(SELECT 0) t31, (SELECT 0) t32, (SELECT 0) t33, (SELECT 0) t34, (SELECT 0) t35,
(SELECT 0) t36, (SELECT 0) t37, (SELECT 0) t38, (SELECT 0) t39, (SELECT 0) t40,
(SELECT 0) t41, (SELECT 0) t42, (SELECT 0) t43, (SELECT 0) t44, (SELECT 0) t45,
(SELECT 0) t46, (SELECT 0) t47, (SELECT 0) t48, (SELECT 0) t49, (SELECT 0) t50,
(SELECT 0) t51, (SELECT 0) t52, (SELECT 0) t53, (SELECT 0) t54, (SELECT 0) t55,
(SELECT 0) t56, (SELECT 0) t57, (SELECT 0) t58, (SELECT 0) t59, (SELECT 0) t60,
(SELECT 0) t61;
CREATE TABLE t1 (i INT, j BIGINT);
INSERT INTO t1 VALUES (1, 2), (2, 2), (3, 2);
SELECT * FROM (SELECT MIN(i) FROM t1
WHERE j = SUBSTRING('12', (SELECT * FROM (SELECT MIN(j) FROM t1) t2))) t3;
DROP TABLE t1;
CREATE TABLE C (
  `col_int_key` int(11) DEFAULT NULL,
  `col_varchar_key` varchar(1) DEFAULT NULL,
  `col_varchar_nokey` varchar(1) DEFAULT NULL,
  KEY `col_varchar_key` (`col_varchar_key`,`col_int_key`)
);
INSERT INTO C VALUES (2,'w','w');
INSERT INTO C VALUES (2,'d','d');
SELECT SUM(DISTINCT table2.col_int_key) field1,
       table1.col_varchar_key field2
FROM
  (SELECT * FROM C  ) table1
  JOIN (SELECT * FROM C  ) table2
  ON table2 .`col_varchar_key` = table1 .`col_varchar_nokey`
GROUP  BY field2
ORDER  BY field1;
DROP TABLE C;
CREATE TABLE C (
  col_int int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL
);
INSERT INTO `C` VALUES (0,NULL);
INSERT INTO `C` VALUES (5,'y');
SELECT table1.col_varchar
FROM
 ( SELECT * FROM C  ) table1
 JOIN ( SELECT * FROM C  ) table2  ON table2.col_varchar = table1.col_varchar
WHERE
  table2.col_varchar < table2.col_varchar
  AND table1.col_varchar != 'k'
LIMIT  1;
DROP TABLE C;
CREATE TABLE C (
  col_varchar_10_key varchar(10) DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  pk int NOT NULL AUTO_INCREMENT,
  col_date_key date DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `col_varchar_10_key` (`col_varchar_10_key`),
  KEY `col_int_key` (`col_int_key`),
  KEY `col_date_key` (`col_date_key`)
);
INSERT INTO C VALUES ('ok',3,1,'2003-04-02');
CREATE ALGORITHM=TEMPTABLE VIEW viewC AS SELECT * FROM C;
SELECT  table1.col_date_key AS field1
FROM
  C AS table1
WHERE
  (table1.col_int_key <=ANY
    ( SELECT SUBQUERY1_t1.col_int_key
      FROM viewC AS SUBQUERY1_t1
      WHERE SUBQUERY1_t1.col_varchar_10_key <= table1.col_varchar_10_key
    )
  );
DROP TABLE C;
DROP VIEW viewC;
CREATE TABLE `cc` (
  `i1` varchar(1) DEFAULT NULL,
  `i2` varchar(1) DEFAULT NULL
) charset utf8mb4;
INSERT INTO `cc` VALUES ('m','m');
INSERT INTO `cc` VALUES ('c','c');
CREATE TABLE `C` (
  `o1` varchar(1) DEFAULT NULL
) charset utf8mb4;
INSERT INTO `C` VALUES ('m');
SELECT table1 . o1
FROM C table1
  JOIN ( C table2
    JOIN ( SELECT * FROM cc ) table3
    ON table3 .`i1`  = table2 .o1
  ) ON table3 .`i2`  = table2 .o1;
DROP TABLE cc;
DROP TABLE C;
CREATE TABLE `t1` (
  `pk` int(11) NOT NULL,
  `col_int_key` int(11) DEFAULT NULL,
  `col_datetime_key` datetime DEFAULT NULL
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (2, 9, NULL), (3, 3, '1900-01-01 00:00:00'),
(8, 8, '1900-01-01 00:00:00'), (15, 0, '2007-12-15 12:39:34');
SELECT * FROM (
  SELECT DISTINCT tableb.col_datetime_key
  FROM t1 tablea LEFT JOIN t1 tableb ON tablea.pk < tableb.col_int_key
) AS from_subquery;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT, KEY (b));
INSERT INTO t1 VALUES (1),(1);
INSERT INTO t2 VALUES (1),(1);
CREATE algorithm=temptable VIEW v1 AS
  SELECT 1 FROM t1 LEFT JOIN t1 t3 ON 1 > (SELECT 1 FROM t1);
CREATE algorithm=temptable VIEW v2 AS SELECT 1 FROM t2;
DROP TABLE t1, t2;
DROP VIEW v1, v2;
CREATE TABLE t1(f1 int, f11 int);
CREATE TABLE t2(f2 int, f22 int);
INSERT INTO t1 VALUES(1,1),(2,2),(3,3),(5,5),(9,9),(7,7);
INSERT INTO t2 VALUES(1,1),(3,3),(2,2),(4,4),(8,8),(6,6);
SELECT * FROM (SELECT * FROM t1) tt;
SELECT * FROM (SELECT * FROM t1 JOIN t2 ON f1=f2) tt;
SELECT * FROM (SELECT * FROM t1 WHERE f1 IN (2,3)) tt WHERE f11=2;
SELECT * FROM (SELECT * FROM t1 WHERE f1 IN (2,3)) tt WHERE f11=2;
SELECT * FROM (SELECT * FROM t1 WHERE f1 IN (2,3)) tt JOIN
  (SELECT * FROM t1 WHERE f1 IN (1,2)) aa ON tt.f1=aa.f1;
SELECT * FROM (SELECT * FROM t1 WHERE f1 IN (2,3)) tt JOIN
  (SELECT * FROM t1 WHERE f1 IN (1,2)) aa ON tt.f1=aa.f1;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t1 JOIN t2 ON f1=f2;
CREATE VIEW v3 AS SELECT * FROM t1 WHERE f1 IN (2,3);
CREATE VIEW v4 AS SELECT * FROM t2 WHERE f2 IN (2,3);
SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM v3 WHERE f11 IN (1,3);
SELECT * FROM v3 JOIN v4 ON f1=f2;
SELECT * FROM v3 JOIN v4 ON f1=f2;
SELECT * FROM v4 WHERE f2 IN (1,3);
SELECT * FROM (SELECT * FROM t1 HAVING f1=f1) tt;
DROP VIEW v1,v2,v3;
CREATE VIEW v1 AS SELECT * FROM t1 GROUP BY f1;
CREATE VIEW v2 AS SELECT * FROM t2 GROUP BY f2;
CREATE VIEW v3 AS SELECT t1.f1,t1.f11 FROM t1 JOIN t1 AS t11 HAVING t1.f1<100;
SELECT * FROM t1,v3 AS v31,v3 WHERE t1.f1=v31.f1 and t1.f1=v3.f1;
SELECT * FROM t1,v3 AS v31,v3 WHERE t1.f1=v31.f1 and t1.f1=v3.f1;
SELECT * FROM (SELECT * FROM
  (SELECT * FROM t1 WHERE f1 < 7) tt WHERE f1 > 2) zz;
SELECT * FROM
 (SELECT * FROM
  (SELECT * FROM t1 WHERE f1 < 7 ) tt WHERE f1 > 2 ) x
JOIN
 (SELECT * FROM
  (SELECT * FROM t1 WHERE f1 < 7 ) tt WHERE f1 > 2 ) z
 ON x.f1 = z.f1;
CREATE VIEW v6 AS SELECT * FROM v4 WHERE f2 < 7;
SELECT * FROM (SELECT * FROM v6) tt;
CREATE VIEW v7 AS SELECT * FROM v1;
CREATE TABLE t3(f3 INT, f33 INT);
INSERT INTO t1 VALUES(6,6),(8,8);
INSERT INTO t3 VALUES(1,1),(2,2),(3,3),(5,5);
DROP TABLE t1,t2,t3;
DROP VIEW v1,v2,v3,v4,v6,v7;
CREATE TABLE t1 (
  col_int_key INT,
  col_time_key time,
  col_varchar_key VARCHAR(1),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
) ENGINE=INNODB;
SELECT alias1.col_time_key AS field1
FROM ( ( SELECT SQ1_alias1.* FROM t1 AS SQ1_alias1 ) AS alias1
  INNER JOIN t1 AS alias2
  ON (alias2.col_int_key = alias1.col_int_key)
  )
WHERE alias1.col_int_key = 207
ORDER BY alias1.col_varchar_key, field1;
DROP TABLE t1;
CREATE TABLE t1 (
  f1 int(11) DEFAULT NULL
);
SELECT 1
FROM (
  SELECT 1, 2 FROM DUAL
  WHERE EXISTS  (
    SELECT f1
    FROM  t1
    )) AS tt;
DROP TABLE t1;
CREATE TABLE t1 (
  pk INT NOT NULL AUTO_INCREMENT,
  col_int_key INT,
  col_time_key time,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
) ENGINE=InnoDB;
SELECT tt.col_time_key
FROM ( ( SELECT * FROM t1 ) AS tt
  INNER JOIN t1
  ON (t1.col_int_key = tt.col_int_key)
  )
WHERE tt.col_int_key = 207
ORDER BY tt.col_varchar_key, tt.pk ASC, 1;
DROP TABLE t1;
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key,col_int_key)
);
INSERT INTO t1 VALUES (10,8,'v'), (29,4,'c');
CREATE TABLE t2 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_nokey int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES (16,1,'c'), (20,4,'d');
CREATE TABLE t3 (
  `field1` varchar(1) DEFAULT NULL,
  `field2` int(11) DEFAULT NULL
);
INSERT INTO t3 VALUES ('m',6),('c',4);
SELECT *
FROM t3
WHERE (field1, field2) IN (
  SELECT t1.col_varchar_key AS field1,
         t1.col_int_key AS field2
  FROM ( t1 INNER JOIN (
      SELECT t2.*
      FROM t2
      WHERE t2.col_int_nokey < t2.pk ) AS alias2
    ON (alias2.col_varchar_key = t1.col_varchar_key ) )
  GROUP BY field1, field2
  ORDER BY t1.col_int_key, t1 .pk DESC );
DROP TABLE t1,t2,t3;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (NULL),(NULL);
SELECT * FROM t1
WHERE (a, a) NOT IN
  (SELECT * FROM (SELECT 8, 4 UNION SELECT 2, 3) tt);
DROP TABLE t1;
CREATE TABLE t1 (pk int);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (col_varchar_nokey varchar(1));
INSERT INTO t2 VALUES ('m'), ('f');
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 VARCHAR(1), key(f1));
INSERT INTO t1 VALUES ('a');
CREATE VIEW v1 AS SELECT f1 FROM t1 ORDER BY 1 LIMIT 0;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_nokey int(11) NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (10,1,'v'), (24,18,'h');
CREATE TABLE t2 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_date_key date NOT NULL,
  col_date_nokey date NOT NULL,
  col_time_nokey time NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,'1900-01-01','1900-01-01','00:00:00','k','k');
SELECT OUTR.col_date_key
FROM t2 AS OUTR2
  LEFT JOIN t2 AS OUTR ON OUTR2.pk < OUTR.pk
WHERE ( OUTR.col_varchar_nokey , OUTR.col_varchar_key )
  IN (
    SELECT DISTINCT col_varchar_key , col_varchar_key
    FROM t1
    WHERE col_int_nokey XOR OUTR.col_time_nokey
  )
  XOR OUTR.col_date_nokey IS NULL;
DROP TABLE t1,t2;
create table t1(f1 char(255) charset utf8mb3);
insert into t1 values('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('0');
select count(*) from t1 join (
  select t1.f1 from t1 join t1 as t2 join t1 as t3) tt on t1.f1 = tt.f1;
drop table t1;
CREATE TABLE t1(f1 INT);
INSERT INTO t1 VALUES (1),(2),(3);
DROP TABLE t1;
CREATE TABLE t1 ( fk INT) ENGINE=INNODB;
CREATE TABLE t2 (
f1 INT,  f2 INT,  f3 INT,  f4 INT,  f5 INT,  f6 INT,
f7 INT,  f8 INT,  f9 INT,  f10 INT, f11 INT, f12 INT,
f13 INT, f14 INT, f15 INT, f16 INT, f17 INT, f18 INT,
f19 INT, f20 INT, f21 INT, f22 INT, f23 INT, f24 INT,
f25 INT, f26 INT, f27 INT, f28 INT, f29 INT, f30 INT,
f31 INT, f32 TEXT, fk INT) ENGINE=INNODB;
SELECT alias2.fk AS field1 FROM t1 AS alias1 JOIN
  (SELECT * FROM t2 ) AS alias2 ON alias1.fk = alias2.fk;
SELECT alias2.fk AS field1 FROM t1 AS alias1 JOIN
  (SELECT * FROM t2 ) AS alias2 ON alias1.fk = alias2.fk;
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 int) ENGINE=myisam;
CREATE TABLE t2 (f1 text) ENGINE=innodb;
SELECT 1 FROM (
  ( SELECT * FROM ( SELECT * FROM t2 ) AS alias1 ) AS alias1,
  ( SELECT * FROM t1 ) AS alias2 );
DROP TABLE t1,t2;
CREATE TABLE t1 ( pk integer auto_increment,
col_blob_key blob, primary key (pk)) ENGINE=innodb;
CREATE TABLE t2 (col_tinytext tinytext null,
pk integer auto_increment, col_text text,
col_blob blob, primary key (pk)) ENGINE=innodb;
SELECT alias1.col_text AS field1 ,
       alias1.col_tinytext AS field2
FROM t2 AS alias1
  LEFT OUTER JOIN ( SELECT * FROM t1 ) AS alias2 ON alias1.pk = alias2.pk
WHERE alias2.pk >=1  AND alias2.pk < 3
ORDER BY field1,field2 ASC;
DROP TABLE t1, t2;
CREATE TABLE t1 (pk INTEGER PRIMARY KEY, vc VARCHAR(20)) charset utf8mb4;
INSERT INTO t1 VALUES(7, 'seven'), (13, 'thirteen');
CREATE TABLE t2 (pk INTEGER PRIMARY KEY, vc1 VARCHAR(20), vc2 VARCHAR(20)) charset utf8mb4;
INSERT INTO t2 VALUES(7, 'seven', 's'), (14, 'fourteen', 'f');
CREATE TABLE t3 (pk INTEGER PRIMARY KEY, vc VARCHAR(20)) charset utf8mb4;
INSERT INTO t3 VALUES(5, 'f'), (6, 's'), (7, 's');
SELECT derived.vc
FROM (SELECT * FROM t1) AS derived
WHERE derived.vc IN (
  SELECT t2.vc1
  FROM t2 JOIN t3 ON t2.vc2=t3.vc);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  `col_int_key` int(11) NOT NULL,
  `col_varchar_nokey` varchar(1) NOT NULL
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (8,'m'), (4,'b'), (4,'x'), (7,'g'), (4,'p');
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT col_int_key
FROM t1
WHERE ( NOT EXISTS (
  SELECT col_varchar_nokey
  FROM t1
  WHERE ( 7 ) IN (
      SELECT v1.col_int_key
      FROM ( v1 JOIN ( SELECT * FROM t1 ) AS d1
        ON ( d1.col_varchar_nokey = v1.col_varchar_nokey ) )
    )
) );
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (pk int(11)) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (pk int(11)) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1), (2), (3);
CREATE VIEW v1 AS SELECT DISTINCT pk FROM t1;
SELECT pk
FROM t2
WHERE pk IN ( SELECT * FROM v1 );
DROP TABLE t1,t2;
DROP VIEW v1;
CREATE TABLE t1 (
  col_varchar varchar(1024) CHARACTER SET utf8mb3 DEFAULT NULL,
  stub1 varchar(1024) CHARACTER SET utf8mb3 DEFAULT NULL,
  stub2 varchar(1024) CHARACTER SET utf8mb3 DEFAULT NULL,
  stub3 varchar(1024) CHARACTER SET utf8mb3 DEFAULT NULL
);
INSERT INTO t1 VALUES
  ('d','d','l','ther'),
  (NULL,'s','NJBIQ','trzetuchv'),
  (-715390976,'coul','MYWFB','cfhtrzetu'),
  (1696792576,'f','i\'s','c'),
  (1,'i','ltpemcfhtr','gsltpemcf'),
  (-663027712,'mgsltpemcf','sa','amgsltpem'),
  (-1686700032,'JPRVK','i','vamgsltpe'),
  (NULL,'STUNB','UNVJV','u'),
  (5,'oka','qyihvamgsl','AXSMD'),
  (NULL,'tqwmqyihva','h','yntqwmqyi'),
  (3,'EGMJN','e','e');
CREATE TABLE t2 (
  col_varchar varchar(10) DEFAULT NULL,
  col_int INT DEFAULT NULL
) charset utf8mb4;
INSERT INTO t2 VALUES ('d',9);
SELECT t2.col_int
FROM t2
    RIGHT JOIN ( SELECT * FROM t1 ) AS dt
  ON t2.col_varchar = dt.col_varchar
WHERE t2.col_int IS NOT NULL;
SELECT t2.col_int
FROM t2
    RIGHT JOIN ( SELECT * FROM t1 ) AS dt
  ON t2.col_varchar = dt.col_varchar
WHERE t2.col_int IS NOT NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  col_int_key INT DEFAULT NULL,
  col_time_nokey TIME DEFAULT NULL,
  col_varchar_key VARCHAR(1) DEFAULT NULL,
  col_varchar_nokey VARCHAR(1) DEFAULT NULL,
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
) charset latin1;
INSERT INTO t1 VALUES
 (8,'22:55:23','x','x'),
 (7,'10:19:31','d','d'),
 (1,'14:40:36','r','r'),
 (7,'04:37:47','f','f'),
 (9,'19:34:06','y','y'),
 (NULL,'20:35:33','u','u'),
 (1,NULL,'m','m'),
 (9,'14:43:37',NULL,NULL),
 (2,'02:23:09','o','o'),
 (9,'01:22:45','w','w'),
 (2,'00:00:00','m','m'),
 (4,'00:13:25','q','q'),
 (0,'03:47:16',NULL,NULL),
 (4,'01:41:48','d','d'),
 (8,'00:00:00','g','g'),
 (NULL,'22:32:04','x','x'),
 (NULL,'16:44:14','f','f'),
 (0,'17:38:37','p','p'),
 (NULL,'08:46:48','j','j'),
 (8,'14:11:27','c','c');
CREATE TABLE t2 (
  col_int_key INT DEFAULT NULL,
  col_time_nokey TIME DEFAULT NULL,
  col_varchar_key VARCHAR(1) DEFAULT NULL,
  col_varchar_nokey VARCHAR(1) DEFAULT NULL,
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
) charset latin1;
INSERT INTO t2 VALUES
 (4,'22:34:09','v','v'),
 (62,'14:26:02','v','v'),
 (7,'14:03:03','c','c'),
 (1,'01:46:09',NULL,NULL),
 (0,'16:21:18','x','x'),
 (7,'18:56:33','i','i'),
 (7,NULL,'e','e'),
 (1,'09:29:08','p','p'),
 (7,'19:11:10','s','s'),
 (1,'11:57:26','j','j'),
 (5,'00:39:46','z','z'),
 (2,'03:28:15','c','c'),
 (0,'06:44:18','a','a'),
 (1,'14:36:39','q','q'),
 (8,'18:42:45','y','y'),
 (1,'02:57:29',NULL,NULL),
 (1,'16:46:13','r','r'),
 (9,'19:39:02','v','v'),
 (1,NULL,NULL,NULL),
 (5,'20:58:33','r','r');
CREATE TABLE t3 (
  col_int_key INT DEFAULT NULL,
  col_time_nokey TIME DEFAULT NULL,
  col_varchar_key VARCHAR(1) DEFAULT NULL,
  col_varchar_nokey VARCHAR(1) DEFAULT NULL,
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key,col_int_key)
) charset latin1;
INSERT INTO t3 VALUES (8,'04:07:22','g','g');
SELECT col_time_nokey AS x
FROM (SELECT * FROM t2) AS outr
WHERE col_varchar_nokey IN (
  SELECT innr.col_varchar_key
  FROM (SELECT * FROM t3) AS innr2
    LEFT JOIN (SELECT * FROM t1) AS innr
    ON innr2.col_varchar_key >= innr.col_varchar_key
  WHERE outr.col_varchar_nokey = 'e'
  )
  AND outr.col_varchar_key <> 'r';
DROP TABLE t1, t2, t3;
create table t1 (
field00 int, field01 int, field02 int, field03 int,
field04 int, field05 int, field06 int, field07 int,
field10 int, field11 int, field12 int, field13 int,
field14 int, field15 int, field16 int, field17 int,
field20 int, field21 int, field22 int, field23 int,
field24 int, field25 int, field26 int, field27 int,
field30 int, field31 int, field32 int, field33 int,
field34 int, field35 int, field36 int, field37 int,
field40 int, field41 int, field42 int, field43 int,
field44 int, field45 int, field46 int, field47 int,
field50 int, field51 int, field52 int, field53 int,
field54 int, field55 int, field56 int, field57 int,
field60 int, field61 int, field62 int, field63 int,
field64 int, field65 int, field66 int, field67 int,
field70 int, field71 int, field72 int, field73 int,
field74 int, field75 int, field76 int, field77 int,
field100 int
);
insert into t1(field100) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(0);
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
select tt.field100 from t1 join (select * from t1) tt where t1.field100=tt.field100
limit 1;
select tt.field100 from t1 join (select * from t1) tt where t1.field100=tt.field100
limit 1;
drop table t1;
CREATE TABLE t1 (
  col_varchar_key varchar(1),
  col_varchar_nokey varchar(1),
  KEY col_varchar_key (col_varchar_key)
) charset utf8mb4 ENGINE=MyISAM;
INSERT INTO t1 VALUES ('r','r');
CREATE TABLE t2 (
  col_varchar_key varchar(1),
  col_varchar_nokey varchar(1),
  KEY col_varchar_key (col_varchar_key)
) charset utf8mb4;
INSERT INTO t2 VALUES
 (NULL,NULL),
 ('r','r');
CREATE TABLE t3 (
  col_int_key int,
  col_varchar_key varchar(1),
  col_varchar_nokey varchar(1),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key, col_int_key)
) charset utf8mb4;
INSERT INTO t3 VALUES
 (9,'f','f'),
 (4,'y','y'),
 (3,'u','u'),
 (2,'m','m'),
 (NULL,NULL,NULL),
 (2,'o','o'),
 (NULL,'r','r'),
 (6,'m','m'),
 (7,'q','q'),
 (6,'c','c');
SELECT grandparent.col_varchar_nokey AS g1
FROM (SELECT * FROM t3) AS grandparent
WHERE grandparent.col_varchar_nokey IN
 (SELECT parent.col_varchar_key AS p1
  FROM (SELECT * FROM t2) AS parent
  WHERE grandparent.col_varchar_key IN (
    SELECT child1.col_varchar_key AS c1
    FROM (SELECT * FROM t1) AS child1
      LEFT JOIN (SELECT * FROM t2) AS child2
      ON child1.col_varchar_nokey <> child2.col_varchar_key
    )
    AND grandparent.col_int_key IS UNKNOWN
  )
ORDER BY grandparent.col_varchar_nokey;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( pk INT, col_blob BLOB ) ENGINE = MyISAM;
CREATE TABLE t2 ( pk INT, col_blob BLOB ) ENGINE = InnoDB;
SELECT pk FROM ( SELECT col_blob, pk FROM t2 ) AS A NATURAL JOIN t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT, b BLOB) ENGINE=InnoDB;
CREATE TABLE t2 (c INT);
CREATE TABLE t3 (d INT);
INSERT INTO t3 VALUES (0);
SELECT * FROM (SELECT * FROM t1) AS a1 RIGHT JOIN t3 LEFT JOIN t2 ON d=c ON a=c;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
 a INTEGER NOT NULL,
 b VARCHAR(1000) NOT NULL,
 c TEXT NOT NULL
)ENGINE=InnoDB;
INSERT INTO t1 VALUES (1, 'xxx', 'abc');
INSERT INTO t1 VALUES (2, 'yyy', 'abc');
INSERT INTO t1 SELECT a, b, c FROM t1 WHERE b='yyy';
INSERT INTO t1 SELECT a, b, c FROM t1 WHERE b='yyy';
INSERT INTO t1 SELECT a, b, c FROM t1 WHERE b='yyy';
CREATE TABLE t2 (
 a INTEGER NOT NULL
)ENGINE=InnoDB;
INSERT INTO t2 VALUES (1), (2);
SELECT a1.a, a1.b, a1.c FROM (SELECT a, b, c FROM t1 ) a1
JOIN t2 ON a1.a=t2.a WHERE a1.b='xxx';
DROP TABLE t2, t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 10), (2, 20);
INSERT INTO t2 VALUES(1, 100), (2, 200);
SELECT *
FROM t1 JOIN (SELECT * FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1, (SELECT * FROM t2) AS dt WHERE t1.a=dt.a;
SELECT *
FROM (t1 JOIN t2 ON t1.a=t2.a) JOIN (SELECT * FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)) AS dt ON t1.a=dt.a;
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN
     (SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)) AS dt
     ON t1.a=dt.a;
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN
     (SELECT t1.a, t2.b FROM t1 JOIN t2 USING (a)) AS dt1
     ON t1.a=dt1.a AND t2.b=dt1.b
     JOIN
     (SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)) AS dt2
     ON dt1.a=dt2.a;
SELECT *
FROM t1 JOIN (SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)
              WHERE t1.b > 15) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2
              WHERE a IN (SELECT a FROM t1)) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 UNION SELECT * FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 UNION ALL SELECT * FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT DISTINCT a, b FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT SUM(a) AS a, SUM(b) AS b FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT a, SUM(b) AS b FROM t2 GROUP BY a) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT 1 AS a FROM t2 HAVING COUNT(*) > 1) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 LIMIT 1) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 LIMIT 2 OFFSET 1) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT 1 AS a) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT a, b, @c:= a+b FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM (SELECT * FROM t2 ORDER BY t2.a) AS dt;
SELECT *
FROM (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt;
SELECT *
FROM (SELECT * FROM t2 ORDER BY t2.a) AS dt
WHERE dt.a > 0;
SELECT *
FROM (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt
WHERE dt.a > 0;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 ORDER BY t2.a) AS dt ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt ON t1.a=dt.a;
SELECT dt.a, COUNT(*)
FROM (SELECT * FROM t2 ORDER BY t2.a) AS dt
GROUP BY dt.a;
SELECT dt.a, COUNT(*)
FROM (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt
GROUP BY dt.a;
SELECT COUNT(*)
FROM (SELECT * FROM t2 ORDER BY t2.a) AS dt;
SELECT COUNT(*)
FROM (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt;
SELECT DISTINCT *
FROM (SELECT * FROM t2 ORDER BY t2.a) AS dt;
SELECT DISTINCT *
FROM (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 ORDER BY t2.a) AS dt ON t1.a=dt.a
ORDER BY t1.b;
SELECT *
FROM t1 JOIN (SELECT * FROM t2 ORDER BY t2.a DESC) AS dt ON t1.a=dt.a
ORDER BY t1.b;
SELECT *
FROM t1 JOIN (SELECT a, (SELECT COUNT(*) FROM t1) AS b FROM t2) AS dt
     ON t1.a=dt.a;
SELECT *
FROM t1 JOIN (SELECT a, (SELECT b) AS b FROM t2) AS dt ON t1.a=dt.a;
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN (SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)) AS dt
     ON t1.a=dt.a;
UPDATE t1 JOIN (SELECT * FROM t2) AS dt ON t1.a=dt.a SET t1.b=t1.b+1;
DELETE t1 FROM t1 JOIN (SELECT * FROM t2) AS dt ON t1.a=dt.a WHERE t1.a=1;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk int NOT NULL,
  col_int_key int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key, col_int_key)
) charset utf8mb4;
INSERT INTO t1 VALUES
(1,4,'j'), (2,6,'v'), (3,3,'c'), (4,5,'m'), (5,3,'d'), (6,246,'d'), (7,2,'y'), (8,9,'t'),
(9,3,'d'), (10,8,'s'), (11,1,'r'), (12,8,'m'), (13,8,'b'), (14,5,'x'), (15,7,'g'), (16,5,'p'),
(17,1,'q'), (18,6,'w'), (19,2,'d'), (20,9,'e');
CREATE TABLE t2 (
  pk int NOT NULL,
  col_int_nokey int NOT NULL,
  col_int_key int NOT NULL,
  col_date_key date NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_date_key (col_date_key)
) charset utf8mb4;
INSERT INTO t2 VALUES (1,1,7,'1900-01-01','k');
CREATE TABLE t3 (
  pk int NOT NULL ,
  col_date_nokey date NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk)
) charset utf8mb4;
INSERT INTO t3 VALUES (10,'1900-01-01','b');
SELECT outr.col_date_key AS x
FROM (SELECT * FROM t1) AS outr2 LEFT JOIN (SELECT * FROM t2) AS outr
     ON outr2.col_varchar_key = outr.col_varchar_nokey
WHERE (outr.col_int_key, outr.col_int_key) IN
       (SELECT innr.pk AS x, innr.pk AS y
        FROM (SELECT * FROM t3) AS innr
        WHERE innr.col_date_nokey IS NOT NULL XOR
              innr.col_varchar_nokey > 'p'
        ORDER BY innr.col_date_nokey) XOR
      (outr.col_int_nokey < 2 OR
       NOT outr.col_int_key IS NULL)
ORDER BY outr.col_int_key,
         outr.pk;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  pk int NOT NULL,
  col_int_nokey int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key(col_varchar_key)
) charset utf8mb4 ENGINE=InnoDB;
INSERT INTO t1 VALUES
 (10,1,'v'), (11,7,'s'), (12,4,'l'), (13,7,'y'), (14,0,'c'), (15,2,'i');
CREATE TABLE t2 (
  pk int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) charset utf8mb4 ENGINE=InnoDB;
INSERT INTO t2 VALUES (1,'k','k');
CREATE TABLE t3 (
  pk int NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk)
) charset utf8mb4 ENGINE=InnoDB;
INSERT INTO t3 VALUES
 (1,'j'), (2,'v'), (3,'c'), (4,'m'), (5,'d');
SELECT table1.pk
FROM (SELECT * FROM t1) AS table1
     LEFT JOIN
       (SELECT * FROM t1) AS table2
       RIGHT OUTER JOIN
       (SELECT * FROM t2) AS table3
       ON table3.col_varchar_nokey = table2.col_varchar_key
     ON table3.pk = table2.col_int_nokey
WHERE table3.col_varchar_key <> ALL
       (SELECT sq1_t1.col_varchar_nokey AS sq1_field1
        FROM (SELECT * FROM t3) AS sq1_t1
             LEFT OUTER JOIN
             (SELECT * FROM t1) AS sq1_t2
             ON sq1_t2.col_varchar_key = sq1_t1.col_varchar_nokey
       ) OR
      table1.pk = 96;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  col_time_nokey time NOT NULL
);
INSERT INTO t1 VALUES ('00:00:00');
CREATE TABLE t2 (
  pk int NOT NULL,
  col_int_nokey int NOT NULL,
  col_int_key int NOT NULL,
  col_date_nokey date NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key(col_int_key),
  KEY col_varchar_key(col_varchar_key, col_int_key)
) charset utf8mb4;
INSERT INTO t2 VALUES
(1,4,0,'0001-01-01','j','j'), (2,6,8,'2004-09-18','v','v'),
(3,3,1,'2009-12-01','c','c'), (4,5,8,'2004-12-17','m','m'),
(5,3,9,'2000-03-14','d','d'), (6,246,24,'2000-10-08','d','d'),
(7,2,6,'2006-05-25','y','y'), (8,9,1,'2008-01-23','t','t'),
(9,3,6,'2007-06-18','d','d'), (10,8,2,'2002-10-13','s','s'),
(11,1,4,'1900-01-01','r','r'), (12,8,8,'0001-01-01','m','m'),
(13,8,4,'2006-03-09','b','b'), (14,5,4,'2001-06-05','x','x'),
(15,7,7,'2006-05-28','g','g'), (16,5,4,'2001-04-19','p','p'),
(17,1,1,'1900-01-01','q','q'), (18,6,9,'2004-08-20','w','w'),
(19,2,4,'2004-10-10','d','d'), (20,9,8,'2000-04-02','e','e');
CREATE TABLE t3 (
  pk int NOT NULL,
  col_int_key int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key, col_int_key)
) charset utf8mb4;
INSERT INTO t3 VALUES
(10,1,'v'), (11,7,'s'), (12,4,'l'), (13,7,'y'), (14,0,'c'),
(15,2,'i'), (16,9,'h'), (17,4,'q'), (18,0,'a'), (19,9,'v'),
(20,1,'u'), (21,3,'s'), (22,8,'y'), (23,8,'z'), (24,18,'h'),
(25,84,'p'), (26,6,'e'), (27,3,'i'), (28,6,'y'), (29,6,'w');
CREATE TABLE t4 (
  pk int NOT NULL,
  col_int_nokey int NOT NULL,
  col_int_key int NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) charset utf8mb4;
INSERT INTO t4 VALUES (10,8,7,'b');
SELECT outr.pk AS x
FROM (SELECT * FROM t1) AS outr2
     LEFT JOIN (SELECT * FROM t2) AS outr
     ON outr2.col_time_nokey >= outr.col_date_nokey
WHERE (outr.col_int_nokey, outr.col_int_key) IN
       (SELECT innr.col_int_key AS x,
               innr.col_int_nokey AS y
        FROM (SELECT * FROM t3) AS innr2
             LEFT JOIN (SELECT * FROM t4) AS innr
             ON innr2.col_varchar_key <> innr.col_varchar_nokey
        WHERE innr.col_int_key <> innr.pk OR innr.pk = 9
       ) AND
       outr.pk < 7 XOR outr.col_varchar_nokey <> 'i'
ORDER BY outr.col_varchar_key, outr.pk;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  pk int NOT NULL
);
CREATE TABLE t2 (
  pk int NOT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key, col_int_key)
);
CREATE TABLE t3 (
  pk int NOT NULL AUTO_INCREMENT,
  col_int_nokey int DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
);
SELECT table1.pk
FROM   t1 AS table1
     RIGHT JOIN
         t2 AS table2
       LEFT OUTER JOIN
         (SELECT sq2_t1.*
          FROM t2 AS sq2_t1 INNER JOIN t3 AS sq2_t2
               ON sq2_t2.col_int_nokey = sq2_t1.col_int_key
          WHERE sq2_t2.col_varchar_nokey <= sq2_t1.col_varchar_key OR
                sq2_t2.col_int_nokey <> 2
         ) AS table3
        ON table3.col_int_key = table2.col_int_key
      ON table3.pk = table2.col_int_key
WHERE table3.pk >= 6 OR
      table1.pk > 68 AND
      table1.pk < ( 68 + 76 );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY
);
INSERT INTO t1 VALUES (0),(1),(2);
CREATE TABLE t2 (
  pk INTEGER PRIMARY KEY
);
INSERT INTO t2 VALUES (0),(1),(2);
SELECT SHA(pk) IN (SELECT * FROM (SELECT '' FROM t2) a) FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk)
) engine=innodb;
CREATE TABLE t2 (
  pk int NOT NULL,
  col_int_key int NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) engine=innodb;
CREATE TABLE t3 (
  pk int NOT NULL,
  PRIMARY KEY (pk)
) engine=innodb;
CREATE TABLE t4 (
  pk int NOT NULL ,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk)
) engine=innodb;
SELECT table2.pk AS field2
FROM (SELECT sq1_t2.pk
      FROM t1 AS sq1_t1
           JOIN
            (t1 AS sq1_t2 RIGHT JOIN t2 AS sq1_t3
             ON sq1_t3.pk = sq1_t2.pk
            )
           ON sq1_t3.col_int_key = sq1_t2.pk AND
              sq1_t1.col_varchar_key IN
             (SELECT child_sq1_t2.col_varchar_key AS child_sq1_field1
              FROM t1 AS child_sq1_t2
             )
     ) AS table1
     LEFT JOIN
     t1 AS table2
       JOIN
       (SELECT sq2_t1.* FROM t1 AS sq2_t1) AS table3
       ON table3.col_varchar_key = table2.col_varchar_key
     ON table3.col_varchar_key = table2.col_varchar_key;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  pk int NOT NULL ,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
);
CREATE TABLE t2 (
  pk int NOT NULL,
  col_int_nokey int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
);
SELECT table1.pk AS field1,
       table2.pk field2
FROM (SELECT sq1_t1.*
      FROM t1 AS sq1_t1
     ) AS table1
     RIGHT JOIN
       (SELECT sq2_t1.*
        FROM t2 AS sq2_t1
        WHERE sq2_t1.col_int_key NOT IN
               (SELECT child_sq1_t1.col_int_key AS child_sq2_field1
                FROM t2 AS child_sq1_t1
               )
       ) AS table2
       RIGHT JOIN t2 AS table3
       ON table3.col_varchar_nokey = table2.col_varchar_key
     ON table3.col_varchar_nokey = table2.col_varchar_key;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk int NOT NULL,
  col_int_nokey int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_date_key (col_date_key),
  KEY col_varchar_key (col_varchar_key, col_int_key)
) charset utf8mb4;
CREATE TABLE t2 (
  pk int NOT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
) charset utf8mb4;
CREATE TABLE t3 (
  pk int NOT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk)
) charset utf8mb4;
SELECT STRAIGHT_JOIN alias1.col_date_key AS field1
FROM t1 AS alias1
     INNER JOIN
     ((SELECT  sq1_alias1.col_varchar_key
       FROM t1 AS sq1_alias1 RIGHT OUTER JOIN t2 AS sq1_alias2
            ON sq1_alias2.pk = sq1_alias1.col_int_key
       WHERE ('n', 'l') IN
          (SELECT
                  c_sq1_alias1.col_varchar_nokey AS c_sq1_field1,
                  c_sq1_alias1.col_varchar_key AS c_sq1_field2
           FROM t3 AS c_sq1_alias1
                INNER JOIN
                 (t1 AS c_sq1_alias2
                  INNER JOIN t1 AS c_sq1_alias3
                  ON c_sq1_alias3.col_varchar_key = c_sq1_alias2.col_varchar_key
                 )
                 ON c_sq1_alias3.pk = c_sq1_alias2.pk
           WHERE c_sq1_alias3.col_int_nokey <> c_sq1_alias2.col_int_nokey
          ) AND
             sq1_alias2.col_varchar_key = 't'
       ) AS alias2
        INNER JOIN t3 AS alias3
        ON alias3.col_varchar_nokey = alias2.col_varchar_key
      )
      ON alias3.col_varchar_key = alias2.col_varchar_key;
DROP TABLE t1, t2, t3;
CREATE TABLE t(a INTEGER);
CREATE VIEW v AS SELECT * FROM t;
PREPARE s1 FROM 'SELECT * FROM v';
PREPARE s2 FROM 'SELECT * FROM (SELECT * FROM t) AS dt';
DEALLOCATE PREPARE s1;
DEALLOCATE PREPARE s2;
DROP VIEW v;
DROP TABLE t;
CREATE TABLE t1
 (pk INTEGER PRIMARY KEY,
  col_int_nokey INTEGER,
  col_varchar_nokey VARCHAR(1),
  col_varchar_key VARCHAR(1),
  KEY col_varchar_key(col_varchar_key)
) charset utf8mb4 engine=innodb;
INSERT INTO t1 (pk) VALUES
 (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
 (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);
CREATE TABLE t2
 (pk INTEGER PRIMARY KEY,
  col_varchar_key VARCHAR(1),
  KEY col_varchar_key(col_varchar_key)
) charset utf8mb4 engine=innodb;
INSERT INTO t2 (pk) VALUES
 (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
 (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);
CREATE TABLE t3
 (pk INTEGER PRIMARY KEY,
  col_varchar_key VARCHAR(1),
  KEY col_varchar_key(col_varchar_key)
) charset utf8mb4 engine=innodb;
INSERT INTO t3 (pk) VALUES
 (1), (2);
SELECT MIN(alias1.col_varchar_nokey) AS field1
FROM (SELECT sq1_alias1.*
      FROM t1 AS sq1_alias1, t1 AS sq1_alias2
      WHERE sq1_alias1.col_varchar_nokey IN
                (SELECT c_sq1_alias2.col_varchar_key AS c_sq1_field1
                 FROM t1 AS c_sq1_alias1 INNER JOIN
                      t1 AS c_sq1_alias2
                      ON c_sq1_alias2.col_varchar_nokey = c_sq1_alias1.col_varchar_key
                 WHERE c_sq1_alias1.col_int_nokey <> c_sq1_alias1.col_int_nokey
                ) AND
            sq1_alias2.pk = sq1_alias1.pk
     ) AS alias1,
     (SELECT sq2_alias1.*
      FROM t2 AS sq2_alias1 RIGHT JOIN
           t3 AS sq2_alias2
           ON sq2_alias2.col_varchar_key = sq2_alias1.col_varchar_key
     ) AS alias2;
DROP TABLE t1, t2, t3;
CREATE TABLE t(id INT PRIMARY KEY,
               c1 INT, c2 INT, key(c2)) engine=InnoDB;
INSERT INTO t(id, c1, c2) VALUES(1, 2, 3), (2, 3, 4), (3, 3, 4), (4, 3, 4);
CREATE VIEW v1 AS SELECT c1 a FROM t WHERE c1 = 3;
CREATE VIEW v2 AS SELECT c2 b FROM t WHERE c2 > 3;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT c1 a FROM t;
DROP VIEW v1, v2;
DROP TABLE t;
CREATE TABLE t1(
  pk INTEGER PRIMARY KEY,
  k INTEGER,
  KEY k(k),
  nk INTEGER);
INSERT INTO t1 VALUES(1, 10, 100), (2, 20, 200);
SELECT t1.k
FROM t1 RIGHT JOIN
     (SELECT t2.*
      FROM t1 AS t2 JOIN t1 AS t3
           ON TRUE
      WHERE t3.k IN (SELECT k FROM t1 AS t4 WHERE k>1)
     ) AS dt
     ON t1.pk = dt.pk;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b VARCHAR(10));
INSERT INTO t1 VALUES (1,'a');
CREATE TABLE t2(c INTEGER);
INSERT INTO t2 VALUES(0);
SELECT 1
FROM (SELECT b FROM t1 WHERE a) AS dt1
     RIGHT JOIN t2
     ON c NOT BETWEEN 1 AND 2
     NATURAL JOIN t1 AS t3;
DROP TABLE t1, t2;
CREATE TABLE t1 (
 pk INTEGER,
 col_varchar JSON NOT NULL,
 PRIMARY KEY (pk)
);
CREATE TABLE t2 (
 pk INTEGER,
 col_date_key DATE NOT NULL,
 PRIMARY KEY (pk)
);
DROP TABLE t1, t2;
CREATE TABLE t1 (
  c1n varchar(1) NOT NULL,
  c1k varchar(2) DEFAULT NULL,
  KEY c1k (c1k)
);
INSERT INTO t1 VALUES ('j','jj'),('r','rr');
CREATE TABLE t2 (
  c2k varchar(1) NOT NULL,
  c2n varchar(2) DEFAULT NULL,
  KEY c2k (c2k)
);
INSERT INTO t2 VALUES
('f','ff'),('t','tt'),('c','cc'),('c','cc'),('r','rr'),('k','kk');
CREATE TABLE `empty` (dummy INTEGER);
CREATE VIEW vr AS
SELECT t2.c2n AS v_field
FROM t1 RIGHT JOIN t2
     ON t2.c2k = t1.c1k;
CREATE VIEW vl AS
SELECT t2.c2n AS v_field
FROM t2 LEFT JOIN t1
     ON t2.c2k = t1.c1k;
SELECT alias1.dt_field AS field1
FROM (SELECT t2.c2n AS dt_field
      FROM t1 RIGHT JOIN t2
           ON t2.c2k = t1.c1k
     ) AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.dt_field;
SELECT alias1.dt_field AS field1
FROM (SELECT t2.c2n AS dt_field
      FROM t2 LEFT JOIN t1
           ON t2.c2k = t1.c1k
     ) AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.dt_field;
SELECT alias1.v_field AS field1
FROM vl AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.v_field;
SELECT alias1.v_field AS field1
FROM vr AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.v_field;
SELECT alias1.dt_field AS field1
FROM (SELECT t2.c2n AS dt_field
      FROM t1 RIGHT JOIN
             (`empty` RIGHT JOIN t2
              ON TRUE)
           ON t2.c2k = t1.c1k
     ) AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.dt_field;
SELECT alias1.dt_field AS field1
FROM (SELECT t2.c2n AS dt_field
      FROM t1 RIGHT JOIN
             (t2 LEFT JOIN `empty`
              ON TRUE)
           ON t2.c2k = t1.c1k
     ) AS alias1
     RIGHT JOIN t2 AS alias2
     ON alias2.c2n = alias1.dt_field;
DROP VIEW vl, vr;
DROP TABLE t1, t2, `empty`;
CREATE TABLE t1 (id INTEGER PRIMARY KEY, d INTEGER);
INSERT INTO t1 VALUES(1, 10), (2, 20);
DELETE FROM t1
WHERE id IN (SELECT * FROM (SELECT id FROM t1) AS dt);
INSERT INTO t1 VALUES(1, 10), (2, 20);
UPDATE t1 SET d= NULL
WHERE id IN (SELECT * FROM (SELECT id FROM t1) AS dt);
INSERT INTO t1 SELECT id+10, d FROM t1;
INSERT INTO t1 SELECT id+20, d FROM (SELECT * FROM t1) AS dt;
DROP TABLE t1;
CREATE TABLE t1 (
  t1_rowid bigint unsigned NOT NULL,
  t1_co varchar(1) NOT NULL,
  t1_inv_date char(3) NOT NULL,
  UNIQUE KEY rowid (t1_rowid),
  KEY invdate (t1_co, t1_inv_date)
) charset latin1;
INSERT INTO t1 VALUES (505975,'D','s:1'),(505981,'D','s:1'),(505869,'D','s:3');
CREATE TABLE t2 (
  t2_rowid bigint unsigned NOT NULL,
  t2_end_date char(3) NOT NULL,
  UNIQUE KEY rowid (t2_rowid),
  KEY end_date (t2_end_date)
) charset latin1;
INSERT INTO t2 VALUES (9,'_:L'), (10,'_<2'), (11,'_<N');
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, KEY(a));
INSERT INTO t1 VALUES  (1), (NULL);
CREATE TABLE t2 (b INT, KEY(b));
INSERT INTO t2 VALUES (7), (NULL), (1), (5), (8), (6), (4), (0), (3), (NULL);
CREATE TABLE t3 (c INT);
INSERT INTO t3 VALUES (NULL), (1), (5);
SELECT * FROM t1 LEFT JOIN (
  SELECT t3.* FROM t2 INNER JOIN t3 ON b = c
) AS sq ON a <= sq.c;
DROP TABLE t1, t2, t3;
CREATE TABLE users (
 id int unsigned AUTO_INCREMENT,
 name varchar(255),
 position int DEFAULT NULL,
 PRIMARY KEY (id));
INSERT INTO users (name, position) VALUES
 ('user1','1'), ('user2','2'), ('user3','3'), ('user4','4'), ('user5','5');
UPDATE users
SET position = (SELECT COUNT(pos) + 1
                FROM (SELECT DISTINCT position AS pos FROM users) AS t2
                WHERE t2.pos < users.position)
WHERE id = 3;
UPDATE users
SET position = (SELECT COUNT(pos) + 1
                FROM (SELECT position AS pos FROM users) AS t2
                WHERE t2.pos < users.position)
WHERE id = 3;
UPDATE users, (SELECT 1) AS dummy
SET position = (SELECT COUNT(pos) + 1
                FROM (SELECT DISTINCT position AS pos FROM users) AS t2
                WHERE t2.pos < users.position)
WHERE id = 3;
UPDATE users, (SELECT 1) AS dummy
SET position = (SELECT COUNT(pos) + 1
                FROM (SELECT position AS pos FROM users) AS t2
                WHERE t2.pos < users.position)
WHERE id = 3;
DROP TABLE users;
CREATE TABLE t(a INTEGER) engine=innodb;
INSERT INTO t VALUES(1);
SELECT (SELECT 1 FROM (SELECT 1 FROM t WHERE SUM(1)) AS t);
SELECT (SELECT 1 FROM (SELECT 1 FROM t WHERE SUM(0)) AS t);
DROP TABLE t;
CREATE TABLE t1 (id INTEGER, d1 INTEGER);
CREATE TABLE t2 (id INTEGER, d2 INTEGER);
DELETE t1, t2
FROM t1 LEFT JOIN t2 ON t1.id = t2.id
WHERE t1.id IN (SELECT * FROM (SELECT id FROM t1) AS t1sub);
DROP TABLE t1, t2;
CREATE TABLE t1
(integer1 INTEGER NULL,
 integer2 INTEGER NULL,
 varchar1 VARCHAR(255) NULL);
CREATE TABLE t2
(integer1 INTEGER NULL,
 integer2 INTEGER NULL,
 varchar1 VARCHAR(255) NULL,
 varchar2 VARCHAR(255) NULL);
INSERT INTO t1 VALUES
 (11,12,'test1'), (21,22,'test2'), (31,32,'test3');
INSERT INTO t2 VALUES
 (11,12,'test1','test12'), (21,22,'test2','test22'), (31,32,'test3','test32');
SELECT g_t3.g_f1, g_t3.g_f2, g_t3.g_f3
FROM (SELECT g_t0.integer1 AS g_f1,
             g_t0.integer2 AS g_f2,
             g_t0.varchar1 AS g_f3
      FROM t1 g_t0
     ) g_t3
GROUP BY g_t3.g_f1, g_t3.g_f2, g_t3.g_f3
HAVING g_t3.g_f3 = (select varchar1
                    from t2
                    where integer1 = g_t3.g_f1
                    );
DROP TABLE t1, t2;
CREATE TABLE K (col_int int(11), col_varchar varchar(255)) charset latin1;
INSERT INTO K VALUES (NULL,'m'), (NULL,'z');
CREATE TABLE H (col_varchar varchar(255)) charset latin1;
INSERT INTO H VALUES ('m'), ('z');
SELECT t1.col_int
FROM (SELECT * FROM K) t1 JOIN (SELECT * FROM H) t2 USING(col_varchar)
WHERE t1.col_int IS NULL
ORDER BY t1.col_int;
DROP TABLE K, H;
CREATE TABLE t1 (c11 int);
INSERT INTO t1 VALUES (1);
SELECT *
FROM (SELECT (1) alias1,
             (SELECT alias1) alias2
      FROM t1) X;
SELECT alias2
FROM (SELECT (1) alias1,
             (SELECT alias1) alias2
      FROM t1) X;
DROP TABLE t1;
CREATE TABLE t1 (
  col_varchar_key varchar(1) ,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
CREATE TABLE t2 (
  col_int int(11) ,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar varchar(1) ,
  col_varchar_key varchar(1) ,
  PRIMARY KEY (pk)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (4,1,'s','r'), (9,19,'p','a');
CREATE TABLE t3 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) ,
  col_varchar_key varchar(1) ,
  col_varchar varchar(1) ,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
INSERT INTO t3 VALUES (100,2,'g',NULL);
SELECT table1.col_int
FROM t3 AS table1
  LEFT JOIN (
      SELECT subquery1_t1.*
      FROM t1 AS subquery1_t1
        RIGHT JOIN t2 AS subquery1_t2
        ON (subquery1_t2.col_varchar_key = subquery1_t1.col_varchar_key)
    ) AS table3
    ON (table3.col_varchar_key = table1.col_varchar_key)
WHERE table3.col_varchar_key  IN (
  SELECT subquery2_t3.col_varchar
  FROM t3 AS subquery2_t3
  WHERE subquery2_t3.pk < table3.pk
);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  col_int int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (0,1,'i','n',125);
INSERT INTO t1 VALUES (3,20,'b','o',0);
CREATE TABLE t2 (
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (3,'y','p',4,1);
CREATE TABLE t3 (
  col_int int(11) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;
CREATE TABLE t4 (  col_int int(11) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=MyISAM;
INSERT INTO t4 VALUES (7,'k',9,'z',20);
SELECT
  table2.col_int_key AS field3
FROM
  (
    SELECT subquery2_t2.*
    FROM t1 AS subquery2_t1
      INNER JOIN t2 AS subquery2_t2
      ON (subquery2_t2.pk = subquery2_t1.col_int)
  ) AS table1
    RIGHT OUTER JOIN (
      SELECT subquery3_t1.*
      FROM t2 AS subquery3_t1
    ) AS table2
    ON (table1.col_varchar_key = table2.col_varchar_key)
WHERE table1.col_varchar_key IN (
  SELECT subquery4_t1.col_varchar AS subquery4_field1
  FROM t3 AS subquery4_t1);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER);
UPDATE t1
SET a=5
WHERE a IN (SELECT a FROM t2
            ORDER BY (SELECT a FROM (SELECT SUM(a) FROM t1) AS dt));
DROP TABLE t1, t2;
CREATE TABLE t1 (t1_id INT PRIMARY KEY);
CREATE TABLE t2 (t2_id INT, t1_id INT);
INSERT INTO t1 VALUES (-1), (1);
INSERT INTO t2 SELECT t1_id, t1_id FROM t1;
SELECT * FROM t2 AS ot
WHERE
( SELECT t1_id AS it1
  FROM ( SELECT * FROM t1 AS it2
         WHERE t1_id = ( SELECT t1_id
                         FROM ( SELECT * FROM t2 AS it3
                                WHERE t2_id=ot.t2_id
                              ) AS dt1
                       )
       ) AS dt2
) IS NOT NULL;
SELECT * FROM t2 AS ot
WHERE
( SELECT t1_id AS it1
  FROM ( SELECT * FROM t1 AS it2
         WHERE t1_id = ( SELECT /*+ NO_MERGE() */ t1_id
                         FROM ( SELECT * FROM t2 AS it3
                                WHERE t2_id=ot.t2_id
                              ) AS dt1
                       )
       ) AS dt2
) IS NOT NULL;
DROP TABLE t1,t2;
CREATE TABLE tbl1 (
  id BIGINT NOT NULL,
  rec_id INTEGER NOT NULL,
  id_value2 BIGINT DEFAULT NULL,
  PRIMARY KEY (id, rec_id)
) ENGINE=INNODB;
CREATE TABLE tbl2 (
  t_id BIGINT NOT NULL,
  s_date DATETIME DEFAULT NULL,
  PRIMARY KEY (t_id)
) ENGINE=INNODB;
SELECT t1.rec_id
FROM tbl1 AS t1 INNER JOIN
       (SELECT a.id, a.rec_id,s_date
        FROM tbl2 AS b, tbl1 AS a
        WHERE a.id_value2 = b.t_id AND a.id = 6889877970355107670
        ORDER BY s_date DESC) t2
     ON t1.id = t2.id AND t1.rec_id = t2.rec_id;
UPDATE tbl1 AS t1 INNER JOIN
       (SELECT a.id, a.rec_id, b.s_date
        FROM tbl2 AS b, tbl1 AS a
        WHERE a.id_value2 = b.t_id AND a.id = 6889877970355107670
        ORDER BY s_date DESC) t2
       ON t1.id = t2.id AND t1.rec_id = t2.rec_id
SET t1.rec_id = @ROWNUM:= @ROWNUM+1;
DROP TABLE tbl1, tbl2;
CREATE TABLE t1 (
  c1 varchar(10) DEFAULT NULL,
  c2 datetime DEFAULT NULL,
  c3 varchar(255) DEFAULT NULL,
  c4 varchar(255) DEFAULT NULL,
  pk int NOT NULL,
  c5 varchar(255) DEFAULT NULL,
  c6 date DEFAULT NULL,
  c7 int DEFAULT NULL,
  c8 date DEFAULT NULL,
  c9 varchar(255) DEFAULT NULL,
  c10 int DEFAULT NULL,
  c11 varchar(10) DEFAULT NULL,
  c12 varchar(10) DEFAULT NULL,
  c13 datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY k5 (c5)
) engine=innodb;
INSERT INTO t1 VALUES
('gjnhugwevl','1000-01-01 00:00:00','m','UJVFB',2,'j','1000-01-01',208797696,'1000-01-01','LRNWI',NULL,'look','ISVAL','2001-03-02 00:00:00'),
('nhugwevltb','1000-01-01 00:00:00','m','h',3,'can\'t','2004-06-07',2052784128,'2000-12-19','r',NULL,'ugwevltbgy','something','1000-01-01 00:00:00');
CREATE TABLE t2 (
  c1 varchar(255) DEFAULT NULL,
  c2 varchar(10) DEFAULT NULL,
  c3 int DEFAULT NULL,
  c4 datetime DEFAULT NULL,
  c5 varchar(10) DEFAULT NULL,
  c6 varchar(255) DEFAULT NULL,
  c7 varchar(255) DEFAULT NULL,
  c8 varchar(255) DEFAULT NULL,
  c9 varchar(10) DEFAULT NULL,
  c10 datetime DEFAULT NULL,
  pk int NOT NULL,
  c11 date DEFAULT NULL,
  c12 int DEFAULT NULL,
  PRIMARY KEY (pk)
) engine=innodb;
INSERT INTO t2 VALUES
('be','njhqcbglns',NULL,'2002-07-20 19:40:02','YHBGN','go','NSPET','j','MKFNT','2007-08-25 14:41:26',1,'2002-04-21',6),
('b','glnspcqnog',2,'1000-01-01 00:00:00','YEJTV','on','z','PPPCH','YRXFT','1000-01-01 00:00:00',4,'2003-07-25',0),
('c','qnogpabsxs',6,'1000-01-01 00:00:00','nogpabsxsr','b','we','og','e','2000-11-01 15:48:07',7,'1000-01-01',3),
('OFZJT','was',6,'2007-01-14 21:01:33','as','was','r','a','but','2009-01-20 17:58:56',9,'2005-02-14',7),
('d','bsxsrumtna',9,'1000-01-01 00:00:00','would','he','o','VESLR','sxsrumtnab','2007-09-25 12:13:37',10,'2005-02-11',772472832);
SELECT field1
FROM (SELECT alias1.c5 AS field1,
             alias1.c13 AS field2,
             alias1.c1 AS field4
      FROM t1 AS alias1 RIGHT JOIN t2 AS alias2
           ON alias1.pk = alias2.c12
      ORDER BY field2
     ) as dt;
SELECT field1
FROM (SELECT *
      FROM (SELECT alias1.c5 AS field1,
                   alias1.c13 AS field2,
                   alias1.c1 AS field4
            FROM t1 AS alias1 RIGHT JOIN t2 AS alias2
                 ON alias1.pk = alias2.c12
            ORDER BY field2
           ) AS dt_inner
     ) AS dt_outer;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  c1 INTEGER DEFAULT NULL,
  c2 INTEGER DEFAULT NULL,
  PRIMARY KEY (pk)
);
CREATE TABLE t2 (
  c1 integer DEFAULT NULL
);
prepare s from "
SELECT field1
FROM (SELECT alias1.c1 AS field1,
             alias1.c2 AS field2
      FROM t1 AS alias1 RIGHT JOIN t2 AS alias2
           ON alias1.pk = alias2.c1
      ORDER BY field2) as dt";
DROP TABLE t1, t2;
CREATE TABLE t1 (i int);
SELECT t1.i
FROM t1
WHERE FALSE AND
      t1.i > (SELECT MAX(a)
              FROM (SELECT 8 AS a UNION SELECT 3) AS tt);
DROP TABLE t1;
CREATE TABLE t(
  w INTEGER NOT NULL,
  h INTEGER NOT NULL,
  u SMALLINT NOT NULL,
  PRIMARY KEY (u)
);
INSERT INTO t VALUES(1,2,3),(3,4,5),(6,6,7);
PREPARE s FROM "
SELECT dtaa.c AS c
FROM (SELECT 1 AS c
      FROM (SELECT 1 AS c
            FROM t AS ta RIGHT JOIN t AS tb ON ta.u  <= ?
            WHERE 1 OR ?
            GROUP BY ta.u
           ) AS dta
           INNER JOIN t AS tbb
           ON dta.c = tbb.h
     ) AS dtaa
     RIGHT JOIN t AS tbbb
     ON dtaa.c or w";
DEALLOCATE PREPARE s;
DROP TABLE t;
CREATE TABLE t1 ( a INTEGER ) Engine=InnoDB;
INSERT INTO t1 VALUES (123);
SELECT * FROM t1 LEFT JOIN ( SELECT 1 FROM t1 ) d1 ON TRUE ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 (a LONGTEXT);
INSERT INTO t1 VALUES ('');
CREATE TABLE t2 (b INTEGER);
INSERT INTO t2 VALUES (0);
DROP TABLE t1, t2;
CREATE TABLE t1
 (a INTEGER,
  b INTEGER,
  c INTEGER
 );
INSERT INTO t1 VALUES
 (1, 1, 10), (1, 2, 20), (1, 3, 30), (2, 1, 40), (2, 2, 50), (2, 3, 60);
CREATE TABLE t2
 (a INTEGER,
  d INTEGER,
  e INTEGER
 );
INSERT INTO t2 VALUES
 (1, 6, 60), (2, 6, 60), (3, 6, 60);
DROP TABLE t1, t2;
CREATE TABLE t1 (a INTEGER);
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 (a, b) VALUES (777, a);
INSERT INTO t1 (a, b) VALUES (888, (SELECT a));
INSERT INTO t1 (a, b) VALUES (999, (SELECT a UNION SELECT a));
SELECT a, b FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (f1 LONGTEXT, f2 INTEGER);
INSERT INTO t1 VALUES (NULL, NULL), (1,2);
SELECT f1
FROM (SELECT *
      FROM (SELECT t1.*
            FROM t1 LEFT JOIN t1 AS t2
                 ON (t1.f1 = t2.f1)) AS dt1 ORDER BY f1 asc) AS dt2;
DROP TABLE t1;
CREATE TABLE t1
 (a LONGTEXT,
  b BIGINT DEFAULT NULL,
  c DOUBLE DEFAULT NULL,
  d DATETIME DEFAULT NULL)
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO t1 VALUES
(NULL,NULL,NULL,NULL),('Cat1',0,0.5,'2013-06-10 11:10:10'),
('Cat2',1,1.5,'2013-06-11 12:11:11'),('Cat1',2,2.5,'2013-06-12 13:12:12'),
('Cat2',3,3.5,'2013-06-13 14:13:13'),('Cat1',4,4.5,'2013-06-14 15:14:14'),
('Cat2',5,5.5,'2013-06-15 16:15:15'),('Cat1',6,6.5,'2013-06-16 17:16:16'),
('Cat2',7,7.5,'2013-06-17 18:17:17'),('Cat1',8,8.5,'2013-06-18 19:18:18');
SELECT a, b
FROM (SELECT a, b, count1, count2
      FROM (SELECT dt3.a, dt3.b, dt3.count1, count2
            FROM (SELECT dt1.a, dt1.b, count1
                  FROM (SELECT a, b
                        FROM (SELECT a, b FROM t1) AS dt GROUP BY a, b) AS dt1
                       LEFT JOIN
                       (SELECT a, COUNT(*) AS count1 FROM t1 GROUP BY a) AS dt2
                       ON (dt2.a = dt1.a)) AS dt3
                 LEFT JOIN
                 (SELECT a, COUNT(*) AS count2
                  FROM (SELECT a FROM t1) AS dt5 GROUP BY a) AS dt4
                 ON (dt3.a = dt4.a)) AS dt5
      ORDER BY count1 desc, a, count2 desc, b) AS dt6;
DROP TABLE t1;
