drop table if exists t1, t2;
CREATE TABLE t1 (
 a INT,
 b INT,
 KEY a (a,b)
)
PARTITION BY HASH (a) PARTITIONS 1;
INSERT INTO t1 VALUES (0, 580092), (3, 894076), (4, 805483), (4, 913540), (6, 611137), (8, 171602), (9, 599495), (9, 746305), (10, 272829), (10, 847519), (12, 258869), (12, 929028), (13, 288970), (15, 20971), (15, 105839), (16, 788272), (17, 76914), (18, 827274), (19, 802258), (20, 123677), (20, 587729), (22, 701449), (25, 31565), (25, 230782), (25, 442887), (25, 733139), (25, 851020);
DROP TABLE t1;
create table t1 (a DATETIME)
partition by range (TO_DAYS(a))
subpartition by hash(to_seconds(a))
(partition p0 values less than (1));
drop table t1;
create table t1 (a datetime not null)
partition by range (TO_SECONDS(a))
( partition p0 VALUES LESS THAN (TO_SECONDS('2007-03-08 00:00:00')),
  partition p1 VALUES LESS THAN (TO_SECONDS('2007-04-01 00:00:00')));
select partition_method, partition_expression, partition_description
  from information_schema.partitions where table_name = "t1";
INSERT INTO t1 VALUES ('2007-03-01 12:00:00'), ('2007-03-07 12:00:00');
INSERT INTO t1 VALUES ('2007-03-08 12:00:00'), ('2007-03-15 12:00:00');
drop table t1;
create table t1 (a date)
partition by range(to_seconds(a))
(partition p0 values less than (to_seconds('2004-01-01')),
 partition p1 values less than (to_seconds('2005-01-01')));
insert into t1 values ('2003-12-30'),('2004-12-31');
select * from t1;
select * from t1 where a <= '2003-12-31';
select * from t1 where a <= '2005-01-01';
drop table t1;
create table t1 (a datetime)
partition by range(to_seconds(a))
(partition p0 values less than (to_seconds('2004-01-01 12:00:00')),
 partition p1 values less than (to_seconds('2005-01-01 12:00:00')));
insert into t1 values ('2004-01-01 11:59:29'),('2005-01-01 11:59:59');
select * from t1;
select * from t1 where a <= '2004-01-01 11:59:59';
select * from t1 where a <= '2005-01-01';
drop table t1;
create table t1 (a int, b char(20))
partition by range columns(b)
(partition p0 values less than ("b"));
drop table t1;
create table t1 (a int)
partition by range (a)
( partition p0 values less than (maxvalue));
drop table t1;
create table t1 (a integer)
partition by range (a)
( partition p0 values less than (4),
  partition p1 values less than (100));
alter table t1 drop partition p0;
drop table t1;
create table t1 (a integer)
partition by range (a)
( partition p0 values less than (4),
  partition p1 values less than (100));
LOCK TABLES t1 WRITE;
alter table t1 drop partition p0;
alter table t1 reorganize partition p1 into
( partition p0 values less than (4),
  partition p1 values less than (100));
alter table t1 add partition ( partition p2 values less than (200));
UNLOCK TABLES;
drop table t1;
create table t1 (a int unsigned)
partition by range (a)
(partition pnull values less than (0),
 partition p0 values less than (1),
 partition p1 values less than(2));
insert into t1 values (null),(0),(1);
select * from t1 where a is null;
select * from t1 where a >= 0;
select * from t1 where a < 0;
select * from t1 where a <= 0;
select * from t1 where a > 1;
drop table t1;
create table t1 (a int unsigned, b int unsigned)
partition by range (a)
subpartition by hash (b)
subpartitions 2
(partition pnull values less than (0),
 partition p0 values less than (1),
 partition p1 values less than(2));
insert into t1 values (null,0),(null,1),(0,0),(0,1),(1,0),(1,1);
select * from t1 where a is null;
select * from t1 where a >= 0;
select * from t1 where a < 0;
select * from t1 where a <= 0;
select * from t1 where a > 1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than maxvalue);
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
INSERT into t1 values (15, 1, 1);
select * from t1;
ALTER TABLE t1
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than maxvalue);
select * from t1;
drop table if exists t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null)
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than maxvalue);
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
INSERT into t1 values (15, 1, 1);
select * from t1;
ALTER TABLE t1
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than maxvalue);
select * from t1;
drop table if exists t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than (15));
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
select * from t1;
ALTER TABLE t1
partition by range (a)
partitions 3
(partition x1 values less than (5),
 partition x2 values less than (10),
 partition x3 values less than (15));
select * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
(partition x1 values less than (1));
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b)) 
partition by range (a)
subpartition by hash (a+b) 
( partition x1 values less than (1)
  ( subpartition x11,
    subpartition x12),
   partition x2 values less than (5)
   ( subpartition x21,
     subpartition x22)
);
SELECT * from t1;
ALTER TABLE t1 ADD COLUMN d int;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb nodegroup 0,
    subpartition x12 engine innodb nodegroup 1),
   partition x2 values less than (5)
   ( subpartition x21 engine innodb nodegroup 0,
     subpartition x22 engine innodb nodegroup 1)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 nodegroup 0,
    subpartition x12 nodegroup 1),
   partition x2 values less than (5)
   ( subpartition x21 nodegroup 0,
     subpartition x22 nodegroup 1)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb nodegroup 0,
    subpartition x12 engine innodb nodegroup 1),
   partition x2 values less than (5)
   ( subpartition x21 engine innodb nodegroup 0,
     subpartition x22 engine innodb nodegroup 1)
);
INSERT into t1 VALUES (1,1,1);
INSERT into t1 VALUES (4,1,1);
SELECT * from t1;
ALTER TABLE t1
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb nodegroup 0,
    subpartition x12 engine innodb nodegroup 1),
   partition x2 values less than (5)
   ( subpartition x21 engine innodb nodegroup 0,
     subpartition x22 engine innodb nodegroup 1)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
  partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
INSERT into t1 VALUES (1,1,1);
INSERT into t1 VALUES (4,1,1);
SELECT * from t1;
ALTER TABLE t1
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
  partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
   partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
INSERT into t1 VALUES (1,1,1);
INSERT into t1 VALUES (4,1,1);
SELECT * from t1;
ALTER TABLE t1
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
  partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
  partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
INSERT into t1 VALUES (1,1,1);
INSERT into t1 VALUES (4,1,1);
SELECT * from t1;
ALTER TABLE t1
partition by range (a)
subpartition by hash (a+b)
( partition x1 values less than (1)
  ( subpartition x11 engine innodb,
    subpartition x12 engine innodb),
  partition x2 values less than (5)
  ( subpartition x21 engine innodb,
    subpartition x22 engine innodb)
);
SELECT * from t1;
drop table t1;
CREATE TABLE t1 (c1 int default NULL, c2 varchar(30) default NULL, 
c3 date default NULL)
PARTITION BY RANGE (year(c3)) (PARTITION p0 VALUES LESS THAN (1995),
PARTITION p1 VALUES LESS THAN (1996) , PARTITION p2 VALUES LESS THAN (1997) ,
PARTITION p3 VALUES LESS THAN (1998) , PARTITION p4 VALUES LESS THAN (1999) ,
PARTITION p5 VALUES LESS THAN (2000) , PARTITION p6 VALUES LESS THAN (2001) ,
PARTITION p7 VALUES LESS THAN (2002) , PARTITION p8 VALUES LESS THAN (2003) ,
PARTITION p9 VALUES LESS THAN (2004) , PARTITION p10 VALUES LESS THAN (2010),
PARTITION p11 VALUES LESS THAN MAXVALUE );
INSERT INTO t1 VALUES (1, 'testing partitions', '1995-07-17'),
(3, 'testing partitions','1995-07-31'),
(5, 'testing partitions','1995-08-13'),
(7, 'testing partitions','1995-08-26'),
(9, 'testing partitions','1995-09-09'),
(0, 'testing partitions','2000-07-10'),
(2, 'testing partitions','2000-07-23'),
(4, 'testing partitions','2000-08-05'),
(6, 'testing partitions','2000-08-19'),
(8, 'testing partitions','2000-09-01');
SELECT COUNT(*) FROM t1 WHERE c3 BETWEEN '1996-12-31' AND '2000-12-31';
DROP TABLE t1;
create table t1 (a bigint unsigned)
partition by range (a)
(partition p0 values less than (0),
 partition p1 values less than (10));
drop table t1;
create table t1 (a bigint unsigned)
partition by range (a)
(partition p0 values less than (2),
 partition p1 values less than (10));
drop table t1;
create table t1 (a int)
partition by range (MOD(a,3))
subpartition by hash(a)
subpartitions 2
(partition p0 values less than (1),
 partition p1 values less than (2),
 partition p2 values less than (3),
 partition p3 values less than (4));
ALTER TABLE t1 DROP PARTITION p3;
ALTER TABLE t1 DROP PARTITION p1;
ALTER TABLE t1 DROP PARTITION p2;
drop table t1;
create table t1 (a int)
partition by range (MOD(a,3))
subpartition by hash(a)
subpartitions 2
(partition p0 values less than (1),
 partition p1 values less than (2),
 partition p2 values less than (3),
 partition p3 values less than (4));
ALTER TABLE t1 DROP PARTITION p0;
ALTER TABLE t1 DROP PARTITION p1;
ALTER TABLE t1 DROP PARTITION p2;
drop table t1;
create table t1 (a int DEFAULT NULL,
                 b varchar(30) DEFAULT NULL,
                 c date DEFAULT NULL)
DEFAULT CHARSET=latin1;
insert into t1 values (1, 'abc', '1995-01-01');
insert into t1 values (1, 'abc', '1995-01-02');
insert into t1 values (1, 'abc', '1995-01-03');
insert into t1 values (1, 'abc', '1995-01-04');
insert into t1 values (1, 'abc', '1995-01-05');
insert into t1 values (1, 'abc', '1995-01-06');
insert into t1 values (1, 'abc', '1995-01-07');
insert into t1 values (1, 'abc', '1995-01-08');
insert into t1 values (1, 'abc', '1995-01-09');
insert into t1 values (1, 'abc', '1995-01-10');
insert into t1 values (1, 'abc', '1995-01-11');
insert into t1 values (1, 'abc', '1995-01-12');
insert into t1 values (1, 'abc', '1995-01-13');
insert into t1 values (1, 'abc', '1995-01-14');
insert into t1 values (1, 'abc', '1995-01-15');
insert into t1 values (1, 'abc', '1997-01-01');
insert into t1 values (1, 'abc', '1997-01-02');
insert into t1 values (1, 'abc', '1997-01-03');
insert into t1 values (1, 'abc', '1997-01-04');
insert into t1 values (1, 'abc', '1997-01-05');
insert into t1 values (1, 'abc', '1997-01-06');
insert into t1 values (1, 'abc', '1997-01-07');
insert into t1 values (1, 'abc', '1997-01-08');
insert into t1 values (1, 'abc', '1997-01-09');
insert into t1 values (1, 'abc', '1997-01-10');
insert into t1 values (1, 'abc', '1997-01-11');
insert into t1 values (1, 'abc', '1997-01-12');
insert into t1 values (1, 'abc', '1997-01-13');
insert into t1 values (1, 'abc', '1997-01-14');
insert into t1 values (1, 'abc', '1997-01-15');
insert into t1 values (1, 'abc', '1998-01-01');
insert into t1 values (1, 'abc', '1998-01-02');
insert into t1 values (1, 'abc', '1998-01-03');
insert into t1 values (1, 'abc', '1998-01-04');
insert into t1 values (1, 'abc', '1998-01-05');
insert into t1 values (1, 'abc', '1998-01-06');
insert into t1 values (1, 'abc', '1998-01-07');
insert into t1 values (1, 'abc', '1998-01-08');
insert into t1 values (1, 'abc', '1998-01-09');
insert into t1 values (1, 'abc', '1998-01-10');
insert into t1 values (1, 'abc', '1998-01-11');
insert into t1 values (1, 'abc', '1998-01-12');
insert into t1 values (1, 'abc', '1998-01-13');
insert into t1 values (1, 'abc', '1998-01-14');
insert into t1 values (1, 'abc', '1998-01-15');
insert into t1 values (1, 'abc', '1999-01-01');
insert into t1 values (1, 'abc', '1999-01-02');
insert into t1 values (1, 'abc', '1999-01-03');
insert into t1 values (1, 'abc', '1999-01-04');
insert into t1 values (1, 'abc', '1999-01-05');
insert into t1 values (1, 'abc', '1999-01-06');
insert into t1 values (1, 'abc', '1999-01-07');
insert into t1 values (1, 'abc', '1999-01-08');
insert into t1 values (1, 'abc', '1999-01-09');
insert into t1 values (1, 'abc', '1999-01-10');
insert into t1 values (1, 'abc', '1999-01-11');
insert into t1 values (1, 'abc', '1999-01-12');
insert into t1 values (1, 'abc', '1999-01-13');
insert into t1 values (1, 'abc', '1999-01-14');
insert into t1 values (1, 'abc', '1999-01-15');
insert into t1 values (1, 'abc', '2000-01-01');
insert into t1 values (1, 'abc', '2000-01-02');
insert into t1 values (1, 'abc', '2000-01-03');
insert into t1 values (1, 'abc', '2000-01-04');
insert into t1 values (1, 'abc', '2000-01-05');
insert into t1 values (1, 'abc', '2000-01-06');
insert into t1 values (1, 'abc', '2000-01-07');
insert into t1 values (1, 'abc', '2000-01-08');
insert into t1 values (1, 'abc', '2000-01-09');
insert into t1 values (1, 'abc', '2000-01-15');
insert into t1 values (1, 'abc', '2000-01-11');
insert into t1 values (1, 'abc', '2000-01-12');
insert into t1 values (1, 'abc', '2000-01-13');
insert into t1 values (1, 'abc', '2000-01-14');
insert into t1 values (1, 'abc', '2000-01-15');
insert into t1 values (1, 'abc', '2001-01-01');
insert into t1 values (1, 'abc', '2001-01-02');
insert into t1 values (1, 'abc', '2001-01-03');
insert into t1 values (1, 'abc', '2001-01-04');
insert into t1 values (1, 'abc', '2001-01-05');
insert into t1 values (1, 'abc', '2001-01-06');
insert into t1 values (1, 'abc', '2001-01-07');
insert into t1 values (1, 'abc', '2001-01-08');
insert into t1 values (1, 'abc', '2001-01-09');
insert into t1 values (1, 'abc', '2001-01-15');
insert into t1 values (1, 'abc', '2001-01-11');
insert into t1 values (1, 'abc', '2001-01-12');
insert into t1 values (1, 'abc', '2001-01-13');
insert into t1 values (1, 'abc', '2001-01-14');
insert into t1 values (1, 'abc', '2001-01-15');
alter table t1
partition by range (year(c))
(partition p5 values less than (2000), partition p10 values less than (2010));
alter table t1
reorganize partition p5 into
(partition p1 values less than (1996),
 partition p2 values less than (1997),
 partition p3 values less than (1998),
 partition p4 values less than (1999),
 partition p5 values less than (2000));
drop table t1;
CREATE TABLE t1 (a date)
PARTITION BY RANGE (TO_DAYS(a))
(PARTITION p3xx VALUES LESS THAN (TO_DAYS('2004-01-01')),
 PARTITION p401 VALUES LESS THAN (TO_DAYS('2004-02-01')),
 PARTITION p402 VALUES LESS THAN (TO_DAYS('2004-03-01')),
 PARTITION p403 VALUES LESS THAN (TO_DAYS('2004-04-01')),
 PARTITION p404 VALUES LESS THAN (TO_DAYS('2004-05-01')),
 PARTITION p405 VALUES LESS THAN (TO_DAYS('2004-06-01')),
 PARTITION p406 VALUES LESS THAN (TO_DAYS('2004-07-01')),
 PARTITION p407 VALUES LESS THAN (TO_DAYS('2004-08-01')),
 PARTITION p408 VALUES LESS THAN (TO_DAYS('2004-09-01')),
 PARTITION p409 VALUES LESS THAN (TO_DAYS('2004-10-01')),
 PARTITION p410 VALUES LESS THAN (TO_DAYS('2004-11-01')),
 PARTITION p411 VALUES LESS THAN (TO_DAYS('2004-12-01')),
 PARTITION p412 VALUES LESS THAN (TO_DAYS('2005-01-01')),
 PARTITION p501 VALUES LESS THAN (TO_DAYS('2005-02-01')),
 PARTITION p502 VALUES LESS THAN (TO_DAYS('2005-03-01')),
 PARTITION p503 VALUES LESS THAN (TO_DAYS('2005-04-01')),
 PARTITION p504 VALUES LESS THAN (TO_DAYS('2005-05-01')),
 PARTITION p505 VALUES LESS THAN (TO_DAYS('2005-06-01')),
 PARTITION p506 VALUES LESS THAN (TO_DAYS('2005-07-01')),
 PARTITION p507 VALUES LESS THAN (TO_DAYS('2005-08-01')),
 PARTITION p508 VALUES LESS THAN (TO_DAYS('2005-09-01')),
 PARTITION p509 VALUES LESS THAN (TO_DAYS('2005-10-01')),
 PARTITION p510 VALUES LESS THAN (TO_DAYS('2005-11-01')),
 PARTITION p511 VALUES LESS THAN (TO_DAYS('2005-12-01')),
 PARTITION p512 VALUES LESS THAN (TO_DAYS('2006-01-01')),
 PARTITION p601 VALUES LESS THAN (TO_DAYS('2006-02-01')),
 PARTITION p602 VALUES LESS THAN (TO_DAYS('2006-03-01')),
 PARTITION p603 VALUES LESS THAN (TO_DAYS('2006-04-01')),
 PARTITION p604 VALUES LESS THAN (TO_DAYS('2006-05-01')),
 PARTITION p605 VALUES LESS THAN (TO_DAYS('2006-06-01')),
 PARTITION p606 VALUES LESS THAN (TO_DAYS('2006-07-01')),
 PARTITION p607 VALUES LESS THAN (TO_DAYS('2006-08-01')));
INSERT INTO t1 VALUES ('2003-01-13'),('2003-06-20'),('2003-08-30');
INSERT INTO t1 VALUES ('2003-04-13'),('2003-07-20'),('2003-10-30');
INSERT INTO t1 VALUES ('2003-05-13'),('2003-11-20'),('2003-12-30');
INSERT INTO t1 VALUES ('2004-01-13'),('2004-01-20'),('2004-01-30');
INSERT INTO t1 VALUES ('2004-02-13'),('2004-02-20'),('2004-02-28');
INSERT INTO t1 VALUES ('2004-03-13'),('2004-03-20'),('2004-03-30');
INSERT INTO t1 VALUES ('2004-04-13'),('2004-04-20'),('2004-04-30');
INSERT INTO t1 VALUES ('2004-05-13'),('2004-05-20'),('2004-05-30');
INSERT INTO t1 VALUES ('2004-06-13'),('2004-06-20'),('2004-06-30');
INSERT INTO t1 VALUES ('2004-07-13'),('2004-07-20'),('2004-07-30');
INSERT INTO t1 VALUES ('2004-08-13'),('2004-08-20'),('2004-08-30');
INSERT INTO t1 VALUES ('2004-09-13'),('2004-09-20'),('2004-09-30');
INSERT INTO t1 VALUES ('2004-10-13'),('2004-10-20'),('2004-10-30');
INSERT INTO t1 VALUES ('2004-11-13'),('2004-11-20'),('2004-11-30');
INSERT INTO t1 VALUES ('2004-12-13'),('2004-12-20'),('2004-12-30');
INSERT INTO t1 VALUES ('2005-01-13'),('2005-01-20'),('2005-01-30');
INSERT INTO t1 VALUES ('2005-02-13'),('2005-02-20'),('2005-02-28');
INSERT INTO t1 VALUES ('2005-03-13'),('2005-03-20'),('2005-03-30');
INSERT INTO t1 VALUES ('2005-04-13'),('2005-04-20'),('2005-04-30');
INSERT INTO t1 VALUES ('2005-05-13'),('2005-05-20'),('2005-05-30');
INSERT INTO t1 VALUES ('2005-06-13'),('2005-06-20'),('2005-06-30');
INSERT INTO t1 VALUES ('2005-07-13'),('2005-07-20'),('2005-07-30');
INSERT INTO t1 VALUES ('2005-08-13'),('2005-08-20'),('2005-08-30');
INSERT INTO t1 VALUES ('2005-09-13'),('2005-09-20'),('2005-09-30');
INSERT INTO t1 VALUES ('2005-10-13'),('2005-10-20'),('2005-10-30');
INSERT INTO t1 VALUES ('2005-11-13'),('2005-11-20'),('2005-11-30');
INSERT INTO t1 VALUES ('2005-12-13'),('2005-12-20'),('2005-12-30');
INSERT INTO t1 VALUES ('2006-01-13'),('2006-01-20'),('2006-01-30');
INSERT INTO t1 VALUES ('2006-02-13'),('2006-02-20'),('2006-02-28');
INSERT INTO t1 VALUES ('2006-03-13'),('2006-03-20'),('2006-03-30');
INSERT INTO t1 VALUES ('2006-04-13'),('2006-04-20'),('2006-04-30');
INSERT INTO t1 VALUES ('2006-05-13'),('2006-05-20'),('2006-05-30');
INSERT INTO t1 VALUES ('2006-06-13'),('2006-06-20'),('2006-06-30');
INSERT INTO t1 VALUES ('2006-07-13'),('2006-07-20'),('2006-07-30');
SELECT * FROM t1
WHERE a >= '2004-07-01' AND a <= '2004-09-30';
SELECT * from t1
WHERE (a >= '2004-07-01' AND a <= '2004-09-30') OR
      (a >= '2005-07-01' AND a <= '2005-09-30');
DROP TABLE t1;
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t2 (
  defid int(10) unsigned NOT NULL,
  day int(10) unsigned NOT NULL,
  count int(10) unsigned NOT NULL,
  filler char(200),
  KEY (defid,day)
) 
PARTITION BY RANGE (day) (
  PARTITION p7 VALUES LESS THAN (20070401) , 
  PARTITION p8 VALUES LESS THAN (20070501));
insert into t2 select 20, 20070311, 1, 'filler' from t1 A, t1 B;
insert into t2 select 20, 20070411, 1, 'filler' from t1 A, t1 B;
insert into t2 values(52, 20070321, 123, 'filler');
insert into t2 values(52, 20070322, 456, 'filler');
select sum(count) from t2 ch where ch.defid in (50,52) and ch.day between 20070320 and 20070401 group by defid;
drop table t1, t2;
CREATE TABLE t1 (
 a INT,
 b INT,
 KEY ( a, b )
) PARTITION BY HASH (a) PARTITIONS 1;
CREATE TABLE t2 (
 a INT,
 b INT,
 KEY ( a, b )
);
INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
INSERT INTO t1 SELECT a +  5, b +  5 FROM t1;
INSERT INTO t1 SELECT a + 10, b + 10 FROM t1;
INSERT INTO t1 SELECT a + 20, b + 20 FROM t1;
INSERT INTO t1 SELECT a + 40, b + 40 FROM t1;
INSERT INTO t2 SELECT * FROM t1;
SELECT a, MAX(b) FROM t1 WHERE a IN (10, 100) GROUP BY a;
DROP TABLE t1, t2;
