create table t1 (a int not null);
insert into t1 values (1);
insert into t1 values (a+2);
insert into t1 values (a+3),(a+4);
insert into t1 values (5),(a+6);
select * from t1;
drop table t1;
create table t1 (id int not null auto_increment primary key, username varchar(32) not null, unique (username));
insert into t1 values (0,"mysql");
insert into t1 values (0,"mysql ab");
insert into t1 values (0,"mysql a");
insert into t1 values (0,"r1manic");
insert into t1 values (0,"r1man");
drop table t1;
create table t1 (a int not null auto_increment, primary key (a), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, c char(10) default "hello", i int);
select a,t>0,c,i from t1;
insert into t1 set a=default,t=default,c=default;
insert into t1 set a=default,t=default,c=default,i=default;
insert into t1 set a=default,t=default,c=default,i=default;
select a,t>0,c,i from t1;
drop table t1;
create table t1 (id int NOT NULL DEFAULT 8);
select * from t1;
drop table t1;
create table t1 (email varchar(50));
create table t2(id int not null auto_increment primary key, t2 varchar(50), unique(t2));
insert into t2 (t2) select distinct substring(email, locate('@', email)+1) from t1;
select id from t2;
select t2 from t2;
drop table t1,t2;
create database mysqltest;
create table t1 (c int);
drop database mysqltest;
drop table t1;
create table t1(id1 int not null auto_increment primary key, t char(12));
create table t2(id2 int not null, t char(12));
create table t3(id3 int not null, t char(12), index(id3));
select count(*) from t2;
insert into  t2 select t1.* from t1, t2 t, t3 where  t1.id1 = t.id2 and t.id2 = t3.id3;
select count(*) from t2;
drop table t1,t2,t3;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 1);
DROP TABLE t1;
create table t1 (a int, b int);
insert into t1 (a,b) values (a,b);
insert into t1 SET a=1, b=a+1;
insert into t1 (a,b) select 1,2;
INSERT INTO t1 ( a ) SELECT 0 ON DUPLICATE KEY UPDATE a = a + VALUES (a);
drop table t1;
create table t1 (id int primary key, data int);
insert into t1 values (1, 1), (2, 2), (3, 3);
select row_count();
insert ignore into t1 values (1, 1);
select row_count();
select row_count();
select row_count();
insert into t1 values (2, 2) on duplicate key update data= data + 10;
select row_count();
insert into t1 values (5, 5) on duplicate key update data= data + 10;
select row_count();
drop table t1;
create table t1 (f1 int unique, f2 int);
create table t2 (f3 int, f4 int);
create view v1 as select * from t1, t2 where f1= f3;
insert into t1 values (1,11), (2,22);
insert into t2 values (1,12), (2,24);
select * from t1;
select * from t1;
drop view v1;
drop table t1,t2;
CREATE TABLE t1 (
  a char(20) NOT NULL,
  b char(7) DEFAULT NULL,
  c char(4) DEFAULT NULL
);
INSERT INTO t1(a,b,c) VALUES (9.999999e+0, 9.999999e+0, 9.999e+0);
INSERT INTO t1(a,b) VALUES (1.225e-04, 1.225e-04);
INSERT INTO t1(a,b) VALUES (1.225e-01, 1.225e-01);
INSERT INTO t1(a,b) VALUES (1.225877e-01, 1.225877e-01);
INSERT INTO t1(a,b) VALUES (1.225e+01, 1.225e+01);
INSERT INTO t1(a,b,c) VALUES (1.225e+01, 1.225e+01, 1.225e+01);
INSERT INTO t1(a,b) VALUES (1.225e+05, 1.225e+05);
INSERT INTO t1(a,b) VALUES (1.225e+10, 1.225e+10);
INSERT INTO t1(a,b) VALUES (1.225e+15, 1.225e+15);
INSERT INTO t1(a,b) VALUES (5000000e+0, 5000000e+0);
INSERT INTO t1(a,b) VALUES (1.25e+78, 1.25e+78);
INSERT INTO t1(a,b) VALUES (1.25e-94, 1.25e-94);
INSERT INTO t1(a,b) VALUES (1.25e+203, 1.25e+203);
INSERT INTO t1(a,b) VALUES (1.25e-175, 1.25e-175);
INSERT INTO t1(a,c) VALUES (1.225e+0, 1.225e+0);
INSERT INTO t1(a,c) VALUES (1.37e+0, 1.37e+0);
INSERT INTO t1(a,c) VALUES (-1.37e+0, -1.37e+0);
INSERT INTO t1(a,c) VALUES (-1.87e-2, -1.87e-2);
INSERT INTO t1(a,c) VALUES (5000e+0, 5000e+0);
INSERT INTO t1(a,c) VALUES (-5000e+0, -5000e+0);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  a char(20) NOT NULL,
  b char(7) DEFAULT NULL,
  c char(5)
);
INSERT INTO t1(a,b,c) VALUES (9.999999e+0, 9.999999e+0, 9.999e+0);
INSERT INTO t1(a,b,c) VALUES (1.225e-05, 1.225e-05, 1.225e-05);
INSERT INTO t1(a,b) VALUES (1.225e-04, 1.225e-04);
INSERT INTO t1(a,b) VALUES (1.225e-01, 1.225e-01);
INSERT INTO t1(a,b) VALUES (1.225877e-01, 1.225877e-01);
INSERT INTO t1(a,b) VALUES (1.225e+01, 1.225e+01);
INSERT INTO t1(a,b,c) VALUES (1.225e+01, 1.225e+01, 1.225e+01);
INSERT INTO t1(a,b) VALUES (1.225e+05, 1.225e+05);
INSERT INTO t1(a,b) VALUES (1.225e+10, 1.225e+10);
INSERT INTO t1(a,b) VALUES (1.225e+15, 1.225e+15);
INSERT INTO t1(a,b) VALUES (5000000e+0, 5000000e+0);
INSERT INTO t1(a,b) VALUES (1.25e+78, 1.25e+78);
INSERT INTO t1(a,b) VALUES (1.25e-94, 1.25e-94);
INSERT INTO t1(a,b) VALUES (1.25e+203, 1.25e+203);
INSERT INTO t1(a,b) VALUES (1.25e-175, 1.25e-175);
INSERT INTO t1(a,c) VALUES (1.225e+0, 1.225e+0);
INSERT INTO t1(a,c) VALUES (1.37e+0, 1.37e+0);
INSERT INTO t1(a,c) VALUES (-1.37e+0, -1.37e+0);
INSERT INTO t1(a,c) VALUES (1.87e-3, 1.87e-3);
INSERT INTO t1(a,c) VALUES (-1.87e-2, -1.87e-2);
INSERT INTO t1(a,c) VALUES (5000e+0, 5000e+0);
INSERT INTO t1(a,c) VALUES (-5000e+0, -5000e+0);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t (a CHAR(10),b INT);
INSERT INTO t VALUES (),(),();
DROP TABLE t;
CREATE TABLE t1 (c1 INT NOT NULL);
INSERT INTO t1 VALUES(4188.32999999999992724042385816574096679687500),
('4188.32999999999992724042385816574096679687500'), (4188);
SELECT * FROM t1;
CREATE TABLE t2 (c1 BIGINT);
INSERT INTO t2 VALUES('15449237462.0000000000');
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1(f1 FLOAT);
INSERT INTO t1 VALUES (1.23);
CREATE TABLE t2(f1 CHAR(1));
INSERT INTO t2 SELECT f1 FROM t1;
DROP TABLE t1, t2;
create table t1 (data varchar(4) not null);
drop table t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1( a INT );
INSERT DELAYED INTO t1 VALUES ( 1 );
DROP TABLE t1;
CREATE TABLE t1(a INTEGER);
DROP TABLE t1;
CREATE TABLE t (a INT PRIMARY KEY);
INSERT IGNORE INTO t VALUES (1);
INSERT IGNORE INTO t VALUES (1),(1);
DROP TABLE t;
CREATE TABLE t1(pk INTEGER PRIMARY KEY, a INTEGER);
CREATE TABLE t2(pk INTEGER PRIMARY KEY, a INTEGER);
CREATE TABLE t3(a INTEGER);
CREATE TABLE t4(b INTEGER);
INSERT INTO t2 VALUES(1, 10), (2, 20), (3, 30), (4, 40);
INSERT INTO t3 VALUES(1), (3);
INSERT INTO t4 VALUES(1);
CREATE VIEW v1 AS
SELECT * FROM t1 WHERE pk IN (SELECT a FROM t3);
CREATE VIEW v2 AS
SELECT * FROM t2 WHERE pk IN (SELECT a FROM t3);
CREATE VIEW v3 AS
SELECT t1.pk,t1.a FROM t1 JOIN t4 ON pk IN (SELECT a FROM t3);
INSERT INTO v1
SELECT * FROM v2;
DELETE FROM t1;
INSERT INTO v3(pk,a)
SELECT * FROM v2;
DELETE FROM t1;
INSERT INTO v1
SELECT dt.pk, v2.a
FROM (SELECT * FROM v2) AS dt JOIN v2 ON dt.pk=v2.pk;
DROP VIEW v1, v2, v3;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(b INTEGER);
CREATE VIEW v AS SELECT * FROM t1 JOIN t2 ON TRUE;
INSERT INTO v(a) VALUES(1);
INSERT INTO v(b) VALUES(1);
INSERT INTO v(a) SELECT 2;
INSERT INTO v(b) SELECT 2;
SELECT * FROM t1;
SELECT * FROM t2;
DROP VIEW v;
DROP TABLE t1, t2;
CREATE TABLE t1(a1 INTEGER PRIMARY KEY, b1 INTEGER);
CREATE TABLE t2(a2 INTEGER PRIMARY KEY, b2 INTEGER);
CREATE VIEW v AS SELECT * FROM t1 JOIN t2 ON TRUE;
INSERT INTO v(a1,b1) VALUES (11, 0) ON DUPLICATE KEY UPDATE b1=b1+1;
INSERT INTO v(a1,b1) VALUES (11, 0) ON DUPLICATE KEY UPDATE b1=b1+1;
INSERT INTO v(a2,b2) VALUES (21, 0) ON DUPLICATE KEY UPDATE b2=b2+1;
INSERT INTO v(a2,b2) VALUES (21, 0) ON DUPLICATE KEY UPDATE b2=b2+1;
SELECT * FROM v;
DELETE FROM t1;
DELETE FROM t2;
INSERT INTO v(a1,b1) SELECT 11, 0 ON DUPLICATE KEY UPDATE b1=b1+1;
INSERT INTO v(a1,b1) SELECT 11, 0 ON DUPLICATE KEY UPDATE b1=b1+1;
INSERT INTO v(a2,b2) SELECT 21, 0 ON DUPLICATE KEY UPDATE b2=b2+1;
INSERT INTO v(a2,b2) SELECT 21, 0 ON DUPLICATE KEY UPDATE b2=b2+1;
SELECT * FROM v;
DROP VIEW v;
DROP TABLE t1, t2;
CREATE TABLE t1(a INTEGER);
CREATE VIEW v1 AS SELECT a FROM t1 ORDER BY a;
INSERT INTO v1 SELECT 3;
INSERT INTO v1 VALUES(3);
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 ( pk INT, PRIMARY KEY (pk));
CREATE TABLE t2 LIKE t1;
INSERT INTO t1 VALUES (2);
INSERT INTO t2 VALUES (2);
CREATE VIEW v1 AS SELECT * FROM t2 AS a
                  WHERE a.pk IN ( SELECT pk FROM t1 AS b WHERE b.pk = a.pk );
CREATE VIEW v2 AS SELECT * FROM t1 AS a
                  WHERE a.pk IN ( SELECT pk FROM v1 AS b WHERE b.pk = a.pk );
PREPARE st1 FROM 'INSERT INTO v2 (pk) VALUES ( 1 )';
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2;
DROP VIEW v1, v2;
CREATE TABLE t1 (pk INT, PRIMARY KEY (pk));
INSERT INTO t1 VALUES (1);
CREATE ALGORITHM = TEMPTABLE VIEW v2 AS
   SELECT * FROM t1 AS a NATURAL JOIN t1 b WHERE pk BETWEEN 1 AND 2;
CREATE ALGORITHM = UNDEFINED VIEW v1 AS
   SELECT * FROM t1 AS a
   WHERE a.pk IN ( SELECT pk FROM v2 AS b WHERE b.pk = a.pk );
PREPARE st1 FROM "INSERT INTO v1 (pk) VALUES (2)";
SELECT * FROM t1;
DROP VIEW v1, v2;
DROP TABLE t1;
CREATE TABLE t1 (fld1 INT PRIMARY KEY) ENGINE=INNODB;
CREATE TABLE t2 (fld2 INT, FOREIGN KEY (fld2) REFERENCES t1 (fld1))
ENGINE=INNODB;
INSERT INTO t1 VALUES(0);
INSERT INTO t2 VALUES(0);
INSERT IGNORE INTO t2 VALUES(1);
UPDATE IGNORE t2 SET fld2=20 WHERE fld2=0;
UPDATE IGNORE t1 SET fld1=20 WHERE fld1=0;
UPDATE IGNORE t1, t2 SET t2.fld2= t2.fld2 + 3;
UPDATE IGNORE t1, t2 SET t1.fld1= t1.fld1 + 3;
DROP TABLE t2, t1;
CREATE TABLE t1 (fld1 INT PRIMARY KEY) ENGINE= INNODB;
CREATE TABLE t2 (fld1 VARCHAR(10), fld2 INT NOT NULL,
CONSTRAINT fk FOREIGN KEY (fld2) REFERENCES t1(fld1)) ENGINE= INNODB;
INSERT IGNORE INTO t2 VALUES('abc', 2) ON DUPLICATE KEY UPDATE fld1= 'def';
DROP TABLE t2, t1;
CREATE DATABASE meow;
CREATE TABLE table_target   ( mexs_id CHAR(8), messzeit TIMESTAMP, PRIMARY KEY (mexs_id));
CREATE TABLE table_target2  ( mexs_id CHAR(8), messzeit TIMESTAMP, PRIMARY KEY (mexs_id));
CREATE TABLE table_target3  ( mexs_id CHAR(8), messzeit TIMESTAMP, PRIMARY KEY (mexs_id));
CREATE VIEW view_target2 AS SELECT mexs_id,messzeit FROM table_target2;
CREATE SQL SECURITY INVOKER VIEW view_target3 AS SELECT mexs_id,messzeit FROM table_target3;
CREATE TABLE table_countries ( country CHAR(2), iso_short_en VARCHAR(64), PRIMARY KEY (country));
INSERT INTO table_countries VALUES ('YY','Entenhausen');
CREATE TABLE table_stations ( mexs_id VARCHAR(8), icao VARCHAR(4), country CHAR(2), PRIMARY KEY (mexs_id), UNIQUE KEY icao (icao), KEY country (country), CONSTRAINT stations_ibfk_8 FOREIGN KEY (country) REFERENCES table_countries (country) ON UPDATE CASCADE);
INSERT INTO table_stations VALUES ('87654321','XXXX','YY');
CREATE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW view_stations AS select table_stations.mexs_id AS mexs_id, table_stations.icao AS icao, table_stations.country AS landescode from (table_stations join table_countries on((table_stations.country = table_countries.country)));
CREATE TABLE table_source ( id varchar(4), datetime TIMESTAMP, PRIMARY KEY (id));
INSERT INTO  table_source VALUES ('XXXX','2006-07-12 07:50:00');
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       table_target AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       view_target2 AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       view_target3 AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       table_target AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       view_target2 AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       view_target2 AS old
USING           (mexs_id);
SELECT          stations.mexs_id AS mexs_id, datetime AS messzeit
FROM            table_source
INNER JOIN      view_stations AS stations
ON              table_source.id = stations.icao
LEFT JOIN       view_target3 AS old
USING           (mexs_id);
SELECT * FROM table_target;
SELECT * FROM view_target2;
SELECT * FROM view_target3;
DROP VIEW  view_stations;
DROP TABLE table_source;
DROP TABLE table_stations;
DROP TABLE table_countries;
DROP TABLE table_target;
DROP TABLE table_target2;
DROP TABLE table_target3;
DROP VIEW  view_target2;
DROP VIEW  view_target3;
DROP DATABASE meow;
CREATE TABLE t1(a INT, b INT);
DROP TABLE t1;
CREATE TABLE t1(a INT,
                b INT GENERATED ALWAYS AS (-a) VIRTUAL,
		        c INT GENERATED ALWAYS AS (-a) STORED);
INSERT INTO t1(a) VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 ( f1 INTEGER, INDEX ( f1 ) );
CREATE TABLE t2 ( f1 INTEGER );
INSERT INTO t1 VALUES (10);
INSERT INTO t2
  SELECT STRAIGHT_JOIN *
  FROM t1 AS alias1
  WHERE EXISTS (
    SELECT * FROM (
      SELECT * FROM t1 JOIN t1 AS alias2 USING ( f1 )
    ) AS alias3
    WHERE alias1.f1 < 20
  );
DROP TABLE t1, t2;
CREATE TABLE t(id INT PRIMARY KEY, x INT);
INSERT INTO t VALUES (0, 0) ON DUPLICATE KEY UPDATE x = VALUES(x) + 1;
INSERT INTO t VALUES (0, 0)
       ON DUPLICATE KEY UPDATE x = (SELECT VALUES(x)+1 FROM t t1);
SELECT VALUES(x) FROM t;
INSERT INTO t VALUES (1, VALUES(x));
DROP TABLE t;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  col_varchar VARCHAR(64) DEFAULT NULL,
  col_blob BLOB,
  PRIMARY KEY (pk)
);
CREATE VIEW v1 AS
SELECT col_blob, pk, col_varchar
FROM t1
WHERE pk between 4 and 5;
CREATE TABLE t2 (
  pk INTEGER NOT NULL,
  col_int INTEGER DEFAULT NULL,
  col_blob BLOB,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES (7,8, 0xEFBFBDEFBFBDEFBFBDEFBFBD004A);
PREPARE stmt FROM
"INSERT INTO v1 (col_blob, pk, col_varchar)
 SELECT col_blob, col_int, col_blob
 FROM t2
 WHERE pk BETWEEN 7 AND 8
 LIMIT 1";
DEALLOCATE PREPARE stmt;
DROP VIEW v1;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  ÃÂÃÂ INTEGER,
  N INTEGER,
  a INTEGER,
  b INTEGER,
  c INTEGER,
  d INTEGER,
  e INTEGER,
  f INTEGER,
  g INTEGER,
  h INTEGER,
  i INTEGER,
  j INTEGER,
  k INTEGER,
  l INTEGER,
  m INTEGER,
  na INTEGER,
  o INTEGER,
  p INTEGER,
  q INTEGER,
  r INTEGER,
  s INTEGER,
  t INTEGER,
  u INTEGER,
  v INTEGER,
  w INTEGER,
  x INTEGER,
  y INTEGER,
  z INTEGER,
  aa INTEGER,
  ab INTEGER,
  ac INTEGER,
  ad INTEGER
);
INSERT INTO t1 (ÃÂÃÂ, N) VALUES (1, 2);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, KEY k1 ((1)));
INSERT INTO t1 VALUES() AS f2 ON DUPLICATE KEY UPDATE f1=1;
CREATE VIEW v1 AS SELECT * FROM t1;
INSERT INTO v1 VALUES() AS f2 ON DUPLICATE KEY UPDATE f1=1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, b INTEGER AS ((1)) INVISIBLE, KEY k1(b));
INSERT INTO t1 VALUES() AS f2 ON DUPLICATE KEY UPDATE f1=1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
DROP TABLE t1;
