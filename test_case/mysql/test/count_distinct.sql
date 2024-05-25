SELECT @bar;
SELECT @bar;
drop table t1, t2, t3;
create table t1 (f1 int);
insert into t1 values (1);
create table t2 (f1 int,f2 int);
select t1.f1,count(distinct t2.f2),count(distinct 1,NULL) from t1 left join t2 on t1.f1=t2.f1 group by t1.f1;
drop table t1,t2;
create table t1 (f int);
select count(distinct f) from t1;
drop table t1;
create table t1 (a char(3), b char(20), primary key (a, b));
insert into t1 values ('ABW', 'Dutch'), ('ABW', 'English');
select count(distinct a) from t1 group by b;
drop table t1;
create table t1 (f1 int, f2 int);
insert into t1 values (0,1),(1,2);
select count(distinct if(f1,3,f2)) from t1;
drop table t1;
create table t1 (i int);
insert into t1 values (0), (1);
create view v1 as select * from t1;
select count(distinct i) from v1;
drop table t1;
drop view v1;
CREATE TABLE t1 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (1),(2);
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
DROP TABLE  t1;
CREATE TABLE t1 (a BLOB ,PRIMARY KEY(a(10)));
INSERT INTO t1 VALUES (1),(2);
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = '1';
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = '1';
DROP TABLE  t1;
CREATE TABLE t1 (a CHAR PRIMARY KEY);
INSERT INTO t1 VALUES (1),(2);
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = '1';
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = '1';
DROP TABLE  t1;
CREATE TABLE t (a INT)ENGINE=INNODB;
INSERT t VALUES(1);
SELECT '' FROM t GROUP BY 1 WITH ROLLUP HAVING GROUP_CONCAT('');
DROP TABLE t;
CREATE TABLE t1 ( i INT );
INSERT INTO t1 VALUES (1),(2);
SELECT GROUP_CONCAT(i,'foo') AS f1 FROM t1 GROUP BY 'a' WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t (x char(3));
INSERT INTO t VALUES ('foo'), ('bar');
CREATE VIEW v AS SELECT 'x' AS x FROM t;
SELECT DISTINCT x FROM v;
DROP TABLE t;
DROP VIEW v;
CREATE TABLE t1 (
a int(11) DEFAULT NULL,
b int(11) DEFAULT NULL,
c int(11) DEFAULT NULL
) ENGINE=InnoDB;
INSERT INTO t1
VALUES (1,1,1),(1,2,1),(1,3,0),
       (1,4,0),(2,1,1),(2,2,1),(2,3,0),(2,4,0);
DROP TABLE t1;
CREATE TABLE t1 (
pk INT NOT NULL,
col_varchar_key VARCHAR(1),
col_varchar_nokey VARCHAR(1),
PRIMARY KEY (pk),
KEY col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES (10,'x','x');
INSERT INTO t1 VALUES (11,'d','d');
INSERT INTO t1 VALUES (12,'r','r');
INSERT INTO t1 VALUES (13,'f','f');
INSERT INTO t1 VALUES (14,'y','y');
CREATE TABLE t2 (
pk INT NOT NULL,
col_int_nokey INT,
col_varchar_key VARCHAR(1),
PRIMARY KEY (pk),
KEY col_varchar_key (col_varchar_key)
);
INSERT INTO t2 VALUES (1,7,'x');
SELECT COUNT( DISTINCT table1.col_varchar_key )
FROM t2 AS table1
JOIN (SELECT * FROM t1) AS table2
ON ( table2.pk = table1.col_int_nokey )
WHERE table1.pk = 1;
SELECT COUNT( DISTINCT table1.col_varchar_key )
FROM t2 AS table1
JOIN t1 AS table2
ON ( table2.pk = table1.col_int_nokey )
WHERE table1.pk = 1;
SELECT COUNT( table1.col_varchar_key )
FROM t2 AS table1
JOIN (SELECT * FROM t1) AS table2
ON ( table2.pk = table1.col_int_nokey )
WHERE table1.pk = 1;
DROP TABLE t1,t2;
