SELECT a,b,HEX(b) FROM t1 ORDER BY a, b;
SELECT * FROM t1 WHERE b = 9223372036854775808;
SELECT * FROM t1 WHERE b = 18446744073709551612;
SELECT * FROM t1 WHERE b = 18446744073709551615;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT)
  PARTITION BY HASH (c1)
  PARTITIONS 15;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);
ALTER TABLE t1 COALESCE PARTITION 13;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT)
  PARTITION BY LINEAR HASH (c1)
  PARTITIONS 5;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);
ALTER TABLE t1 COALESCE PARTITION 3;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT)
  PARTITION BY LINEAR HASH (c1)
  PARTITIONS 3;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7);
ALTER TABLE t1 ADD PARTITION PARTITIONS 2;
SELECT * FROM t1 ORDER BY c1;
ALTER TABLE t1 ADD PARTITION PARTITIONS 10;
SELECT * FROM t1 ORDER BY c1;
DROP TABLE t1;
create table t1 (a int unsigned)
partition by hash(a div 2)
partitions 4;
insert into t1 values (null),(0),(1),(2),(3),(4),(5),(6),(7);
select * from t1 where a < 0;
select * from t1 where a is null or (a >= 5 and a <= 7);
select * from t1 where a is null;
select * from t1 where a is not null;
select * from t1 where a >= 1 and a < 3;
select * from t1 where a >= 3 and a <= 5;
select * from t1 where a > 2 and a < 4;
select * from t1 where a > 3 and a <= 6;
select * from t1 where a > 5;
select * from t1 where a >= 1 and a <= 5;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a + 2)
partitions 3
(partition x1,
 partition x2,
 partition x3);
insert into t1 values (1,1,1);
insert into t1 values (2,1,1);
insert into t1 values (3,1,1);
insert into t1 values (4,1,1);
insert into t1 values (5,1,1);
select * from t1;
update t1 set c=3 where b=1;
select * from t1;
select b from t1 where a=3;
select b,c from t1 where a=1 AND b=1;
delete from t1 where a=1;
delete from t1 where c=3;
select * from t1;
ALTER TABLE t1
partition by hash (a + 3)
partitions 3
(partition x1,
 partition x2,
 partition x3);
select * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a)
(partition x1);
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
(partition x1);
drop table t1;
CREATE TABLE t1 (f1 INTEGER, f2 char(20)) PARTITION BY HASH(f1) PARTITIONS 2;
INSERT INTO t1 SET f1 = 0 - 1, f2 = '#######';
select * from t1;
drop table t1;
create table t1 (c1 int DEFAULT NULL,
                 c2 varchar (30) DEFAULT NULL,
                 c3 date DEFAULT NULL)
partition by hash (to_days(c3))
partitions 12;
insert into t1 values
(136,'abc','2002-01-05'),(142,'abc','2002-02-14'),(162,'abc','2002-06-28'),
(182,'abc','2002-11-09'),(158,'abc','2002-06-01'),(184,'abc','2002-11-22');
select * from t1;
select * from t1 where c3 between '2002-01-01' and '2002-12-31';
drop table t1;
CREATE TABLE T (a INT) ENGINE=InnoDB;
DROP TABLE T;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 TINYINT NULL, c2 CHAR(5)) PARTITION BY HASH(c1) PARTITIONS 1;
