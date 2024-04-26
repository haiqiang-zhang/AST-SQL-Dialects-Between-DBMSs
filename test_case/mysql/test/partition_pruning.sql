--

-- Skipping the test when log-bin is enabled and binlog_format due to unsafe statement:
-- LIMIT clause.
--source include/not_binlog_format_statement.inc
--source include/have_innodb_min_8k.inc

--source include/no_valgrind_without_big.inc
let $verify_without_partitions=0;
CREATE TABLE t1 (a INT PRIMARY KEY)
PARTITION BY RANGE (a) (
PARTITION p0 VALUES LESS THAN (1),
PARTITION p1 VALUES LESS THAN (2),
PARTITION p2 VALUES LESS THAN (3),
PARTITION p3 VALUES LESS THAN (4),
PARTITION p4 VALUES LESS THAN (5),
PARTITION p5 VALUES LESS THAN (6),
PARTITION max VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;

INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7),(8);
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY)
PARTITION BY RANGE (a) (
PARTITION p0 VALUES LESS THAN (1),
PARTITION p1 VALUES LESS THAN (2),
PARTITION p2 VALUES LESS THAN (3),
PARTITION p3 VALUES LESS THAN (4),
PARTITION p4 VALUES LESS THAN (5),
PARTITION p5 VALUES LESS THAN (6),
PARTITION max VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;

INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7),(8);

SELECT * FROM t1 WHERE a < 1;
SELECT * FROM t1 WHERE a < 2;
SELECT * FROM t1 WHERE a < 3;
SELECT * FROM t1 WHERE a < 4;
SELECT * FROM t1 WHERE a < 5;
SELECT * FROM t1 WHERE a < 6;
SELECT * FROM t1 WHERE a < 7;
SELECT * FROM t1 WHERE a <= 1;
SELECT * FROM t1 WHERE a <= 2;
SELECT * FROM t1 WHERE a <= 3;
SELECT * FROM t1 WHERE a <= 4;
SELECT * FROM t1 WHERE a <= 5;
SELECT * FROM t1 WHERE a <= 6;
SELECT * FROM t1 WHERE a <= 7;
SELECT * FROM t1 WHERE a = 1;
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 3;
SELECT * FROM t1 WHERE a = 4;
SELECT * FROM t1 WHERE a = 5;
SELECT * FROM t1 WHERE a = 6;
SELECT * FROM t1 WHERE a = 7;
SELECT * FROM t1 WHERE a >= 1;
SELECT * FROM t1 WHERE a >= 2;
SELECT * FROM t1 WHERE a >= 3;
SELECT * FROM t1 WHERE a >= 4;
SELECT * FROM t1 WHERE a >= 5;
SELECT * FROM t1 WHERE a >= 6;
SELECT * FROM t1 WHERE a >= 7;
SELECT * FROM t1 WHERE a > 1;
SELECT * FROM t1 WHERE a > 2;
SELECT * FROM t1 WHERE a > 3;
SELECT * FROM t1 WHERE a > 4;
SELECT * FROM t1 WHERE a > 5;
SELECT * FROM t1 WHERE a > 6;
SELECT * FROM t1 WHERE a > 7;
DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY)
PARTITION BY RANGE (a) (
PARTITION p0 VALUES LESS THAN (1),
PARTITION p1 VALUES LESS THAN (2),
PARTITION p2 VALUES LESS THAN (3),
PARTITION p3 VALUES LESS THAN (4),
PARTITION p4 VALUES LESS THAN (5),
PARTITION max VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;

INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7);

SELECT * FROM t1 WHERE a < 1;
SELECT * FROM t1 WHERE a < 2;
SELECT * FROM t1 WHERE a < 3;
SELECT * FROM t1 WHERE a < 4;
SELECT * FROM t1 WHERE a < 5;
SELECT * FROM t1 WHERE a < 6;
SELECT * FROM t1 WHERE a <= 1;
SELECT * FROM t1 WHERE a <= 2;
SELECT * FROM t1 WHERE a <= 3;
SELECT * FROM t1 WHERE a <= 4;
SELECT * FROM t1 WHERE a <= 5;
SELECT * FROM t1 WHERE a <= 6;
SELECT * FROM t1 WHERE a = 1;
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 3;
SELECT * FROM t1 WHERE a = 4;
SELECT * FROM t1 WHERE a = 5;
SELECT * FROM t1 WHERE a = 6;
SELECT * FROM t1 WHERE a >= 1;
SELECT * FROM t1 WHERE a >= 2;
SELECT * FROM t1 WHERE a >= 3;
SELECT * FROM t1 WHERE a >= 4;
SELECT * FROM t1 WHERE a >= 5;
SELECT * FROM t1 WHERE a >= 6;
SELECT * FROM t1 WHERE a > 1;
SELECT * FROM t1 WHERE a > 2;
SELECT * FROM t1 WHERE a > 3;
SELECT * FROM t1 WHERE a > 4;
SELECT * FROM t1 WHERE a > 5;
SELECT * FROM t1 WHERE a > 6;
DROP TABLE t1;

--
-- Bug#20577: Partitions: use of to_days() function leads to selection failures
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a DATE, KEY(a))
PARTITION BY RANGE (TO_DAYS(a))
(PARTITION `pNULL` VALUES LESS THAN (0),
 PARTITION `p0001-01-01` VALUES LESS THAN (366 + 1),
 PARTITION `p1001-01-01` VALUES LESS THAN (TO_DAYS('1001-01-01') + 1),
 PARTITION `p2001-01-01` VALUES LESS THAN (TO_DAYS('2001-01-01') + 1));
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES ('0000-00-00'), ('0000-01-02'), ('0001-01-01'),
      ('1001-00-00'), ('1001-01-01'), ('1002-00-00'), ('2001-01-01');
ALTER TABLE t1 DROP KEY a;
DROP TABLE t1;
CREATE TABLE t1 (a DATE, KEY(a))
PARTITION BY LIST (TO_DAYS(a))
(PARTITION `p0001-01-01` VALUES IN (TO_DAYS('0001-01-01')),
 PARTITION `p2001-01-01` VALUES IN (TO_DAYS('2001-01-01')),
 PARTITION `pNULL` VALUES IN (NULL),
 PARTITION `p0000-01-02` VALUES IN (TO_DAYS('0000-01-02')),
 PARTITION `p1001-01-01` VALUES IN (TO_DAYS('1001-01-01')));
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES ('0000-00-00'), ('0000-01-02'), ('0001-01-01'),
      ('1001-00-00'), ('1001-01-01'), ('1002-00-00'), ('2001-01-01');
ALTER TABLE t1 DROP KEY a;
DROP TABLE t1;
CREATE TABLE t1 (a DATE, KEY(a))
PARTITION BY LIST (TO_SECONDS(a))
(PARTITION `p0001-01-01` VALUES IN (TO_SECONDS('0001-01-01')),
 PARTITION `p2001-01-01` VALUES IN (TO_SECONDS('2001-01-01')),
 PARTITION `pNULL` VALUES IN (NULL),
 PARTITION `p0000-01-02` VALUES IN (TO_SECONDS('0000-01-02')),
 PARTITION `p1001-01-01` VALUES IN (TO_SECONDS('1001-01-01')));
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES ('0000-00-00'), ('0000-01-02'), ('0001-01-01'),
      ('1001-00-00'), ('1001-01-01'), ('1002-00-00'), ('2001-01-01');
ALTER TABLE t1 DROP KEY a;
DROP TABLE t1;
SET sql_mode = default;

--
-- Bug#46362: Endpoint should be set to false for TO_DAYS(DATE)
-- There is a problem when comparing DATE with DATETIME.
-- In pruning it is converted into the field type
-- and in row evaluation it is converted to longlong
-- (like a DATETIME).
--echo -- Test with DATETIME column NOT NULL
CREATE TABLE t1 (
 a int(10) unsigned NOT NULL,
 b DATETIME NOT NULL,
 PRIMARY KEY (a, b)
) PARTITION BY RANGE (TO_DAYS(b))
(PARTITION p20090401 VALUES LESS THAN (TO_DAYS('2009-04-02')),
 PARTITION p20090402 VALUES LESS THAN (TO_DAYS('2009-04-03')),
 PARTITION p20090403 VALUES LESS THAN (TO_DAYS('2009-04-04')),
 PARTITION p20090404 VALUES LESS THAN (TO_DAYS('2009-04-05')),
 PARTITION p20090405 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES (1, '2009-01-01'), (1, '2009-04-01'), (2, '2009-04-01'),
  (1, '2009-04-02'), (2, '2009-04-02'), (1, '2009-04-02 23:59:59'),
  (1, '2009-04-03'), (2, '2009-04-03'), (1, '2009-04-04'), (2, '2009-04-04'),
  (1, '2009-04-05'), (1, '2009-04-06'), (1, '2009-04-07');
DROP TABLE t1;
CREATE TABLE t1 (
 a int(10) unsigned NOT NULL,
 b DATE NOT NULL,
 PRIMARY KEY (a, b)
) PARTITION BY RANGE (TO_DAYS(b))
(PARTITION p20090401 VALUES LESS THAN (TO_DAYS('2009-04-02')),
 PARTITION p20090402 VALUES LESS THAN (TO_DAYS('2009-04-03')),
 PARTITION p20090403 VALUES LESS THAN (TO_DAYS('2009-04-04')),
 PARTITION p20090404 VALUES LESS THAN (TO_DAYS('2009-04-05')),
 PARTITION p20090405 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES (1, '2009-01-01'), (1, '2009-04-01'), (2, '2009-04-01'),
  (1, '2009-04-02'), (2, '2009-04-02'), (1, '2009-04-03'), (2, '2009-04-03'),
  (1, '2009-04-04'), (2, '2009-04-04'), (1, '2009-04-05'), (1, '2009-04-06'),
  (1, '2009-04-07');
DROP TABLE t1;
CREATE TABLE t1 (
 a int(10) unsigned NOT NULL,
 b DATETIME NULL
) PARTITION BY RANGE (TO_DAYS(b))
(PARTITION p20090401 VALUES LESS THAN (TO_DAYS('2009-04-02')),
 PARTITION p20090402 VALUES LESS THAN (TO_DAYS('2009-04-03')),
 PARTITION p20090403 VALUES LESS THAN (TO_DAYS('2009-04-04')),
 PARTITION p20090404 VALUES LESS THAN (TO_DAYS('2009-04-05')),
 PARTITION p20090405 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES (1, '2009-01-01'), (1, '2009-04-01'), (2, '2009-04-01'),
  (1, '2009-04-02'), (2, '2009-04-02'), (1, '2009-04-02 23:59:59'),
  (1, '2009-04-03'), (2, '2009-04-03'), (1, '2009-04-04'), (2, '2009-04-04'),
  (1, '2009-04-05'), (1, '2009-04-06'), (1, '2009-04-07');
DROP TABLE t1;
CREATE TABLE t1 (
 a int(10) unsigned NOT NULL,
 b DATE NULL
) PARTITION BY RANGE (TO_DAYS(b))
(PARTITION p20090401 VALUES LESS THAN (TO_DAYS('2009-04-02')),
 PARTITION p20090402 VALUES LESS THAN (TO_DAYS('2009-04-03')),
 PARTITION p20090403 VALUES LESS THAN (TO_DAYS('2009-04-04')),
 PARTITION p20090404 VALUES LESS THAN (TO_DAYS('2009-04-05')),
 PARTITION p20090405 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES (1, '2009-01-01'), (1, '2009-04-01'), (2, '2009-04-01'),
  (1, '2009-04-02'), (2, '2009-04-02'), (1, '2009-04-03'), (2, '2009-04-03'),
  (1, '2009-04-04'), (2, '2009-04-04'), (1, '2009-04-05'), (1, '2009-04-06'),
  (1, '2009-04-07');
DROP TABLE t1;
CREATE TABLE t1 (
 a int(10) unsigned NOT NULL,
 b DATE
) PARTITION BY RANGE ( TO_DAYS(b) )
(PARTITION p20090401 VALUES LESS THAN (TO_DAYS('2009-04-02')),
 PARTITION p20090402 VALUES LESS THAN (TO_DAYS('2009-04-03')),
 PARTITION p20090403 VALUES LESS THAN (TO_DAYS('2009-04-04')),
 PARTITION p20090404 VALUES LESS THAN (TO_DAYS('2009-04-05')),
 PARTITION p20090405 VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES (1, '2009-01-01'), (2, NULL);
DROP TABLE t1;

--
-- Bug#40972: some sql execution lead the whole database crashing
--
-- Setup so the start is at partition pX and end is at p1
-- Pruning does handle 'bad' dates differently.
SET @previous_sql_mode = @@sql_mode;
SET sql_mode = 'ALLOW_INVALID_DATES';
CREATE TABLE t1
(a INT NOT NULL AUTO_INCREMENT,
 b DATETIME,
 PRIMARY KEY (a,b),
 KEY (b))
PARTITION BY RANGE (to_days(b))
(PARTITION p0 VALUES LESS THAN (733681) COMMENT = 'LESS THAN 2008-10-01',
 PARTITION p1 VALUES LESS THAN (733712) COMMENT = 'LESS THAN 2008-11-01',
 PARTITION pX VALUES LESS THAN MAXVALUE);
ALTER TABLE t1 REMOVE PARTITIONING;
SELECT a,b FROM t1 WHERE b >= '2008-12-01' AND b < '2009-12-00';
DROP TABLE t1;
SET sql_mode = @previous_sql_mode;

-- Check if we can infer from condition on partition fields that
-- no records will match.
create table t1 ( a int not null) partition by hash(a) partitions 2;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(2),(3);
drop table t1;

-- Simple HASH partitioning
create table t1 (
  a int(11) not null
) partition by hash (a) partitions 2;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(2),(3);

-- Partitioning over several fields
create table t2 (
  a int not null,
  b int not null
) partition by key(a,b) partitions 2;
ALTER TABLE t2 REMOVE PARTITIONING;
insert into t2 values (1,1),(2,2),(3,3);

-- RANGE(expr) partitioning
create table t3 (
  a int
)
partition by range (a*1) (
  partition p0 values less than (10),
  partition p1 values less than (20)
);
ALTER TABLE t3 REMOVE PARTITIONING;
insert into t3 values (5),(15);

-- LIST(expr) partitioning
create table t4 (a int not null, b int not null) partition by LIST (a+b) (
  partition p0 values in (12),
  partition p1 values in (14)
);
ALTER TABLE t4 REMOVE PARTITIONING;
insert into t4 values (10,2), (10,4);

-- empty OR one
--replace_column 10 --
explain select * from t4 where (a=10 and b=1) or (a=10 and b=2);

-- empty OR one OR empty
--replace_column 10 --
explain select * from t4
  where (a=10 and b=1) or (a=10 and b=2) or (a=10 and b = 3);

-- one OR empty OR one
--replace_column 10 --
explain select * from t4 where (a=10 and b=2) or (a=10 and b=3)
  or (a=10 and b = 4);

-- empty OR full
--replace_column 10 --
explain select * from t4 where (a=10 and b=1) or a=11;

-- one OR full
--replace_column 10 --
explain select * from t4 where (a=10 and b=2) or a=11;

drop table t1, t2, t3, t4;

-- LIST(expr)/HASH subpartitioning.
create table t5 (a int not null, b int not null,
                 c int not null, d int not null)
partition by LIST(a+b) subpartition by HASH (c+d) subpartitions 2
(
  partition p0 values in (12),
  partition p1 values in (14)
);
ALTER TABLE t5 REMOVE PARTITIONING;

insert into t5 values (10,2,0,0), (10,4,0,0), (10,2,0,1), (10,4,0,1);

-- empty OR one OR empty
--replace_column 10 --
explain select * from t5
  where (a=10 and b=1) or (a=10 and b=2) or (a=10 and b = 3);

-- one OR empty OR one
--replace_column 10 --
explain select * from t5 where (a=10 and b=2) or (a=10 and b=3)
  or (a=10 and b = 4);

-- conditions on subpartitions only
--replace_column 10 --
explain select * from t5 where (c=1 and d=1);

-- mixed partition/subpartitions.
--replace_column 10 --
explain select * from t5 where (a=10 and b=2 and c=1 and d=1) or
(c=2 and d=1);

-- same as above
--replace_column 10 --
explain select * from t5 where (a=10 and b=2 and c=1 and d=1) or
(b=2 and c=2 and d=1);

-- LIST(field) partitioning, interval analysis.
create table t6 (a int not null) partition by LIST(a) (
  partition p1 values in (1),
  partition p3 values in (3),
  partition p5 values in (5),
  partition p7 values in (7),
  partition p9 values in (9)
);
ALTER TABLE t6 REMOVE PARTITIONING;
insert into t6 values (1),(3),(5);

drop table t6;

create table t6 (a int unsigned not null) partition by LIST(a) (
  partition p1 values in (1),
  partition p3 values in (3),
  partition p5 values in (5),
  partition p7 values in (7),
  partition p9 values in (9)
);
ALTER TABLE t6 REMOVE PARTITIONING;
insert into t6 values (1),(3),(5);

-- RANGE(field) partitioning, interval analysis.
create table t7 (a int not null) partition by RANGE(a) (
  partition p10 values less than (10),
  partition p30 values less than (30),
  partition p50 values less than (50),
  partition p70 values less than (70),
  partition p90 values less than (90)
);
ALTER TABLE t7 REMOVE PARTITIONING;
insert into t7 values (10),(30),(50);

-- leftmost intervals
--replace_column 10 --
explain select * from t7 where a < 5;

-- misc intervals
--replace_column 10 --
explain select * from t7 where a > 11 and a < 29;

drop table t7;

create table t7 (a int unsigned not null) partition by RANGE(a) (
  partition p10 values less than (10),
  partition p30 values less than (30),
  partition p50 values less than (50),
  partition p70 values less than (70),
  partition p90 values less than (90)
);
ALTER TABLE t7 REMOVE PARTITIONING;
insert into t7 values (10),(30),(50);

-- leftmost intervals
--replace_column 10 --
explain select * from t7 where a < 5;

-- misc intervals
--replace_column 10 --
explain select * from t7 where a > 11 and a < 29;

-- LIST(monontonic_func) partitioning
create table t8 (a date not null) partition by RANGE(YEAR(a)) (
  partition p0 values less than (1980),
  partition p1 values less than (1990),
  partition p2 values less than (2000)
);
ALTER TABLE t8 REMOVE PARTITIONING;
insert into t8 values ('1985-05-05'),('1995-05-05');

-- LIST(strict_monotonic_func) partitioning
create table t9 (a date not null) partition by RANGE(TO_DAYS(a)) (
  partition p0 values less than (732299), -- 2004-12-19
  partition p1 values less than (732468), -- 2005-06-06
  partition p2 values less than (732664)  -- 2005-12-19
);
ALTER TABLE t9 REMOVE PARTITIONING;
insert into t9 values ('2005-05-05'), ('2005-04-04');

drop table t5,t6,t7,t8,t9;

-- Test the case where we can't create partitioning 'index'
--
-- Not supported after bug#18198 is fixed
--
--create table t1 (a enum('a','b','c','d') default 'a')
--  partition by hash (ascii(a)) partitions 2;

--
-- Test cases for bugs found in code review:
--
create table t1 (
  a1 int not null
)
partition by range (a1) (
  partition p0 values less than (3),
  partition p1 values less than (6),
  partition p2 values less than (9)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(2),(3);
drop table t1;

--
create table t3 (a int, b int)
  partition by list(a) subpartition by hash(b) subpartitions 4 (
    partition p0 values in (1),
    partition p1 values in (2),
    partition p2 values in (3),
    partition p3 values in (4)
  );
ALTER TABLE t3 REMOVE PARTITIONING;
insert into t3 values (1,1),(2,2),(3,3);
drop table t3;

-- Test for NULLs
create table t1 (a int) partition by hash(a) partitions 2;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(2);

-- this uses both partitions
--replace_column 10 --
explain select * from t1 where a is not null;
drop table t1;

-- Join tests
create table t1 (a int not null, b int not null, key(a), key(b))
  partition by hash(a) partitions 4;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1,1),(2,2),(3,3),(4,4);
select * from t1 x, t1 y
where x.b = y.b and (x.a=1 or x.a=2) and (y.a=2 or y.a=3);
select * from t1 x, t1 y where x.a = y.a and (x.a=1 or x.a=2);

drop table t1;

-- Tests for "short ranges"
create table t1 (a int) partition by hash(a) partitions 20;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(2),(3);
drop table t1;

create table t1 (a int, b int)
 partition by list(a) subpartition by hash(b) subpartitions 20
(
  partition p0 values in (0),
  partition p1 values in (1),
  partition p2 values in (2),
  partition p3 values in (3)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1,1),(2,2),(3,3);
drop table t1;

-- Test partition pruning for single-table UPDATE/DELETE.
-- TODO: Currently we test only "all partitions pruned away" case. Add more
-- tests when the patch that makes use of partition pruning results at
-- execution phase is pushed.

create table t1 (a int) partition by list(a) (
  partition p0 values in (1,2),
  partition p1 values in (3,4)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1),(1),(2),(2),(3),(4),(3),(4);
select * from t1;
select * from t1;
insert into t1 values (1), (1);
create table t2 like t1;
insert into t2 select * from t1;
select * from t1;
drop table t1,t2;

--
-- WL#2986 Tests (Checking if partition pruning results are used at query
--   execution phase)
--
CREATE TABLE `t1` (
  `a` int(11) default NULL
);
INSERT INTO t1 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE `t2` (
  `a` int(11) default NULL,
  KEY `a` (`a`)
) ;

insert into t2 select A.a + 10*(B.a + 10* C.a) from t1 A, t1 B, t1 C ;
insert into t1 select a from t2;

drop table t2;
CREATE TABLE `t2` (
  `a` int(11) default NULL,
  `b` int(11) default NULL
)
PARTITION BY RANGE (a) (
PARTITION p0 VALUES LESS THAN (200),
PARTITION p1 VALUES LESS THAN (400),
PARTITION p2 VALUES LESS THAN (600),
PARTITION p3 VALUES LESS THAN (800),
PARTITION p4 VALUES LESS THAN (1001));
ALTER TABLE t1 REMOVE PARTITIONING;

CREATE TABLE `t3` (
  `a` int(11) default NULL,
  `b` int(11) default NULL
);
insert into t2 select a,1 from t1 where a < 200;
insert into t2 select a,2 from t1 where a >= 200 and a < 400;
insert into t2 select a,3 from t1 where a >= 400 and a < 600;
insert into t2 select a,4 from t1 where a >= 600 and a < 800;
insert into t2 select a,5 from t1 where a >= 800 and a < 1001;

DROP TABLE t3;

drop table t2;
CREATE TABLE `t2` (
  `a` int(11) default NULL,
  `b` int(11) default NULL,
  index (b)
)
PARTITION BY RANGE (a) (
PARTITION p0 VALUES LESS THAN (200),
PARTITION p1 VALUES LESS THAN (400),
PARTITION p2 VALUES LESS THAN (600),
PARTITION p3 VALUES LESS THAN (800),
PARTITION p4 VALUES LESS THAN (1001));
ALTER TABLE t1 REMOVE PARTITIONING;

insert into t2 select a,1 from t1 where a < 100;
insert into t2 select a,2 from t1 where a >= 200 and a < 300;
insert into t2 select a,3 from t1 where a >= 300 and a < 400;
insert into t2 select a,4 from t1 where a >= 400 and a < 500;
insert into t2 select a,5 from t1 where a >= 500 and a < 600;
insert into t2 select a,6 from t1 where a >= 600 and a < 700;
insert into t2 select a,7 from t1 where a >= 700 and a < 800;
insert into t2 select a,8 from t1 where a >= 800 and a < 900;
insert into t2 select a,9 from t1 where a >= 900 and a < 1001;

let $use_optimizer_trace=0;
SET @@optimizer_trace="enabled=on";
SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET @@optimizer_trace="enabled=off";
SET @@optimizer_trace="enabled=on";
SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET @@optimizer_trace="enabled=off";

drop table t1, t2;

-- BUG#18025
--  part1: mediumint columns
create table t1 ( f_int1 mediumint, f_int2 integer)
partition by list(mod(f_int1,4)) (
  partition p_3 values in (-3),
  partition p_2 values in (-2),
  partition p_1 values in (-1),
  partition p0 values in (0),
  partition p1 values in (1),
  partition p2 values in (2),
  partition p3 values in (3)
);
ALTER TABLE t1 REMOVE PARTITIONING;

insert into t1 values (9, 9), (8, 8), (7, 7), (6, 6), (5, 5),
                      (4, 4), (3, 3), (2, 2), (1, 1);
select * from t1 where f_int1 between 5 and 15 order by f_int1;

drop table t1;

--  part2: bug in pruning code
--create table t1 (a char(10) binary)
--partition by list(ascii(a))
-- (partition p1 values in (ascii('a')),
--  partition p2 values in (ascii('b')),
--  partition p3 values in (ascii('c')),
--  partition p4 values in (ascii('d')),
--  partition p5 values in (ascii('e')));

-- BUG#18659: Assertion failure when subpartitioning is used and partition is
-- "IS NULL"
create table t1 (f_int1 integer) partition by list(abs(mod(f_int1,2)))
  subpartition by hash(f_int1) subpartitions 2
(
  partition part1 values in (0),
  partition part2 values in (1),
  partition part4 values in (null)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 set f_int1 = null;

select * from t1 where f_int1 is null;
drop table t1;

--
-- BUG#18558
--
create table t1 (a int not null, b int not null)
partition by list(a)
  subpartition by hash(b) subpartitions 4
(
  partition p0 values in (1),
  partition p1 values in (2),
  partition p2 values in (3)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1,1),(1,2),(1,3),(1,4),
  (2,1),(2,2),(2,3),(2,4);
drop table t1;

create table t1 (a int, b int not null)
partition by list(a)
  subpartition by hash(b) subpartitions 2
(
  partition p0 values in (1),
  partition p1 values in (2),
  partition p2 values in (3),
  partition pn values in (NULL)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (1,1),(1,2),(1,3),(1,4),
  (2,1),(2,2),(2,3),(2,4), (NULL,1);

drop table t1;

create table t1 ( a int)  partition by list (MOD(a, 10))
( partition p0  values in (0), partition p1 values in (1),
   partition p2 values in (2), partition p3 values in (3),
   partition p4 values in (4), partition p5 values in (5),
   partition p6 values in (6), partition pn values in (NULL)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (NULL), (0),(1),(2),(3),(4),(5),(6);
drop table t1;

-- Testcase from BUG#18751
create table t1 (s1 int) partition by list (s1)
  (partition p1 values in (0),
   partition p2 values in (1),
   partition p3 values in (null));
ALTER TABLE t1 REMOVE PARTITIONING;

insert into t1 values (0),(1),(null);

select count(*) from t1 where s1 < 0 or s1 is null;
drop table t1;

-- No tests for NULLs in RANGE(monotonic_expr()) - they depend on BUG#15447
-- being fixed.

--
-- BUG#17946 Like searches fail with partitioning
--
create table t1 (a char(32) primary key)
partition by key()
partitions 100;
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values ('na');
select * from t1;
select * from t1 where a like 'n%';
drop table t1;


-- BUG#19055 Crashes for varchar_col=NUMBER or varchar_col IS NULL
create table t1 (s1 varchar(15)) partition by key (s1);
ALTER TABLE t1 REMOVE PARTITIONING;
select * from t1 where s1 = 0 or s1 is null;
insert into t1 values ('aa'),('bb'),('0');
drop table t1;

--
-- BUG#19684: EXPLAIN produces garbage in 'partitions' column when
-- the length of string to be displayed exceeds some limit.
create table t2 (a int, b int)
  partition by LIST(a)
  subpartition by HASH(b) subpartitions 40
( partition p_0_long_partition_name values in(1),
  partition p_1_long_partition_name values in(2));
ALTER TABLE t2 REMOVE PARTITIONING;

insert into t2 values (1,1),(2,2);
drop table t2;


-- BUG#20484 "Partitions: crash with explain and union"
create table t1 (s1 int);
drop table t1;


-- BUG#20257: partition pruning test coverage for BIGINT UNSIGNED
create table t1 (a bigint unsigned not null) partition by range(a) (
  partition p0 values less than (10),
  partition p1 values less than (100),
  partition p2 values less than (1000),
  partition p3 values less than (18446744073709551000),
  partition p4 values less than (18446744073709551614)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (5),(15),(105),(1005);
insert into t1 values (18446744073709551000+1);
insert into t1 values (18446744073709551614-1);
drop table t1;
--
  create table t1 (a int)
  partition by range(a) (
  partition p0 values less than (64),
  partition p1 values less than (128),
  partition p2 values less than (255)
);
ALTER TABLE t1 REMOVE PARTITIONING;

create table t2 (a int)
  partition by range(a+0) (
  partition p0 values less than (64),
  partition p1 values less than (128),
  partition p2 values less than (255)
);
ALTER TABLE t2 REMOVE PARTITIONING;

insert into t1 values (0x20), (0x20), (0x41), (0x41), (0xFE), (0xFE);
insert into t2 values (0x20), (0x20), (0x41), (0x41), (0xFE), (0xFE);
drop table t1;
drop table t2;

create table t1(a bigint unsigned not null) partition by range(a+0) (
  partition p1 values less than (10),
  partition p2 values less than (20),
  partition p3 values less than (2305561538531885056),
  partition p4 values less than (2305561538531950591)
);
ALTER TABLE t1 REMOVE PARTITIONING;

insert into t1 values (9),(19),(0xFFFF0000FFFF000-1), (0xFFFF0000FFFFFFF-1);
insert into t1 values (9),(19),(0xFFFF0000FFFF000-1), (0xFFFF0000FFFFFFF-1);
  a >= 2305561538531885056-10 and a <= 2305561538531885056-8;
  a > 0xFFFFFFFFFFFFFFEC and a < 0xFFFFFFFFFFFFFFEE;
drop table t1;

create table t1 (a bigint) partition by range(a+0) (
  partition p1 values less than (-1000),
  partition p2 values less than (-10),
  partition p3 values less than (10),
  partition p4 values less than (1000)
);
ALTER TABLE t1 REMOVE PARTITIONING;
insert into t1 values (-15),(-5),(5),(15),(-15),(-5),(5),(15);
drop table t1;


--
-- BUG#27927 Partition pruning not optimal with TO_DAYS function
--

CREATE TABLE t1 ( recdate  DATETIME NOT NULL )
PARTITION BY RANGE( TO_DAYS(recdate) ) (
  PARTITION p0 VALUES LESS THAN ( TO_DAYS('2007-03-08') ),
  PARTITION p1 VALUES LESS THAN ( TO_DAYS('2007-04-01') )
);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES ('2007-03-01 12:00:00');
INSERT INTO t1 VALUES ('2007-03-07 12:00:00');
INSERT INTO t1 VALUES ('2007-03-08 12:00:00');
INSERT INTO t1 VALUES ('2007-03-15 12:00:00');

drop table t1;
CREATE TABLE t1 ( recdate  DATETIME NOT NULL )
PARTITION BY RANGE( YEAR(recdate) ) (
  PARTITION p0 VALUES LESS THAN (2006),
  PARTITION p1 VALUES LESS THAN (2007)
);
ALTER TABLE t1 REMOVE PARTITIONING;
INSERT INTO t1 VALUES ('2005-03-01 12:00:00');
INSERT INTO t1 VALUES ('2005-03-01 12:00:00');
INSERT INTO t1 VALUES ('2006-03-01 12:00:00');
INSERT INTO t1 VALUES ('2006-03-01 12:00:00');

-- echo must use p0 only:
--replace_column 10 --
explain select * from t1 where recdate < '2006-01-01 00:00:00';
drop table t1;

-- echo --
-- echo -- BUG#33730 Full table scan instead selected partitions for query more than 10 partitions
-- echo --
create table t0 (a int);
insert into t0 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t1 (a int)
  partition by range(a+0) (
  partition p0 values less than (64),
  partition p1 values less than (128),
  partition p2 values less than (255)
);
ALTER TABLE t0 REMOVE PARTITIONING;
insert into t1 select A.a + 10*B.a from t0 A, t0 B;

-- this will use interval_via_walking
--replace_column 10 --
explain select * from t1 where a between 10 and 13;

drop table t0, t1;
CREATE TABLE t1
(c1 int,
 c2 int,
 c3 int,
 c4 int,
 PRIMARY KEY (c1,c2))
PARTITION BY LIST COLUMNS (c2)
(PARTITION p1 VALUES IN (1,2),
 PARTITION p2 VALUES IN (3,4));
INSERT INTO t1 VALUES (1, 1, 1, 1), (2, 3, 1, 1);
INSERT INTO t1 VALUES (1, 2, 1, 1), (2, 4, 1, 1);
SELECT * FROM t1 WHERE c1 = 1 AND c2 < 1;
SELECT * FROM t1 WHERE c1 = 1 AND c2 <= 1;
SELECT * FROM t1 WHERE c1 = 1 AND c2 = 1;
SELECT * FROM t1 WHERE c1 = 1 AND c2 >= 1;
SELECT * FROM t1 WHERE c1 = 1 AND c2 > 1;
SELECT * FROM t1 WHERE c1 = 1 AND c2 < 3;
SELECT * FROM t1 WHERE c1 = 1 AND c2 <= 3;
SELECT * FROM t1 WHERE c1 = 2 AND c2 <= 3;
SELECT * FROM t1 WHERE c1 = 2 AND c2 = 3;
SELECT * FROM t1 WHERE c1 = 2 AND c2 >= 3;
SELECT * FROM t1 WHERE c1 = 2 AND c2 > 3;
SELECT * FROM t1 WHERE c1 = 2 AND c2 < 4;
SELECT * FROM t1 WHERE c1 = 2 AND c2 <= 4;
SELECT * FROM t1 WHERE c1 = 2 AND c2 = 4;
SELECT * FROM t1 WHERE c1 = 2 AND c2 >= 4;
SELECT * FROM t1 WHERE c1 = 2 AND c2 > 4;
DROP TABLE t1;
CREATE TABLE tp (
  id int unsigned NOT NULL,
  ts timestamp NOT NULL,
  PRIMARY KEY (id, ts)
)
PARTITION BY RANGE (unix_timestamp(ts))
(
 PARTITION p1 VALUES LESS THAN (1580515200),
 PARTITION p2 VALUES LESS THAN (1583020800)
);

SET time_zone = '+00:00';
INSERT INTO tp VALUES (1, '2020-01-01');
INSERT INTO tp VALUES (1, '2020-02-01');

SELECT COUNT(*) FROM tp PARTITION(p1);
SELECT COUNT(*) FROM tp PARTITION(p2);

SELECT * FROM tp WHERE ts >= '2020-01-01 00:00:00+00:00' AND ts <='2020-02-01 00:00:00+00:00';

SET time_zone = '+01:00';
SELECT * FROM tp WHERE ts >= '2020-01-01 00:00:00+00:00' AND ts <='2020-02-01 00:00:00+00:00';
ALTER TABLE tp REMOVE PARTITIONING;
SELECT * FROM tp WHERE ts >= '2020-01-01 00:00:00+00:00' AND ts <='2020-02-01 00:00:00+00:00';

SET time_zone = DEFAULT;
DROP TABLE tp;

CREATE TABLE t1 ( pk INT PRIMARY KEY AUTO_INCREMENT, c INT)
PARTITION BY RANGE (pk) (
    PARTITION p0 VALUES LESS THAN (1),
    PARTITION p1 VALUES LESS THAN (2),
    PARTITION p2 VALUES LESS THAN (3),
    PARTITION p3 VALUES LESS THAN (4),
    PARTITION p4 VALUES LESS THAN (100)
);
CREATE TABLE t2 ( pk INT PRIMARY KEY AUTO_INCREMENT, c INT);
CREATE TABLE t3 ( pk INT PRIMARY KEY AUTO_INCREMENT, c INT)
PARTITION BY RANGE (pk) (
    PARTITION p0 VALUES LESS THAN (1),
    PARTITION p1 VALUES LESS THAN (2),
    PARTITION p2 VALUES LESS THAN (3),
    PARTITION p3 VALUES LESS THAN (4),
    PARTITION p4 VALUES LESS THAN (100)
);
CREATE TABLE t4 ( pk INT PRIMARY KEY AUTO_INCREMENT, c INT);
CREATE TABLE t5 ( pk INT PRIMARY KEY AUTO_INCREMENT, c INT);

if ($verify_without_partitions)
{
ALTER TABLE t1 REMOVE PARTITIONING;
ALTER TABLE t3 REMOVE PARTITIONING;
INSERT INTO t1(c) VALUES (1),  (2),  (3),  (4),  (5),  (6),  (7),  (8),  (9),  (10);
INSERT INTO t1(c) VALUES (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);
INSERT INTO t2(c) VALUES (21), (22), (23), (24), (25), (26), (27), (28), (29), (30);
INSERT INTO t3(c) VALUES (31), (32), (33), (34), (35), (36), (37), (38), (39), (40);
INSERT INTO t4(c) VALUES (41), (42), (43), (44), (45), (46), (47), (48), (49), (50);
INSERT INTO t5(c) VALUES (51), (52), (53), (54), (55), (56), (57), (58), (59), (60);
EOF

--let $left = t1
--let $right = t2
--let $cond = on t1.pk = t2.pk AND t1.pk > 2
--source $SELECT_WITH_JOIN

--let $right = (t2 LEFT JOIN t3 on t2.pk = t3.pk)
--source $SELECT_WITH_JOIN

--let $right = ((t2 LEFT JOIN t3 on t2.pk = t3.pk) LEFT JOIN t4 on t2.c = t4.c + 15)
--source $SELECT_WITH_JOIN

--let $right = (t4 LEFT JOIN (t2 LEFT JOIN t3 on t2.pk = t3.pk) on t2.c = t4.c + 20)
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk)
--let $right = (t3 LEFT JOIN t4 on t3.pk = t4.pk)
--let $cond = on t1.pk = t3.pk AND t1.pk < 3
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk and t1.pk < 2)
--let $right = ((t5 LEFT JOIN t3 on t5.pk = t3.pk) LEFT JOIN t4 on t5.c = t4.c + 15)
--let $cond = on t1.pk = t3.pk AND t1.pk < 3
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk and t1.pk > 3)
--let $right = (t4 LEFT JOIN (t5 LEFT JOIN t3 on t5.pk = t3.pk) on t5.c = t4.c + 20)
--let $cond = on t1.pk = t3.pk AND t1.pk > 3
--source $SELECT_WITH_JOIN

--let $left = t1
--let $right = t2
--let $cond = on t1.pk = t2.pk WHERE t1.pk IN (SELECT pk FROM t3 WHERE pk > 2)
--source $SELECT_WITH_JOIN

--let $right = (t2 LEFT JOIN t3 on t2.pk = t3.pk)
--source $SELECT_WITH_JOIN

--let $left = t2
--let $right = (SELECT * FROM t1 WHERE t1.pk IN (SELECT pk FROM t3 WHERE pk > 2)) t13
--let $cond = on t13.pk = t2.pk AND t13.pk > 3
--source $SELECT_WITH_JOIN

--let $left = t1
--let $right = t2
--let $cond = on t1.pk = t2.pk WHERE t1.pk NOT IN (SELECT pk FROM t1 as tx WHERE pk > 2)
--source $SELECT_WITH_JOIN

--let $right = (t2 LEFT JOIN t3 on t2.pk = t3.pk)
--source $SELECT_WITH_JOIN

--let $left = t2
--let $right = (SELECT * FROM t1 WHERE t1.pk NOT IN (SELECT pk FROM t3 WHERE pk > 2)) t13
--let $cond = on t13.pk = t2.pk AND t13.pk > 3
--source $SELECT_WITH_JOIN

--let $left = t1
--let $right = t2
--let $cond = on t1.pk = t2.pk WHERE t1.pk IN (SELECT c FROM t3 WHERE pk > 2)
--source $SELECT_WITH_JOIN

--let $left = t2
--let $right = (SELECT * FROM t1 WHERE t1.pk IN (SELECT c FROM t3 WHERE pk > 2)) t13
--let $cond = on t13.pk = t2.pk AND t13.pk > 3
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk)
--let $right = (t3 LEFT JOIN (SELECT * FROM t1 as tx WHERE tx.pk IN (SELECT c FROM t3 WHERE pk > 2)) t13 on t3.pk = t13.pk)
--let $cond = on t1.pk = t3.pk AND t1.pk < 3
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk and t1.pk < 2)
--let $right = ((t5 LEFT JOIN (SELECT * FROM t1 as tx WHERE tx.pk IN (SELECT c FROM t3 WHERE pk > 2)) t13 on t5.pk = t13.pk) LEFT JOIN t4 on t5.c = t4.c + 15)
--let $cond = on t1.pk = t13.pk AND t1.pk < 3
--source $SELECT_WITH_JOIN

--let $left = (t1 LEFT JOIN t2 on t1.pk = t2.pk and t1.pk > 3)
--let $right = (t4 LEFT JOIN (t5 LEFT JOIN (SELECT * FROM t1 as tx WHERE tx.pk IN (SELECT c FROM t3 WHERE pk > 2)) t13 on t5.pk = t13.pk) on t5.c = t4.c + 20)
--let $cond = on t1.pk = t13.pk AND t1.pk > 3
--source $SELECT_WITH_JOIN

--remove_file $SELECT_WITH_JOIN
DROP TABLE t1, t2, t3, t4, t5;
CREATE TABLE t1 (c0 int);
CREATE TABLE t2 (c1 int, c2 int) PARTITION BY KEY (c1) PARTITIONS 4;

SELECT * from t2 WHERE c2 IN ((SELECT c0 FROM t1 LIMIT 1),null);
SELECT * from t2 WHERE c2 NOT IN ((SELECT c0 FROM t1 LIMIT 1),null);

DROP TABLE t1, t2;
