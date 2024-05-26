drop table if exists t1, t2;
CREATE TABLE t1 (
       id MEDIUMINT NOT NULL AUTO_INCREMENT,
       dt DATE, st VARCHAR(255), uid INT,
       id2nd LONGBLOB, filler VARCHAR(255), PRIMARY KEY(id, dt)
);
INSERT INTO t1 (dt, st, uid, id2nd, filler) VALUES
   ('1991-03-14', 'Initial Insert', 200, 1234567, 'No Data'),
   ('1991-02-26', 'Initial Insert', 201, 1234567, 'No Data'),
   ('1992-03-16', 'Initial Insert', 234, 1234567, 'No Data'),
   ('1992-07-02', 'Initial Insert', 287, 1234567, 'No Data'),
   ('1991-05-26', 'Initial Insert', 256, 1234567, 'No Data'),
   ('1991-04-25', 'Initial Insert', 222, 1234567, 'No Data'),
   ('1993-03-12', 'Initial Insert', 267, 1234567, 'No Data'),
   ('1993-03-14', 'Initial Insert', 291, 1234567, 'No Data'),
   ('1991-12-20', 'Initial Insert', 298, 1234567, 'No Data'),
   ('1994-10-31', 'Initial Insert', 220, 1234567, 'No Data');
ALTER TABLE t1 PARTITION BY LIST (YEAR(dt)) (
    PARTITION d1 VALUES IN (1991, 1994),
    PARTITION d2 VALUES IN (1993),
    PARTITION d3 VALUES IN (1992, 1995, 1996)
);
INSERT INTO t1 (dt, st, uid, id2nd, filler) VALUES
   ('1991-07-14', 'After Partitioning Insert', 299, 1234567, 'Insert row');
UPDATE t1 SET filler='Updating the row' WHERE uid=298;
DROP TABLE t1;
CREATE TABLE t1 (
a char(2) NOT NULL,
b char(2) NOT NULL,
c int(10) unsigned NOT NULL,
d varchar(255) DEFAULT NULL,
e varchar(1000) DEFAULT NULL,
PRIMARY KEY (a, b, c),
KEY (a),
KEY (a, b)
);
INSERT INTO t1 (a, b, c, d, e) VALUES
('07', '03', 343, '1', '07_03_343'),
('01', '04', 343, '2', '01_04_343'),
('01', '06', 343, '3', '01_06_343'),
('01', '07', 343, '4', '01_07_343'),
('01', '08', 343, '5', '01_08_343'),
('01', '09', 343, '6', '01_09_343'),
('03', '03', 343, '7', '03_03_343'),
('03', '06', 343, '8', '03_06_343'),
('03', '07', 343, '9', '03_07_343'),
('04', '03', 343, '10', '04_03_343'),
('04', '06', 343, '11', '04_06_343'),
('05', '03', 343, '12', '05_03_343'),
('11', '03', 343, '13', '11_03_343'),
('11', '04', 343, '14', '11_04_343');
UPDATE t1 AS A,
(SELECT '03' AS a, '06' AS b, 343 AS c, 'last' AS d) AS B
SET A.e = B.d  
WHERE A.a = '03'  
AND A.b = '06' 
AND A.c = 343;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(51) CHARACTER SET latin1)
PARTITION BY KEY (a) PARTITIONS 1;
INSERT INTO t1 VALUES ('a'),('b'),('c');
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL)
PARTITION BY KEY (a) PARTITIONS 2;
INSERT INTO t1 VALUES (0,1), (0,2);
SELECT * FROM t1;
UPDATE t1 SET a = 1, b = 1 WHERE a = 0 AND b = 2;
ALTER TABLE t1 ADD PRIMARY KEY (a);
SELECT * FROM t1;
ALTER TABLE t1 DROP PRIMARY KEY;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1
(id INT NOT NULL PRIMARY KEY,
 name VARCHAR(16) NOT NULL,
 year YEAR,
 INDEX name (name(8))
)
PARTITION BY HASH(id) PARTITIONS 2;
INSERT INTO t1 VALUES ( 1, 'FooBar', '1924' );
CREATE TABLE t2 (id INT);
INSERT INTO t2 VALUES (1),(2);
UPDATE t1, t2 SET t1.year = '1955' WHERE t1.name = 'FooBar';
DROP TABLE t1, t2;
CREATE TABLE t1 (
  `id` int NOT NULL,
  `user_num` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB CHARSET=latin1;
INSERT INTO t1 VALUES (1,8601);
INSERT INTO t1 VALUES (2,8601);
INSERT INTO t1 VALUES (3,8601);
INSERT INTO t1 VALUES (4,8601);
CREATE TABLE t2 (
  `id` int(11) NOT NULL,
  `user_num` int DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB CHARSET=latin1
PARTITION BY HASH (id)
PARTITIONS 2;
INSERT INTO t2 VALUES (1,8601,'John');
INSERT INTO t2 VALUES (2,8601,'JS');
INSERT INTO t2 VALUES (3,8601,'John S');
UPDATE t1, t2 SET t2.name = 'John Smith' WHERE t1.user_num = t2.user_num;
DROP TABLE t1, t2;
CREATE TABLE t1 (
    ID int(11) NOT NULL,
    `aaaa,aaaaa` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
    ddddddddd int(11) NOT NULL DEFAULT '0',
    new_field0 varchar(50),
    PRIMARY KEY(ID, `aaaa,aaaaa`, ddddddddd))
PARTITION BY RANGE(ID)
PARTITIONS 3
SUBPARTITION BY LINEAR KEY(ID,`aaaa,aaaaa`)
SUBPARTITIONS 2 (
    PARTITION p01 VALUES LESS THAN(100),
    PARTITION p11 VALUES LESS THAN(200),
    PARTITION p21 VALUES LESS THAN MAXVALUE);
SELECT PARTITION_EXPRESSION, SUBPARTITION_EXPRESSION FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME='t1';
drop table t1;
CREATE TABLE t1 (a INT, b INT)
PARTITION BY LIST (a)
SUBPARTITION BY HASH (b)
(PARTITION p1 VALUES IN (1));
ALTER TABLE t1 ADD COLUMN c INT;
DROP TABLE t1;
CREATE TABLE t1 (
  a int NOT NULL,
  b int NOT NULL);
CREATE TABLE t2 (
  a int NOT NULL,
  b int NOT NULL,
  INDEX(b)
)
PARTITION BY HASH(a) PARTITIONS 2;
INSERT INTO t1 VALUES (399, 22);
INSERT INTO t2 VALUES (1, 22), (1, 42);
INSERT INTO t2 SELECT 1, 399 FROM t2, t1
WHERE t1.b = t2.b;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  b varchar(10),
  PRIMARY KEY (a)
)
PARTITION BY RANGE (UNIX_TIMESTAMP(a)) (
 PARTITION p1 VALUES LESS THAN (1199134800),
 PARTITION pmax VALUES LESS THAN MAXVALUE
);
INSERT INTO t1 VALUES ('2007-07-30 17:35:48', 'p1');
INSERT INTO t1 VALUES ('2009-07-14 17:35:55', 'pmax');
INSERT INTO t1 VALUES ('2009-09-21 17:31:42', 'pmax');
SELECT * FROM t1;
SELECT * FROM t1 where a between '2007-01-01' and '2007-08-01';
ALTER TABLE t1 REORGANIZE PARTITION pmax INTO (
 PARTITION p3 VALUES LESS THAN (1247688000),
 PARTITION pmax VALUES LESS THAN MAXVALUE);
SELECT * FROM t1;
SELECT * FROM t1 where a between '2007-01-01' and '2007-08-01';
DROP TABLE t1;
create table t1 (a int NOT NULL, b varchar(5) NOT NULL)
default charset=utf8mb3
partition by list (a)
subpartition by key (b)
(partition p0 values in (1),
 partition p1 values in (2));
drop table t1;
create table t1 (a int, b int, key(a))
partition by list (a)
( partition p0 values in (1),
  partition p1 values in (2));
insert into t1 values (1,1),(2,1),(2,2),(2,3);
drop table t1;
create table t1 (a int)
partition by hash (a);
create index i on t1 (a);
insert into t1 values (1);
insert into t1 select * from t1;
create index i2 on t1 (a);
drop table t1;
CREATE TABLE t0 (a INT PRIMARY KEY);
DROP TABLE t0;
CREATE TABLE t1 (
  pk INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t1 VALUES (NULL);
SELECT * FROM t1 WHERE pk < 0 ORDER BY pk;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL, KEY(a))
PARTITION BY RANGE(a)
(PARTITION p1 VALUES LESS THAN (200), PARTITION pmax VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (2), (40), (40), (70), (60), (90), (199);
SELECT a FROM t1 WHERE a BETWEEN 60 AND 95 ORDER BY a ASC;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 95;
INSERT INTO t1 VALUES (200), (250), (210);
SELECT a FROM t1 WHERE a BETWEEN 60 AND 220 ORDER BY a ASC;
SELECT a FROM t1 WHERE a BETWEEN 200 AND 220 ORDER BY a ASC;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 95 ORDER BY a DESC;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 220 ORDER BY a DESC;
SELECT a FROM t1 WHERE a BETWEEN 200 AND 220 ORDER BY a DESC;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 220;
SELECT a FROM t1 WHERE a BETWEEN 200 AND 220;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 95;
SELECT a FROM t1 WHERE a BETWEEN 60 AND 220;
SELECT a FROM t1 WHERE a BETWEEN 200 AND 220;
DROP TABLE t1;
CREATE TABLE t1 (
  a INT NOT NULL,   
  b MEDIUMINT NOT NULL,   
  c INT NOT NULL,
  KEY b (b)
)
PARTITION BY LIST (a) (
  PARTITION p0 VALUES IN (1) 
);
INSERT INTO t1 VALUES (1,1,0), (1,1,1), (1,1,2), (1,1,53), (1,1,4), (1,1,5),
(1,1,6), (1,1,7), (1,1,8), (1,1,9), (1,1,10), (1,1,11), (1,1,12), (1,1,13),
(1,1,14), (1,1,15), (1,1,16), (1,1,67), (1,1,18), (1,1,19), (1,1,20), (1,1,21),
(1,1,22), (1,1,23), (1,1,24), (1,1,75), (1,1,26), (1,1,27), (1,1,128),
(1,1,79), (1,1,30), (1,1,31), (1,1,32), (1,1,33), (1,1,34), (1,1,85), (1,1,36),
(1,1,37), (1,1,38), (1,1,39), (1,1,40), (1,1,241), (1,1,42), (1,1,43),
(1,1,44), (1,1,45), (1,1,46), (1,1,147), (1,1,48), (1,1,49), (1,2,0), (1,2,1),
(1,2,2), (1,2,3), (1,2,4), (1,2,5), (1,2,6), (1,2,7), (1,2,8), (1,2,9),
(1,2,10), (1,2,11), (1,2,12), (1,2,13), (1,2,14), (1,2,15), (1,2,16), (1,2,17),
(1,2,18), (1,2,19), (1,2,20), (1,2,21), (1,2,22), (1,2,23), (1,2,24), (1,2,25),
(1,2,26), (1,2,27), (1,2,28), (1,2,29), (1,2,30), (1,2,31), (1,2,32), (1,2,33),
(1,2,34), (1,2,35), (1,2,36), (1,2,37), (1,2,38), (1,2,39), (1,2,40), (1,2,41),
(1,2,42), (1,2,43), (1,2,44), (1,2,45), (1,2,46), (1,2,47), (1,2,48), (1,2,49),
(1,6,0), (1,6,1), (1,6,2), (1,6,3), (1,6,4), (1,6,5), (1,6,6), (1,6,7),
(1,6,8), (1,6,9), (1,6,10), (1,6,11), (1,6,12), (1,6,13), (1,6,14), (1,6,15),
(1,6,16), (1,6,17), (1,6,18), (1,6,19), (1,6,20), (1,6,21), (1,6,22), (1,6,23),
(1,6,24), (1,6,25), (1,6,26), (1,6,27), (1,6,28), (1,6,29), (1,6,30), (1,6,31),
(1,6,32), (1,6,33), (1,6,34), (1,6,35), (1,6,36), (1,6,37), (1,6,38), (1,6,39),
(1,6,40), (1,6,41), (1,6,42), (1,6,43), (1,6,44), (1,6,45), (1,6,46), (1,6,47),
(1,6,48), (1,6,49), (1,7,0), (1,7,1), (1,7,2), (1,7,3), (1,7,4), (1,7,5),
(1,7,6), (1,7,7), (1,7,8), (1,7,9), (1,7,10), (1,7,11), (1,7,12), (1,7,13),
(1,7,14), (1,7,15), (1,7,16), (1,7,17), (1,7,18), (1,7,19), (1,7,20), (1,7,21),
(1,7,22), (1,7,23), (1,7,24), (1,7,25), (1,7,26), (1,7,27), (1,7,28), (1,7,29),
  (1,7,30), (1,7,31), (1,7,32), (1,7,33), (1,7,34), (1,7,35), (1,7,38), (1,7,39),
(1,7,90), (1,7,41), (1,7,43), (1,7,48), (1,7,49), (1,9,0), (1,9,1), (1,9,2),
(1,9,3), (1,9,4), (1,9,5), (1,9,6), (1,9,7), (1,9,8), (1,9,9), (1,9,10),
(1,9,11), (1,9,12), (1,9,13), (1,9,14), (1,9,15), (1,9,16), (1,9,17), (1,9,18),
(1,9,19), (1,9,20), (1,9,21), (1,9,22), (1,9,23), (1,9,24), (1,9,25), (1,9,26),
(1,9,29), (1,9,32), (1,9,35), (1,9,38), (1,10,0), (1,10,1), (1,10,2), (1,10,3),
(1,10,4), (1,10,5), (1,10,6), (1,10,7), (1,10,8), (1,10,9), (1,10,10),
(1,10,11), (1,10,13), (1,10,14), (1,10,15), (1,10,16), (1,10,17), (1,10,18),
(1,10,22), (1,10,24), (1,10,25), (1,10,26), (1,10,28), (1,10,131), (1,10,33),
(1,10,84), (1,10,35), (1,10,40), (1,10,42), (1,10,49), (1,11,0), (1,11,1),
(1,11,2), (1,11,3), (1,11,4), (1,11,5), (1,11,6), (1,11,7), (1,11,8), (1,11,9),
(1,11,10), (1,11,11), (1,11,12), (1,11,13), (1,11,14), (1,11,15), (1,11,16),
(1,11,17), (1,11,18), (1,11,19), (1,11,20), (1,11,21), (1,11,22), (1,11,23),
(1,11,24), (1,11,25), (1,11,26), (1,11,27), (1,11,28), (1,11,30), (1,11,31),
(1,11,32), (1,11,33), (1,11,34), (1,11,35), (1,11,37), (1,11,39), (1,11,40),
(1,11,42), (1,11,44), (1,11,45), (1,11,47), (1,11,48), (1,14,104), (1,14,58),
(1,14,12), (1,14,13), (1,14,15), (1,14,16), (1,14,17), (1,14,34), (1,15,0),
(1,15,1), (1,15,2), (1,15,3), (1,15,4), (1,15,5), (1,15,7), (1,15,9),
(1,15,15), (1,15,27), (1,15,49), (1,16,0), (1,16,1), (1,16,3), (1,17,4),
(1,19,1);
SELECT COUNT(*) FROM t1 WHERE b NOT IN ( 1,2,6,7,9,10,11 );
SELECT SUM(c) FROM t1 WHERE b NOT IN ( 1,2,6,7,9,10,11 );
ALTER TABLE t1 DROP INDEX b;
ALTER TABLE t1 ADD INDEX b USING HASH (b);
DROP TABLE t1;
CREATE TABLE `t1` (
  `c1` int(11) DEFAULT NULL,
  KEY `c1` (`c1`)
) DEFAULT CHARSET=latin1;
CREATE TABLE `t2` (
  `c1` int(11) DEFAULT NULL,
  KEY `c1` (`c1`)
) DEFAULT CHARSET=latin1 /*!50100 PARTITION BY RANGE (c1) (PARTITION a VALUES LESS THAN (100) , PARTITION b VALUES LESS THAN MAXVALUE ) */;
INSERT INTO `t1` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
INSERT INTO `t2` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
SELECT c1 FROM t1 WHERE (c1 > 10 AND c1 < 13) OR (c1 > 17 AND c1 < 20);
SELECT c1 FROM t2 WHERE (c1 > 10 AND c1 < 13) OR (c1 > 17 AND c1 < 20);
DROP TABLE t1,t2;
CREATE TABLE `t1` (
  `c1` int(11) DEFAULT NULL,
  KEY `c1` (`c1`)
) DEFAULT CHARSET=latin1;
CREATE TABLE `t2` (
  `c1` int(11) DEFAULT NULL,
  KEY `c1` (`c1`)
) DEFAULT CHARSET=latin1;
INSERT INTO `t1` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
INSERT INTO `t2` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
SELECT c1 FROM t1 WHERE (c1 > 2 AND c1 < 5);
SELECT c1 FROM t2 WHERE (c1 > 2 AND c1 < 5);
SELECT c1 FROM t1 WHERE (c1 > 12 AND c1 < 15);
SELECT c1 FROM t2 WHERE (c1 > 12 AND c1 < 15);
DROP TABLE t1,t2;
CREATE TABLE t1 (
    d DATE NOT NULL
)
PARTITION BY RANGE( YEAR(d) ) (
    PARTITION p0 VALUES LESS THAN (1960),
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990)
);
ALTER TABLE t1 ADD PARTITION (
PARTITION `p5` VALUES LESS THAN (2010)
COMMENT 'APSTART \' APEND'
);
SELECT * FROM t1 LIMIT 1;
DROP TABLE t1;
create table t1 (id int auto_increment, s1 int, primary key (id));
insert into t1 values (null,1);
insert into t1 values (null,6);
select * from t1;
alter table t1 partition by range (id) (
  partition p0 values less than (3),
  partition p1 values less than maxvalue
);
drop table t1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (1));
create procedure pz()
alter table t1;
drop procedure pz;
drop table t1;
create table t1 (a bigint unsigned)
partition by range (a)
(partition p0 values less than (100),
 partition p1 values less than MAXVALUE);
insert into t1 values (1);
drop table t1;
create table t1 (a bigint unsigned)
partition by hash (a);
insert into t1 values (0xFFFFFFFFFFFFFFFD);
insert into t1 values (0xFFFFFFFFFFFFFFFE);
select * from t1 where (a + 1) < 10;
select * from t1 where (a + 1) > 10;
drop table t1;
create table t1 (a int)
partition by range (a)
subpartition by key (a)
(partition p0 values less than (1));
alter table t1 add partition (partition p1 values less than (2));
alter table t1 reorganize partition p1 into (partition p1 values less than (3));
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a);
select count(*) from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a, b);
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition x1, partition x2, partition x3);
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition x1 nodegroup 0,
 partition x2 nodegroup 1,
 partition x3 nodegroup 2);
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition x1 engine innodb,
 partition x2 engine innodb,
 partition x3 engine innodb);
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition x1 tablespace innodb_file_per_table,
 partition x2 tablespace innodb_file_per_table,
 partition x3 tablespace innodb_file_per_table);
CREATE TABLE t2 LIKE t1;
drop table t2;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 3
(partition x1 values in (1,2,9,4),
 partition x2 values in (3, 11, 5, 7),
 partition x3 values in (16, 8, 5+19, 70-43));
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (b*a)
partitions 3
(partition x1 values in (1,2,9,4),
 partition x2 values in (3, 11, 5, 7),
 partition x3 values in (16, 8, 5+19, 70-43));
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (b*a)
(partition x1 values in (1),
 partition x2 values in (3, 11, 5, 7),
 partition x3 values in (16, 8, 5+19, 70-43));
drop table t1;
CREATE TABLE t1 (
a int not null)
partition by key(a);
LOCK TABLES t1 WRITE;
insert into t1 values (1);
insert into t1 values (2);
insert into t1 values (3);
insert into t1 values (4);
UNLOCK TABLES;
drop table t1;
CREATE TABLE t1 (a int, name VARCHAR(50), purchased DATE)
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (3),
 PARTITION p1 VALUES LESS THAN (7),
 PARTITION p2 VALUES LESS THAN (9),
 PARTITION p3 VALUES LESS THAN (11));
INSERT INTO t1 VALUES
(1, 'desk organiser', '2003-10-15'),
(2, 'CD player', '1993-11-05'),
(3, 'TV set', '1996-03-10'),
(4, 'bookcase', '1982-01-10'),
(5, 'exercise bike', '2004-05-09'),
(6, 'sofa', '1987-06-05'),
(7, 'popcorn maker', '2001-11-22'),
(8, 'acquarium', '1992-08-04'),
(9, 'study desk', '1984-09-16'),
(10, 'lava lamp', '1998-12-25');
SELECT * from t1 ORDER BY a;
ALTER TABLE t1 DROP PARTITION p0;
SELECT * from t1 ORDER BY a;
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION p0 VALUES IN (1,2,3), PARTITION p1 VALUES IN (4,5,6));
insert into t1 values (1),(2),(3),(4),(5),(6);
select * from t1;
select * from t1;
select * from t1;
drop table t1;
CREATE TABLE t1 (a int, b int, primary key(a,b))
PARTITION BY KEY(b,a) PARTITIONS 4;
insert into t1 values (0,0),(1,1),(2,2),(3,3),(4,4),(5,5),(6,6);
select * from t1 where a = 4;
drop table t1;
CREATE TABLE t1 (c1 INT, c2 INT, PRIMARY KEY USING BTREE (c1,c2))
  PARTITION BY KEY(c2,c1) PARTITIONS 4;
INSERT INTO t1 VALUES (0,0),(1,1),(2,2),(3,3),(4,4),(5,5),(6,6);
SELECT * FROM t1 WHERE c1 = 4;
DROP TABLE t1;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
PARTITIONS 1
(PARTITION x1 VALUES IN (1) ENGINE=InnoDB);
drop table t1;
CREATE TABLE t1 (a int, unique(a))
PARTITION BY LIST (a)
(PARTITION x1 VALUES IN (10), PARTITION x2 VALUES IN (20));
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION x1 VALUES IN (2), PARTITION x2 VALUES IN (3));
insert into t1 values (2), (3);
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY HASH(a)
PARTITIONS 5;
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY RANGE (a)
(PARTITION x1 VALUES LESS THAN (2));
insert into t1 values (1);
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION x1 VALUES IN (10), PARTITION x2 VALUES IN (20));
drop table t1;
create table t1
(a int)
partition by range (a)
  ( partition p0 values less than(10),
    partition p1 values less than (20),
    partition p2 values less than (25));
alter table t1 reorganize partition p2 into (partition p2 values less than (30));
drop table t1;
CREATE TABLE t1 (a int, b int)
PARTITION BY RANGE (a)
(PARTITION x0 VALUES LESS THAN (2),
 PARTITION x1 VALUES LESS THAN (4),
 PARTITION x2 VALUES LESS THAN (6),
 PARTITION x3 VALUES LESS THAN (8),
 PARTITION x4 VALUES LESS THAN (10),
 PARTITION x5 VALUES LESS THAN (12),
 PARTITION x6 VALUES LESS THAN (14),
 PARTITION x7 VALUES LESS THAN (16),
 PARTITION x8 VALUES LESS THAN (18),
 PARTITION x9 VALUES LESS THAN (20));
ALTER TABLE t1 REORGANIZE PARTITION x0,x1,x2 INTO
(PARTITION x1 VALUES LESS THAN (6));
drop table t1;
create table t1 (a int not null, b int not null) partition by LIST (a+b) (
  partition p0 values in (12),
  partition p1 values in (14)
);
drop table t1;
create table t1 (f1 integer,f2 integer, f3 varchar(10), primary key(f1,f2))
partition by range(f1) subpartition by hash(f2) subpartitions 2
(partition p1 values less than (0),
 partition p2 values less than (2),
 partition p3 values less than (2147483647));
insert into t1 values(10,10,'10');
insert into t1 values(2,2,'2');
select * from t1 where f1 = 2;
drop table t1;
create table t1 (f1 integer,f2 integer, unique index(f1))
partition by range(f1 div 2)
subpartition by hash(f1) subpartitions 2
(partition partb values less than (2),
partition parte values less than (4),
partition partf values less than (10000));
insert into t1 values(10,1);
select * from t1 where f1 = 10;
drop table t1;
create table t1 (f_int1 int(11) default null) engine = innodb
  partition by range (f_int1) subpartition by hash (f_int1)
  (partition part1 values less than (1000)
   (subpartition subpart11 engine = innodb));
drop table t1;
create table t1 (f_int1 integer, f_int2 integer, primary key (f_int1))
  partition by hash(f_int1) partitions 2;
insert into t1 values (1,1),(2,2);
drop table t1;
create table t1 (s1 int, unique (s1)) partition by list (s1) (partition x1 VALUES in (10), partition x2 values in (20));
alter table t1 add partition (partition x3 values in (30));
drop table t1;
create table t1 (a int)
partition by key(a)
partitions 2
(partition p0 engine=innodb, partition p1 engine=innodb);
alter table t1;
alter table t1 engine=innodb;
alter table t1 remove partitioning;
drop table t1;
create table t1 (a int)
engine=innodb
partition by key(a)
partitions 2
(partition p0 engine=innodb, partition p1 engine=innodb);
alter table t1 add column b int remove partitioning;
alter table t1
engine=innodb
partition by key(a)
(partition p0 engine=innodb, partition p1);
alter table t1 engine=myisam, add column c int remove partitioning;
alter table t1
engine=innodb
partition by key (a)
(partition p0, partition p1);
alter table t1
partition by key (a)
(partition p0, partition p1);
alter table t1
partition by key(a)
(partition p0, partition p1 engine=innodb);
alter table t1
partition by key(a)
(partition p0 engine=innodb, partition p1);
drop table t1;
CREATE TABLE t1 (
 f_int1 INTEGER, f_int2 INTEGER,
 f_char1 CHAR(10), f_char2 CHAR(10), f_charbig VARCHAR(1000)
 )
 PARTITION BY RANGE(f_int1 DIV 2)
 SUBPARTITION BY HASH(f_int1)
 SUBPARTITIONS 2
 (PARTITION parta VALUES LESS THAN (0),
  PARTITION partb VALUES LESS THAN (5),
  PARTITION parte VALUES LESS THAN (10),
  PARTITION partf VALUES LESS THAN (2147483647));
INSERT INTO t1 SET f_int1 = NULL , f_int2 = -20, f_char1 = CAST(-20 AS CHAR),
                   f_char2 = CAST(-20 AS CHAR), f_charbig = '#NULL#';
SELECT * FROM t1 WHERE f_int1 IS NULL;
SELECT * FROM t1;
drop table t1;
CREATE TABLE t1 (
 f_int1 INTEGER, f_int2 INTEGER,
 f_char1 CHAR(10), f_char2 CHAR(10), f_charbig VARCHAR(1000)  )
 PARTITION BY LIST(MOD(f_int1,2))
 SUBPARTITION BY KEY(f_int1)
 (PARTITION part1 VALUES IN (-1) (SUBPARTITION sp1, SUBPARTITION sp2),
  PARTITION part2 VALUES IN (0) (SUBPARTITION sp3, SUBPARTITION sp5),
  PARTITION part3 VALUES IN (1) (SUBPARTITION sp4, SUBPARTITION sp6));
INSERT INTO t1 SET f_int1 = 2, f_int2 = 2, f_char1 = '2', f_char2 = '2', f_charbig = '===2===';
INSERT INTO t1 SET f_int1 = 2, f_int2 = 2, f_char1 = '2', f_char2 = '2', f_charbig = '===2===';
SELECT * FROM t1 WHERE f_int1  IS NULL;
drop table t1;
create table t1 (a int,b int,c int,key(a,b))
partition by range (a)
partitions 3
(partition x1 values less than (0),
 partition x2 values less than (10),
 partition x3 values less than maxvalue);
insert into t1 values (NULL, 1, 1);
insert into t1 values (0, 1, 1);
insert into t1 values (12, 1, 1);
select partition_name, partition_description, table_rows
from information_schema.partitions where table_schema ='test';
drop table t1;
create table t1 (a int,b int, c int)
partition by list(a)
partitions 2
(partition x123 values in (11, 12),
 partition x234 values in (5, 1));
drop table t1;
create table t1 (a int,b int, c int)
partition by list(a)
partitions 2
(partition x123 values in (11, 12),
 partition x234 values in (NULL, 1));
insert into t1 values (11,1,6);
insert into t1 values (NULL,1,1);
select partition_name, partition_description, table_rows
from information_schema.partitions where table_schema ='test';
drop table t1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (1));
drop table t1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (5));
drop table t1;
create table t1 (a int)
partition by range (a) subpartition by hash (a)
(partition p0 values less than (100));
alter table t1 add partition (partition p1 values less than (200)
(subpartition subpart21));
drop table t1;
create table t1 (a int)
partition by key (a);
alter table t1 add partition (partition p1);
drop table t1;
create table t1 (a int)
partition by range (a)
(partition p0 values less than (1));
drop table t1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (1));
drop table t1;
create table t1 (a int)
partition by hash (a)
(partition p0);
drop table t1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (1));
drop table t1;
create table t2 (s1 int not null auto_increment, primary key (s1)) partition by list (s1) (partition p1 values in (1),partition p2 values in (2),partition p3 values in (3),partition p4 values in (4));
insert into t2 values (null),(null),(null);
select * from t2;
select * from t2 where s1 < 2;
update t2 set s1 = s1 + 1 order by s1 desc;
select * from t2 where s1 < 3;
select * from t2 where s1 = 2;
drop table t2;
create table t1 (a int, b int) partition by list (a)
  (partition p1 values in (1), partition p2 values in (2));
drop table t1;
create table t1 (a int unsigned not null auto_increment primary key)
partition by key(a);
alter table t1 rename t2, add c char(10), comment "no comment";
drop table t2;
create table t1 (f1 int) partition by hash (f1) as select 1;
drop table t1;
prepare stmt1 from 'create table t1 (s1 int) partition by hash (s1)';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (num INT,PRIMARY KEY(num));
INSERT INTO t1 VALUES (14);
drop table t1;
CREATE TABLE t1 (a int not null)
partition by key(a)
(partition p0 COMMENT='first partition');
drop table t1;
CREATE TABLE t1 (`a b` int not null)
partition by key(`a b`);
drop table t1;
CREATE TABLE t1 (`a b` int not null)
partition by hash(`a b`);
drop table t1;
create table t1 (f1 integer) partition by range(f1)
(partition p1 values less than (0), partition p2 values less than (10));
insert into t1 set f1 = null;
select * from t1 where f1 is null;
drop table t1;
create table t1 (f1 integer) partition by list(f1)
(partition p1 values in (1), partition p2 values in (null));
insert into t1 set f1 = null;
insert into t1 set f1 = 1;
select * from t1 where f1 is null or f1 = 1;
drop table t1;
create table t1 (f1 smallint)
partition by list (f1) (partition p0 values in (null));
insert into t1 values (null);
select * from t1 where f1 is null;
select * from t1 where f1 < 1;
select * from t1 where f1 <= NULL;
select * from t1 where f1 < NULL;
select * from t1 where f1 >= NULL;
select * from t1 where f1 > NULL;
select * from t1 where f1 > 1;
drop table t1;
create table t1 (f1 smallint)
partition by range (f1) (partition p0 values less than (0));
insert into t1 values (null);
select * from t1 where f1 is null;
drop table t1;
create table t1 (f1 integer) partition by list(f1)
(
 partition p1 values in (1),
 partition p2 values in (NULL),
 partition p3 values in (2),
 partition p4 values in (3),
 partition p5 values in (4)
);
insert into t1 values (1),(2),(3),(4),(null);
select * from t1 where f1 < 3;
select * from t1 where f1 is null;
drop table t1;
create table t1 (f1 int) partition by list(f1 div 2)
(
 partition p1 values in (1),
 partition p2 values in (NULL),
 partition p3 values in (2),
 partition p4 values in (3),
 partition p5 values in (4)
);
insert into t1 values (2),(4),(6),(8),(null);
select * from t1 where f1 < 3;
select * from t1 where f1 is null;
drop table t1;
create table t1 (a int) partition by LIST(a) (
  partition pn values in (NULL),
  partition p0 values in (0),
  partition p1 values in (1),
  partition p2 values in (2)
);
insert into t1 values (NULL),(0),(1),(2);
select * from t1 where a is null or a < 2;
select * from t1 where a is null or a < 0 or a > 1;
drop table t1;
CREATE TABLE t1 (id INT NOT NULL PRIMARY KEY, name VARCHAR(20)) 
DEFAULT CHARSET=latin1
PARTITION BY RANGE(id)
(PARTITION p0  VALUES LESS THAN (10),
PARTITION p1 VALUES LESS THAN (20),
PARTITION p2 VALUES LESS THAN (30));
DROP TABLE t1;
create table t1 (a bigint unsigned)
partition by range (a)
(partition p0 values less than (10));
drop table t1;
create table t1 (a int)
partition by list (a)
(partition `s1 s2` values in (0));
drop table t1;
create table t1 (a int)
partition by list (a)
(partition `7` values in (0));
drop table t1;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION p0 VALUES IN (NULL));
DROP TABLE t1;
create table t1 (s1 int auto_increment primary key)
partition by list (s1)
(partition p1 values in (1),
 partition p2 values in (2),
 partition p3 values in (3));
insert into t1 values (null);
insert into t1 values (null);
insert into t1 values (null);
select auto_increment from information_schema.tables where table_name='t1';
select * from t1;
drop table t1;
create table t1 (a int)
partition by key(a);
insert into t1 values (1);
create index inx1 on t1(a);
drop table t1;
create table t1 (a varchar(1))
partition by key (a)
as select 'a';
drop table t1;
CREATE TABLE t1 (a int) PARTITION BY KEY(a);
INSERT into t1 values (1), (2);
DELETE from t1 where a = 1;
ALTER TABLE t1 OPTIMIZE PARTITION p0;
DROP TABLE t1;
CREATE TABLE t1 (a int, index(a)) PARTITION BY KEY(a);
ALTER TABLE t1 DISABLE KEYS;
ALTER TABLE t1 ENABLE KEYS;
DROP TABLE t1;
create table t1 (a int)
partition by key (a);
drop table t1;
drop procedure if exists mysqltest_1;
create table t1 (a int)
partition by list (a)
(partition p0 values in (0));
insert into t1 values (0);
update ignore t1 set a = 1 where a = 0;
prepare stmt1 from 'alter table t1';
drop table t1;
create table t1 (a int, index(a))
partition by hash(a);
insert into t1 values (1),(2);
select * from t1 ORDER BY a DESC;
drop table t1;
create table t1 (a bigint unsigned not null, primary key(a))
partition by key (a)
partitions 10;
insert into t1 values (18446744073709551615), (0xFFFFFFFFFFFFFFFE),
(18446744073709551613), (18446744073709551612);
select * from t1;
select * from t1 where a = 18446744073709551615;
delete from t1 where a = 18446744073709551615;
select * from t1;
drop table t1;
CREATE TABLE t1 (
  num int(11) NOT NULL, cs int(11) NOT NULL)
PARTITION BY RANGE (num) SUBPARTITION BY HASH (
cs) SUBPARTITIONS 2 (PARTITION p_X VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 
REORGANIZE PARTITION p_X INTO ( 
    PARTITION p_100 VALUES LESS THAN (100), 
    PARTITION p_X VALUES LESS THAN MAXVALUE 
    );
drop table t1;
CREATE TABLE t1 (
  id int(8) NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES 
(16421),
(19092),
(22589);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (
  id int(8) NOT NULL,
  severity tinyint(4) NOT NULL DEFAULT '0',
  priority tinyint(4) NOT NULL DEFAULT '0',
  status varchar(20) DEFAULT NULL,
  alien tinyint(4) NOT NULL
) DEFAULT CHARSET=latin1;
INSERT INTO t2 VALUES
(22589,1,1,'Need Feedback',0);
SELECT t2.id FROM t2 WHERE t2.id IN (SELECT id FROM t1 WHERE status = 'Verified');
drop table t1, t2;
create table t1 (c1 varchar(255),c2 tinyint,primary key(c1))
   partition by key (c1) partitions 10;
insert into t1 values ('aaa','1') on duplicate key update c2 = c2 + 1;
insert into t1 values ('aaa','1') on duplicate key update c2 = c2 + 1;
select * from t1;
drop table t1;
create table t1 (s1 bigint) partition by list (s1) (partition p1 values in (-9223372036854775808));
drop table t1;
create table t1(a int auto_increment, b int, primary key (a, b)) 
  partition by hash(b) partitions 2;
insert into t1 values (null, 1);
drop table t1;
create table t1(a int auto_increment primary key)
  partition by key(a) partitions 2;
insert into t1 values (null), (null), (null);
drop table t1;
CREATE TABLE t1(a INT NOT NULL, b TINYBLOB, KEY(a))
  PARTITION BY RANGE(a) ( PARTITION p0 VALUES LESS THAN (32));
INSERT INTO t1 VALUES (1, REPEAT('a', 10));
INSERT INTO t1 SELECT a + 1, b FROM t1;
INSERT INTO t1 SELECT a + 2, b FROM t1;
INSERT INTO t1 SELECT a + 4, b FROM t1;
INSERT INTO t1 SELECT a + 8, b FROM t1;
ALTER TABLE t1 ADD PARTITION (PARTITION p1 VALUES LESS THAN (64));
ALTER TABLE t1 DROP PARTITION p1;
DROP TABLE t1;
create table t (s1 int) partition by key (s1);
insert into t values (1);
drop table t;
create table t2 (b int);
create table t1 (a int)
PARTITION BY RANGE (b) (
  PARTITION p1 VALUES LESS THAN (10),
  PARTITION p2 VALUES LESS THAN (20)
) select * from t2;
drop table t1, t2;
create table t1
 (s1 timestamp on update current_timestamp, s2 int)
 partition by key(s1) partitions 3;
insert into t1 values (null,null);
update t1 set s2 = 1;
update t1 set s2 = 2;
drop table t1;
create table t1 (
  c0 int,
  c1 bigint,
  c2 set('sweet'),
  key (c2,c1,c0), 
  key(c0)
) partition by hash (c0) partitions 5;
insert ignore into t1 set c0 = -6502262, c1 = 3992917, c2 = 35019;
insert ignore into t1 set c0 = 241221, c1 = -6862346, c2 = 56644;
drop table t1;
CREATE TABLE t1(a int)
PARTITION BY RANGE (a) (
  PARTITION p1 VALUES LESS THAN (10),
  PARTITION p2 VALUES LESS THAN (20)
);
ALTER TABLE t1 ANALYZE PARTITION p1;
ALTER TABLE t1 CHECK PARTITION p1;
ALTER TABLE t1 REPAIR PARTITION p1;
ALTER TABLE t1 OPTIMIZE PARTITION p1;
DROP TABLE t1;
CREATE TABLE t1 (s1 BIGINT UNSIGNED)
  PARTITION BY RANGE (s1) (
  PARTITION p0 VALUES LESS THAN (0), 
  PARTITION p1 VALUES LESS THAN (1), 
  PARTITION p2 VALUES LESS THAN (18446744073709551615)
);
INSERT INTO t1 VALUES (0), (18446744073709551614);
DROP TABLE t1;
CREATE TABLE t1 (s1 BIGINT UNSIGNED)
 PARTITION BY RANGE (s1) (
  PARTITION p0 VALUES LESS THAN (0),
  PARTITION p1 VALUES LESS THAN (1),
  PARTITION p2 VALUES LESS THAN (18446744073709551614),
  PARTITION p3 VALUES LESS THAN MAXVALUE
);
SELECT * FROM t1;
SELECT * FROM t1 WHERE s1 = 0;
SELECT * FROM t1 WHERE s1 = 18446744073709551614;
SELECT * FROM t1 WHERE s1 = 18446744073709551615;
DROP TABLE t1;
CREATE TABLE t1 (s1 BIGINT UNSIGNED)  
 PARTITION BY RANGE (s1) (
  PARTITION p0 VALUES LESS THAN (0),
  PARTITION p1 VALUES LESS THAN (1),
  PARTITION p2 VALUES LESS THAN (18446744073709551615),
  PARTITION p3 VALUES LESS THAN MAXVALUE
);
DROP TABLE t1;
CREATE TABLE t1
(int_column INT, char_column CHAR(5),
PRIMARY KEY(char_column,int_column))
PARTITION BY KEY(char_column,int_column)
PARTITIONS 101;
INSERT INTO t1 (int_column, char_column) VALUES
(      39868 ,'zZZRW'),       
(     545592 ,'zZzSD'),       
(       4936 ,'zzzsT'),       
(       9274 ,'ZzZSX'),       
(     970185 ,'ZZzTN'),       
(     786036 ,'zZzTO'),       
(      37240 ,'zZzTv'),       
(     313801 ,'zzzUM'),       
(     782427 ,'ZZZva'),       
(     907955 ,'zZZvP'),       
(     453491 ,'zzZWV'),       
(     756594 ,'ZZZXU'),       
(     718061 ,'ZZzZH');
SELECT * FROM t1 ORDER BY char_column DESC;
DROP TABLE t1;
CREATE TABLE t1(id MEDIUMINT NOT NULL AUTO_INCREMENT,
                user CHAR(25), PRIMARY KEY(id))
                   PARTITION BY RANGE(id)
                   SUBPARTITION BY hash(id) subpartitions 2
                   (PARTITION pa1 values less than (10),
                    PARTITION pa2 values less than (20),
                    PARTITION pa11 values less than MAXVALUE);
insert into t1 (user) values ('mysql');
drop table t1;
CREATE TABLE  t1 (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `number` int,
  PRIMARY KEY (`ID`, number)
)
PARTITION BY RANGE (number) (
    PARTITION p0 VALUES LESS THAN (6),
    PARTITION p1 VALUES LESS THAN (11)
);
create table t2 (
  `ID` bigint(20),
  `createdDate` TIMESTAMP,
  `number` int
);
INSERT INTO t1 SET number=1;
insert into t2 select * from t1;
SELECT SLEEP(1);
UPDATE t1 SET number=6;
drop table t1, t2;
CREATE TABLE t1 (c1 INT)
       PARTITION BY LIST(1 DIV c1) (
       PARTITION p0 VALUES IN (NULL),
       PARTITION p1 VALUES IN (1)
     );
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
create table t1 (s1 int) partition by hash(s1) partitions 2;
create index i on t1 (s1);
insert into t1 values (1);
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1 order by s1 desc;
select * from t1;
drop table t1;
create table t1 (s1 int) partition by range(s1) 
        (partition pa1 values less than (10),
         partition pa2 values less than MAXVALUE);
create index i on t1 (s1);
insert into t1 values (1);
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1 order by s1 desc;
select * from t1;
drop table t1;
create table t1 (s1 int) partition by range(s1) 
        (partition pa1 values less than (10),
         partition pa2 values less than MAXVALUE);
create index i on t1 (s1);
insert into t1 values (20);
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1 order by s1 desc;
select * from t1;
drop table t1;
create table t1 (s1 int) partition by range(s1) 
        (partition pa1 values less than (10),
         partition pa2 values less than MAXVALUE);
create index i on t1 (s1);
insert into t1 values (1), (2), (3), (4), (5), (6), (7), (8);
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1;
insert into t1 select s1 from t1 order by s1 desc;
insert into t1 select s1 from t1 where s1=3;
drop table t1;
CREATE TABLE t1 (a int) PARTITION BY RANGE (a)
  (PARTITION p0 VALUES LESS THAN (100),
   PARTITION p1 VALUES LESS THAN (200),
   PARTITION p2 VALUES LESS THAN (300),
   PARTITION p3 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (10), (100), (200), (300), (400);
DROP TABLE t1;
CREATE TABLE t1 ( a INT, b INT, c INT, KEY bc(b, c) )
PARTITION BY KEY (a, b) PARTITIONS 3;
INSERT INTO t1 VALUES
(17, 1, -8),
(3,  1, -7),
(23, 1, -6),
(22, 1, -5),
(11, 1, -4),
(21, 1, -3),
(19, 1, -2),
(30, 1, -1),

(20, 1, 1),
(16, 1, 2),
(18, 1, 3),
(9,  1, 4),
(15, 1, 5),
(28, 1, 6),
(29, 1, 7),
(25, 1, 8),
(10, 1, 9),
(13, 1, 10),
(27, 1, 11),
(24, 1, 12),
(12, 1, 13),
(26, 1, 14),
(14, 1, 15);
SELECT b, c FROM t1 WHERE b = 1 GROUP BY b, c;
SELECT b, c FROM t1 WHERE b = 1 GROUP BY b, c;
DROP TABLE t1;
CREATE TABLE t1(id INT,KEY(id))
  PARTITION BY HASH(id) PARTITIONS 2;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (s1 INT PRIMARY KEY) PARTITION BY HASH(s1);
LOCK TABLES t1 WRITE, t1 b READ;
UNLOCK TABLES;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (s1 VARCHAR(5) PRIMARY KEY) PARTITION BY KEY(s1);
LOCK TABLES t1 WRITE, t1 b READ;
UNLOCK TABLES;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT) PARTITION BY HASH(a) PARTITIONS 1;
INSERT INTO t1 VALUES(0);
INSERT INTO t1 VALUES(0);
DROP TABLE t1;
CREATE TABLE t1_part (
  partkey int,
  nokey int
) PARTITION BY LINEAR HASH(partkey) PARTITIONS 3;
INSERT INTO t1_part VALUES (1, 1) , (10, 10);
CREATE VIEW v1 AS SELECT * FROM t1_part;
SELECT * FROM t1_part;
SELECT * FROM t1_part;
UPDATE t1_part AS A NATURAL JOIN t1_part B SET A.nokey = 2 , B.nokey = 3;
SELECT * FROM t1_part;
DROP VIEW v1;
DROP TABLE t1_part;
create table t1 (i int) partition by list (i)
  (partition p0 values in (1),
   partition p1 values in (2,3),
   partition p2 values in (4,5));
lock tables t1 write, t1 as a read, t1 as b read;
alter table t1 add column j int;
unlock tables;
drop table t1;
CREATE TABLE t1(a INT PRIMARY KEY) PARTITION BY LINEAR KEY (a);
CREATE ALGORITHM=TEMPTABLE VIEW vtmp AS
SELECT 1 FROM t1 AS t1_0 JOIN t1 ON t1_0.a LIKE (SELECT 1 FROM t1);
SELECT * FROM vtmp;
DROP VIEW vtmp;
DROP TABLE t1;
CREATE TABLE t1 (
  a INT PRIMARY KEY,
  b INT,
  c CHAR(1),
  d INT,
  KEY (c,d)
) PARTITION BY KEY () PARTITIONS 1;
INSERT INTO t1 VALUES (1,1,'a',1), (2,2,'a',1);
DROP TABLE t1;
CREATE TABLE t1 (c1 int(11) DEFAULT NULL, KEY c1 (c1))
  PARTITION BY RANGE (c1)
    (PARTITION a VALUES LESS THAN (10),
     PARTITION b VALUES LESS THAN (100),
     PARTITION c VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
DROP TABLE t1;
SELECT @@sql_mode;
CREATE TABLE t1 (a int PRIMARY KEY)
PARTITION BY LINEAR KEY(a) PARTITIONS 2;
DROP TABLE t1;
select @@sql_mode;
DROP TABLE IF EXISTS `example`;
SELECT partition_expression FROM information_schema.partitions
WHERE table_schema = 'test' AND table_name = 't1';
SELECT partition_expression FROM information_schema.partitions
WHERE table_schema = 'test' AND table_name = 't1';
SELECT partition_expression FROM information_schema.partitions
WHERE table_schema = 'test' AND table_name = 't1';
CREATE TABLE t (a BIGINT NOT NULL)
  PARTITION BY KEY(a) PARTITIONS 2;
INSERT INTO t VALUES(0);
SELECT 1 FROM t WHERE a = 0x8000000000000000;
DROP TABLE t;
CREATE TABLE t (a VARCHAR(10) NOT NULL,b INT,PRIMARY KEY (b)) ENGINE=INNODB
PARTITION BY RANGE (b)
(PARTITION pa VALUES LESS THAN (2),
 PARTITION pb VALUES LESS THAN (20),
 PARTITION pc VALUES LESS THAN (30),
 PARTITION pd VALUES LESS THAN (40));
INSERT INTO t
VALUES('A',0),('B',1),('C',2),('D',3),('E',4),('F',5),('G',25),('H',35);
ALTER TABLE t ADD COLUMN r INT UNSIGNED NOT NULL AUTO_INCREMENT, ADD UNIQUE
KEY (r,b), ALGORITHM=INPLACE, LOCK=SHARED;
SELECT * FROM t;
DROP TABLE t;
CREATE SCHEMA tables;
CREATE TABLE tables.mysql(a INT);
ALTER TABLE tables.mysql PARTITION BY HASH (a);
DROP SCHEMA tables;
CREATE TABLE t1(c1 INT, c2 CHAR) PARTITION BY HASH(c1) PARTITIONS 50;
SELECT MBRTOUCHES(a.c2, b.c2) FROM t1 AS a JOIN t1 AS b;
ALTER TABLE t1 CONVERT TO CHARACTER SET latin1;
DROP TABLE t1;
CREATE TABLE t1 (s1 INT PRIMARY KEY) PARTITION BY HASH(s1);
LOCK TABLES t1 WRITE, t1 b READ;
UNLOCK TABLES;
ALTER TABLE t1 CONVERT TO CHARACTER SET latin1;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT NOT NULL, c2 INT)
    PARTITION BY RANGE (c1) PARTITIONS 3 SUBPARTITION BY KEY (c2) (
        PARTITION p1 VALUES LESS THAN (200) (
            SUBPARTITION p11,
            SUBPARTITION p12,
            SUBPARTITION p13),
        PARTITION p2 VALUES LESS THAN (600) (
            SUBPARTITION p21,
            SUBPARTITION p22,
            SUBPARTITION p23),
        PARTITION p3 VALUES LESS THAN (1800) (
            SUBPARTITION p31,
            SUBPARTITION p32,
            SUBPARTITION p33));
ALTER TABLE t1 CONVERT TO CHARACTER SET latin1;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 (i, j) VALUES (-1, 1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 (i, j) VALUES (-1, 1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i+1) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
DROP TABLE t1;
CREATE TABLE t1 (i INT) PARTITION BY LIST COLUMNS (i) (PARTITION p0 VALUES IN (-2,-1), PARTITION p1 VALUES IN (0, 1, 2));
ALTER TABLE t1 RENAME COLUMN i TO k REMOVE PARTITIONING;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 (i, j) VALUES (-1, 1);
ALTER TABLE t1 RENAME COLUMN i TO k PARTITION BY RANGE(k) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
SELECT k, j FROM t1 PARTITION (p0);
SELECT k, j FROM t1 PARTITION (p1);
ALTER TABLE t1 RENAME COLUMN k TO j, RENAME COLUMN j TO k PARTITION BY RANGE(k) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
SELECT k, j FROM t1 PARTITION (p0);
SELECT k, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT, PRIMARY KEY (i)) PARTITION BY KEY () PARTITIONS 2 (PARTITION p0, PARTITION p1);
INSERT INTO t1 (i, j) VALUES (-1, 1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
ALTER TABLE t1 RENAME COLUMN i TO j, RENAME COLUMN j TO i;
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT, PRIMARY KEY (i, j)) PARTITION BY KEY (i) PARTITIONS 2 (PARTITION p0, PARTITION p1);
INSERT INTO t1 (i, j) VALUES (-1, 1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
ALTER TABLE t1 RENAME COLUMN i TO j, RENAME COLUMN j TO i PARTITION BY KEY (i) PARTITIONS 2 (PARTITION p0, PARTITION p1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i+1) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
DROP TABLE t1;
CREATE TABLE t1 (i INT) PARTITION BY LIST COLUMNS (i) (PARTITION p0 VALUES IN (-2,-1), PARTITION p1 VALUES IN (0, 1, 2));
ALTER TABLE t1 DROP COLUMN i, ADD COLUMN i INT REMOVE PARTITIONING;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT) PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 DROP COLUMN i, ADD COLUMN i INT PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 (i, j) VALUES (-1, 1);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
ALTER TABLE t1 DROP COLUMN i, ADD COLUMN i INT DEFAULT 1 PARTITION BY RANGE(i) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN MAXVALUE);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT, PRIMARY KEY (i, j)) PARTITION BY KEY () PARTITIONS 2 (PARTITION p0, PARTITION p1);
INSERT INTO t1 (i, j) VALUES (1, 2);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
ALTER TABLE t1 DROP COLUMN i;
SELECT j FROM t1 PARTITION (p0);
SELECT j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t1 (i INT, j INT, PRIMARY KEY (i, j)) PARTITION BY KEY () PARTITIONS 2 (PARTITION p0, PARTITION p1);
INSERT INTO t1 (i, j) VALUES (1, 2);
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
ALTER TABLE t1 DROP COLUMN i, ADD COLUMN i INT DEFAULT 0;
SELECT i, j FROM t1 PARTITION (p0);
SELECT i, j FROM t1 PARTITION (p1);
DROP TABLE t1;
CREATE TABLE t(  id int unsigned NOT NULL,
        data varchar(2) DEFAULT NULL,
        KEY data_idx (data(1),id)
        ) DEFAULT CHARSET=utf8mb3
        /*!50100 PARTITION BY RANGE (id)
        (PARTITION p10 VALUES LESS THAN (10) ,
         PARTITION p20 VALUES LESS THAN (20) ) */;
INSERT INTO t VALUES (6, 'ab'), (4, 'ab'), (5, 'ab'), (16, 'ab'), (14, 'ab'), (15, 'ab'), (5, 'ac'), (15, 'aa');
SELECT id FROM t WHERE data = 'ab' ORDER BY id ASC;
DROP TABLE t;
CREATE TABLE t1 (c1 INT, c2 CHAR(32) DEFAULT (RANDOM_BYTES(32))) PARTITION BY HASH(c1);
CREATE TABLE t2 (c1 INT, c2 CHAR(32) DEFAULT (RANDOM_BYTES(32))) PARTITION BY RANGE(c1) (PARTITION p1 VALUES LESS THAN(100));
CREATE TABLE t (c1 INT, c2 INT) PARTITION BY RANGE(c1) (PARTITION p1 VALUES LESS THAN(100));
ALTER TABLE t MODIFY COLUMN c2 CHAR(32) DEFAULT (RANDOM_BYTES(32));
DROP TABLE t, t1, t2;
CREATE TABLE t (c1 INT, c2 INT) PARTITION BY RANGE(c1) (PARTITION p1 VALUES LESS THAN(100));
DROP TABLE t;
CREATE TABLE v0 ( c1 SERIAL )
PARTITION BY RANGE ( c1 )
SUBPARTITION BY
LINEAR HASH ( c1 DIV - c1 ) ( PARTITION p2 VALUES LESS THAN MAXVALUE );
DROP TABLE v0;
