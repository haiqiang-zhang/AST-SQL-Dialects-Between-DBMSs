
-- Different number of warnings with/without ps-protocol
--source include/no_ps_protocol.inc

--disable_warnings
drop table if exists t1, t2;

let $MYSQLD_DATADIR= `SELECT @@datadir`;
CREATE TABLE t1 (a int);
CREATE OR REPLACE VIEW v1 AS SELECT * FROM t1;
ALTER TABLE t1 EXCHANGE PARTITION p0 WITH TABLE v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a,b))
PARTITION BY KEY(a, b, a);
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a,b))
PARTITION BY KEY(A, b);
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a,b))
PARTITION BY KEY(a, b, A);
CREATE TABLE t1 (a VARBINARY(10))
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
CREATE TABLE t1 (a CHAR(10))
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
CREATE TABLE t1 (a TIMESTAMP)
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
CREATE TABLE t1 (a DATE)
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
INSERT IGNORE INTO t1 VALUES ('test'),('a'),('5');
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
INSERT IGNORE INTO t1 VALUES ('test'),('a'),('5');
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY RANGE (DAYOFWEEK(a))
(PARTITION a1 VALUES LESS THAN (60));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TO_DAYS(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TO_DAYS(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TO_DAYS(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (TO_DAYS(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (TO_DAYS(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (DAYOFMONTH(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (DAYOFMONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (DAYOFMONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (DAYOFMONTH(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (DAYOFMONTH(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (MONTH(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (MONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (MONTH(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (MONTH(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (DAYOFYEAR(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (DAYOFYEAR(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (DAYOFYEAR(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (DAYOFYEAR(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (DAYOFYEAR(a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (HOUR(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (HOUR(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (HOUR(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (HOUR(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (HOUR(a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (MINUTE(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (MINUTE(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MINUTE(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (MINUTE(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (MINUTE(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (QUARTER(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (QUARTER(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (QUARTER(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (QUARTER(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (QUARTER(a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (SECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (SECOND(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (SECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (SECOND(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (SECOND(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (YEARWEEK(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (YEARWEEK(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (YEARWEEK(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (YEARWEEK(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (YEARWEEK(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (WEEKDAY(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (WEEKDAY(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (WEEKDAY(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (WEEKDAY(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (WEEKDAY(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TO_SECONDS(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TO_SECONDS(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TO_SECONDS(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (TO_SECONDS(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (TO_SECONDS(a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (FROM_DAYS(a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (FROM_DAYS(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (FROM_DAYS(a));
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (TO_DAYS(FROM_DAYS(a)));
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (FROM_DAYS(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (TO_DAYS(FROM_DAYS(a)));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (FROM_DAYS(a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (MICROSECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (MICROSECOND(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MICROSECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (MICROSECOND(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (MICROSECOND(a));
CREATE TABLE t1
(`date` date,
 `extracted_week` int,
 `yearweek` int,
 `week` int,
 `default_week_format` int)
PARTITION BY LIST (EXTRACT(WEEK FROM date) % 3)
(PARTITION p0 VALUES IN (0),
 PARTITION p1 VALUES IN (1),
 PARTITION p2 VALUES IN (2));
CREATE TABLE t1
(`date` date,
 `extracted_week` int,
 `yearweek` int,
 `week` int,
 `default_week_format` int);
SET @old_default_week_format := @@default_week_format;
SET default_week_format = 0;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 1;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 2;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 3;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 4;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 5;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 6;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SET default_week_format = 7;
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SELECT * FROM t1;
SET default_week_format = @old_default_week_format;
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(YEAR FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(MONTH FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(WEEK FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(WEEK FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(WEEK FROM a));
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(WEEK FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(WEEK FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(DAY FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(DAY FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(DAY FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(HOUR FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(HOUR FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(HOUR FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(SECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(SECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(SECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
CREATE TABLE t1 (a TIME, b DATE)
PARTITION BY HASH (DATEDIFF(a, b));
CREATE TABLE t1 (a DATE, b DATETIME)
PARTITION BY HASH (DATEDIFF(a, b));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME, b DATE)
PARTITION BY HASH (DATEDIFF(a, b));
DROP TABLE t1;
CREATE TABLE t1 (a DATE, b VARCHAR(10))
PARTITION BY HASH (DATEDIFF(a, b));
CREATE TABLE t1 (a INT, b DATETIME)
PARTITION BY HASH (DATEDIFF(a, b));

CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10))
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (a INT)
PARTITION BY HASH (TIME_TO_SEC(a));
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE (TO_DAYS(c))
(PARTITION p0 VALUES LESS THAN (10000),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
CREATE TABLE t2 (c TIMESTAMP);
ALTER TABLE t2
PARTITION BY RANGE (TO_DAYS(c))
(PARTITION p0 VALUES LESS THAN (10000),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE COLUMNS(c)
(PARTITION p0 VALUES LESS THAN ('2000-01-01 00:00:00'),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
ALTER TABLE t2 PARTITION BY RANGE COLUMNS(c)
(PARTITION p0 VALUES LESS THAN ('2000-01-01 00:00:00'),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
DROP TABLE t2;
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE (c)
(PARTITION p0 VALUES LESS THAN ('2000-01-01 00:00:00'),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE (UNIX_TIMESTAMP(c))
(PARTITION p0 VALUES LESS THAN ('2000-01-01 00:00:00'),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));

CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE (UNIX_TIMESTAMP(c))
(PARTITION p0 VALUES LESS THAN (UNIX_TIMESTAMP('2000-01-01 00:00:00')),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
DROP TABLE t1;
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY HASH (c) PARTITIONS 4;
CREATE TABLE t1 (a INT) PARTITION BY HASH(a);
CREATE TEMPORARY TABLE tmp_t1 LIKE t1;
DROP TABLE t1;
SET @org_mode=@@sql_mode;
SET @@sql_mode='NO_DIR_IN_CREATE';
SELECT @@sql_mode;
CREATE TABLE t1 (id INT, purchased DATE)
PARTITION BY RANGE(YEAR(purchased))
SUBPARTITION BY HASH(TO_DAYS(purchased))
(PARTITION p0 VALUES LESS THAN MAXVALUE
  DATA DIRECTORY = '/tmp/not-existing'
  INDEX DIRECTORY = '/tmp/not-existing');
DROP TABLE t1;
CREATE TABLE t1 (id INT, purchased DATE)
PARTITION BY RANGE(YEAR(purchased))
SUBPARTITION BY HASH(TO_DAYS(purchased)) SUBPARTITIONS 2
(PARTITION p0 VALUES LESS THAN MAXVALUE
 (SUBPARTITION sp0
   DATA DIRECTORY = '/tmp/not-existing'
   INDEX DIRECTORY = '/tmp/not-existing',
  SUBPARTITION sp1));
DROP TABLE t1;
CREATE TABLE t1 (id INT, purchased DATE)
PARTITION BY RANGE(YEAR(purchased))
(PARTITION p0 VALUES LESS THAN MAXVALUE
  DATA DIRECTORY = '/tmp/not-existing'
  INDEX DIRECTORY = '/tmp/not-existing');
DROP TABLE t1;
SET @@sql_mode= @org_mode;

--
-- Bug#38719: Partitioning returns a different error code for a
-- duplicate key error
CREATE TABLE t1 (a INTEGER NOT NULL, PRIMARY KEY (a));
INSERT INTO t1 VALUES (1),(1);
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER NOT NULL, PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 2;
INSERT INTO t1 VALUES (1),(1);
DROP TABLE t1;

--
-- Bug 29368:
-- Incorrect error, 1467, for syntax error when creating partition

CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';
CREATE TABLESPACE ts2 ADD DATAFILE 'ts2.ibd';
CREATE TABLESPACE ts3 ADD DATAFILE 'ts3.ibd';
CREATE TABLE t1 (
  a int
)
PARTITION BY RANGE (a)
(
  PARTITION p0 VALUES LESS THAN (1),
  PARTITION p1 VALU ES LESS THAN (2)
);

--
-- Partition by key stand-alone error
--
--error ER_PARSE_ERROR
partition by list (a)
partitions 3
(partition x1 values in (1,2,9,4) tablespace ts1,
 partition x2 values in (3, 11, 5, 7) tablespace ts2,
 partition x3 values in (16, 8, 5+19, 70-43) tablespace ts3);

--
-- Partition by key list, number of partitions defined, no partition defined
--
--error ER_PARTITIONS_MUST_BE_DEFINED_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2;

--
-- Partition by key list, wrong result type
--
--error ER_PARTITION_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (sin(a))
partitions 3
(partition x1 values in (1,2,9,4) tablespace ts1,
 partition x2 values in (3, 11, 5, 7) tablespace ts2,
 partition x3 values in (16, 8, 5+19, 70-43) tablespace ts3);

--
-- Partition by key, partition function not allowed
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a+2)
partitions 3
(partition x1 tablespace ts1,
 partition x2 tablespace ts2,
 partition x3 tablespace ts3);

--
-- Partition by key, no partition name
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition tablespace ts1,
 partition x2 tablespace ts2,
 partition x3 tablespace ts3);

--
-- Partition by range columns, invalid field in field list
--
--error ER_FIELD_NOT_FOUND_PART_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range columns (a,d)
(partition x1 VALUES LESS THAN (1,1),
 partition x2 VALUES LESS THAN (2,2),
 partition x3 VALUES LESS THAN (3,3));

let $MYSQLD_DATADIR= `select @@datadir`;
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Partition by key, invalid field in field list
--
--error ER_FIELD_NOT_FOUND_PART_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a,d)
partitions 3
(partition x1 tablespace ts1,
 partition x2 tablespace ts2,
 partition x3 tablespace ts3);

select load_file('$MYSQLD_DATADIR/test/t1.par');
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a + d)
partitions 3
(partition x1 tablespace ts1,
 partition x2 tablespace ts2,
 partition x3 tablespace ts3);

--
-- Partition by hash, invalid result type
--
--error ER_PARTITION_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (sin(a))
partitions 3
(partition x1 tablespace ts1,
 partition x2 tablespace ts2,
 partition x3 tablespace ts3);

--
-- Partition by key specified 3 partitions but only defined 2 => error
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by key (a)
partitions 3
(partition x1, partition x2);

--
-- Partition by hash, random function
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (rand(a))
partitions 2
(partition x1, partition x2);

--
-- Partition by range, random function
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (rand(a))
partitions 2
(partition x1 values less than (0), partition x2 values less than (2));

--
-- Partition by list, random function
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (rand(a))
partitions 2
(partition x1 values in (1), partition x2 values in (2));

--
-- Partition by hash, values less than error
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a)
partitions 2
(partition x1 values less than (4),
 partition x2 values less than (5));
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Partition by hash, values in error
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a)
partitions 2
(partition x1 values in (4),
 partition x2 values in (5));
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Partition by hash, values in error
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by hash (a)
partitions 2
(partition x1 values in (4,6),
 partition x2 values in (5,7));
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by key, no partitions defined, single field
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by key (b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by key, no partitions defined, list of fields
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by key (a, b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by hash, no partitions defined
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by hash (a+b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by key, no partitions defined, single field
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by key (b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by key, no partitions defined, list of fields
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by key (a, b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by hash, no partitions defined
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by hash (a+b);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by hash, no partitions defined, wrong subpartition function
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by hash (rand(a+b));

--
-- Subpartition by hash, wrong subpartition function
--
--error ER_PARTITION_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by hash (sin(a+b))
(partition x1 (subpartition x11, subpartition x12),
 partition x2 (subpartition x21, subpartition x22));
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by hash, no partitions defined, wrong subpartition function
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by key (a+b)
(partition x1 values less than (1) (subpartition x11, subpartition x12),
 partition x2 values less than (2) (subpartition x21, subpartition x22));

--
-- Subpartition by hash, no partitions defined, wrong subpartition function
--
--error ER_FIELD_NOT_FOUND_PART_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by key (a,d)
(partition x1 values less than (1) (subpartition x11, subpartition x12),
 partition x2 values less than (2) (subpartition x21, subpartition x22));
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Subpartition by hash, no partitions defined, wrong subpartition function
--
--error ER_SUBPARTITION_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by hash (3+4);

--
-- Subpartition by hash, no partitions defined, wrong subpartition function
--
--error ER_BAD_FIELD_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by range (a)
subpartition by hash (a+d)
(partition x1 values less than (1) (subpartition x11, subpartition x12),
 partition x2 values less than (2) (subpartition x21, subpartition x22));

--
-- Partition by range, no partition => error
--
--error ER_PARTITIONS_MUST_BE_DEFINED_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a);
select load_file('$MYSQLD_DATADIR/test/t1.par');

--
-- Partition by range, invalid field in function
--
--error ER_BAD_FIELD_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a+d)
partitions 2
(partition x1 values less than (4) tablespace ts1,
 partition x2 values less than (8) tablespace ts2);

--
-- Partition by range, inconsistent partition function and constants
--
--error ER_VALUES_IS_NOT_INT_TYPE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values less than (4.0) tablespace ts1,
 partition x2 values less than (8) tablespace ts2);

--
-- Partition by range, constant partition function not allowed
--
--error ER_WRONG_EXPR_IN_PARTITION_FUNC_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (3+4)
partitions 2
(partition x1 values less than (4) tablespace ts1,
 partition x2 values less than (8) tablespace ts2);

--
-- Partition by range, no values less than definition
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values less than (4),
 partition x2);

--
-- Partition by range, no values in definition allowed
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values in (4),
 partition x2);

--
-- Partition by range, values in error
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values in (4),
 partition x2 values less than (5));

--
-- Partition by list, missing parenthesis
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values less than 4,
 partition x2 values less than (5));

--
-- Partition by list, error: unexpected LESS THAN
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values less than (4),
 partition x2 values less than (5));

--
-- Partition by range, maxvalue in wrong place
--
--error ER_PARTITION_MAXVALUE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values less than maxvalue,
 partition x2 values less than (5));

--
-- Partition by range, maxvalue in several places
--
--error ER_PARTITION_MAXVALUE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values less than maxvalue,
 partition x2 values less than maxvalue);

--
-- Partition by range, not increasing ranges
--
--error ER_RANGE_NOT_INCREASING_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (a)
partitions 2
(partition x1 values less than (4),
 partition x2 values less than (3));

--
-- Partition by range, wrong result type of partition function
--
--error ER_PARTITION_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by range (sin(a))
partitions 2
(partition x1 values less than (4),
 partition x2 values less than (5));

--
-- Subpartition by hash, wrong number of subpartitions
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by list (a)
subpartition by hash (a+b)
subpartitions 3
( partition x1 values in (1,2,4)
  ( subpartition x11 nodegroup 0,
    subpartition x12 nodegroup 1),
  partition x2 values in (3,5,6)
  ( subpartition x21 nodegroup 0,
    subpartition x22 nodegroup 1)
);

--
-- Subpartition by hash, wrong number of subpartitions
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by list (a)
subpartition by hash (a+b)
( partition x1 values in (1)
  ( subpartition x11 nodegroup 0,
    subpartition xextra,
    subpartition x12 nodegroup 1),
  partition x2 values in (2)
  ( subpartition x21 nodegroup 0,
    subpartition x22 nodegroup 1)
);

--
-- Subpartition by list => error
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by list (a+b)
( partition x1
  ( subpartition x11,
    subpartition x12),
   partition x2
   ( subpartition x21,
     subpartition x22)
);

--
-- Subpartition by list => error
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key (a,b))
partition by key (a)
subpartition by list (a+b)
( partition x1
  ( subpartition x11 values in (0),
    subpartition x12 values in (1)),
  partition x2
  ( subpartition x21 values in (0),
    subpartition x22 values in (1))
);

--
-- Partition by list, no partition => error
--
--error ER_PARTITIONS_MUST_BE_DEFINED_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a);

--
-- Partition by list, constant partition function not allowed
--
--error ER_WRONG_EXPR_IN_PARTITION_FUNC_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (3+4)
partitions 2
(partition x1 values in (4) tablespace ts1,
 partition x2 values in (8) tablespace ts2);

--
-- Partition by list, invalid field in function
--
--error ER_BAD_FIELD_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a+d)
partitions 2
(partition x1 values in (4) tablespace ts1,
 partition x2 values in (8) tablespace ts2);

--
-- Partition by list, no values in definition
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in (4),
 partition x2);

--
-- Partition by list, values less than error
--
--error ER_PARTITION_WRONG_VALUES_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in (4),
 partition x2 values less than (5));

--
-- Partition by list, no values in definition
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in (4,6),
 partition x2);

--
-- Partition by list, duplicate values
--
--error ER_MULTIPLE_DEF_CONST_IN_LIST_PART_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in (4, 12+9),
 partition x2 values in (3, 21));

--
-- Partition by list, wrong constant result type (not INT)
--
--error ER_VALUES_IS_NOT_INT_TYPE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in (4.0, 12+8),
 partition x2 values in (3, 21));

--
-- Partition by list, missing parenthesis
--
--error ER_PARSE_ERROR
CREATE TABLE t1 (
a int not null,
b int not null,
c int not null,
primary key(a,b))
partition by list (a)
partitions 2
(partition x1 values in 4,
 partition x2 values in (5));

DROP TABLESPACE ts1;
DROP TABLESPACE ts2;
DROP TABLESPACE ts3;

--
-- Bug #13439: Crash when LESS THAN (non-literal)
--
--error ER_BAD_FIELD_ERROR
CREATE TABLE t1 (a int)
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (x1));

--
-- No partition for the given value
--
CREATE TABLE t1(a int)
  PARTITION BY RANGE (a) (PARTITION p1 VALUES LESS THAN(5));
insert into t1 values (10);
drop table t1;
create table t1 (a bigint unsigned)
partition by range (a)
(partition p0 values less than (-1));
create table t1 (v varchar(12))
partition by range (ascii(v))
(partition p0 values less than (10));

-- error ER_PARSE_ERROR
create table t1 (a int)
partition by hash (rand(a));
create table t1 (a int)
partition by hash(CURTIME() + a);
create table t1 (a int)
partition by hash (NOW()+a);
create table t1 (a int)
partition by hash (extract(hour from convert_tz(a, '+00:00', '+00:00')));
create table t1 (a int)
partition by range (a + (select count(*) from t1))
(partition p1 values less than (1));
create table t1 (a char(10))
partition by hash (extractvalue(a,'a'));
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE old (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (UNIX_TIMESTAMP(a)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);

-- Check that allowed arithmetic/math functions involving TIMESTAMP values result
-- in ER_PARTITION_FUNC_NOT_ALLOWED_ERROR when used as a partitioning function

--error ER_FIELD_TYPE_NOT_ALLOWED_AS_PARTITION_FIELD
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (a) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (a) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (a+0) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (a+0) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (a % 2) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (a % 2) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (ABS(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (ABS(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (CEILING(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (CEILING(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (FLOOR(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (FLOOR(a)) (
PARTITION p VALUES LESS THAN (20080819),
PARTITION pmax VALUES LESS THAN MAXVALUE);

-- Check that allowed date/time functions involving TIMESTAMP values result
-- in ER_WRONG_EXPR_IN_PARTITION_FUNC_ERROR when used as a partitioning function

--error ER_WRONG_EXPR_IN_PARTITION_FUNC_ERROR
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (TO_DAYS(a)) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (TO_DAYS(a)) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (DAYOFYEAR(a)) (
PARTITION p VALUES LESS THAN (231),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (DAYOFYEAR(a)) (
PARTITION p VALUES LESS THAN (231),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (DAYOFMONTH(a)) (
PARTITION p VALUES LESS THAN (19),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (DAYOFMONTH(a)) (
PARTITION p VALUES LESS THAN (19),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (DAYOFWEEK(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (DAYOFWEEK(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (MONTH(a)) (
PARTITION p VALUES LESS THAN (8),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (MONTH(a)) (
PARTITION p VALUES LESS THAN (8),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (HOUR(a)) (
PARTITION p VALUES LESS THAN (17),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (HOUR(a)) (
PARTITION p VALUES LESS THAN (17),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (MINUTE(a)) (
PARTITION p VALUES LESS THAN (55),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (MINUTE(a)) (
PARTITION p VALUES LESS THAN (55),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (QUARTER(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (QUARTER(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (SECOND(a)) (
PARTITION p VALUES LESS THAN (7),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (SECOND(a)) (
PARTITION p VALUES LESS THAN (7),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (YEARWEEK(a)) (
PARTITION p VALUES LESS THAN (200833),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (YEARWEEK(a)) (
PARTITION p VALUES LESS THAN (200833),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (YEAR(a)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (YEAR(a)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (WEEKDAY(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (WEEKDAY(a)) (
PARTITION p VALUES LESS THAN (3),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (TIME_TO_SEC(a)) (
PARTITION p VALUES LESS THAN (64507),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (TIME_TO_SEC(a)) (
PARTITION p VALUES LESS THAN (64507),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (EXTRACT(DAY FROM a)) (
PARTITION p VALUES LESS THAN (18),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (EXTRACT(DAY FROM a)) (
PARTITION p VALUES LESS THAN (18),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL, b TIMESTAMP NOT NULL, PRIMARY KEY(a,b))
PARTITION BY RANGE (DATEDIFF(a, a)) (
PARTITION p VALUES LESS THAN (18),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (DATEDIFF(a, a)) (
PARTITION p VALUES LESS THAN (18),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (YEAR(a + 0)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (YEAR(a + 0)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (TO_DAYS(a + '2008-01-01')) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (TO_DAYS(a + '2008-01-01')) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (YEAR(a + '2008-01-01')) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (YEAR(a + '2008-01-01')) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);

ALTER TABLE old ADD COLUMN b DATE;
CREATE TABLE new (a TIMESTAMP, b DATE)
PARTITION BY RANGE (YEAR(a + b)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (YEAR(a + b)) (
PARTITION p VALUES LESS THAN (2008),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP, b DATE)
PARTITION BY RANGE (TO_DAYS(a + b)) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (TO_DAYS(a + b)) (
PARTITION p VALUES LESS THAN (733638),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP, b date)
PARTITION BY RANGE (UNIX_TIMESTAMP(a + b)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old
PARTITION BY RANGE (UNIX_TIMESTAMP(a + b)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);
CREATE TABLE new (a TIMESTAMP, b TIMESTAMP)
PARTITION BY RANGE (UNIX_TIMESTAMP(a + b)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);

ALTER TABLE old MODIFY b TIMESTAMP;
ALTER TABLE old
PARTITION BY RANGE (UNIX_TIMESTAMP(a + b)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);

DROP TABLE old;

CREATE TABLE t1 (a TIMESTAMP NOT NULL PRIMARY KEY);
ALTER TABLE t1
PARTITION BY RANGE (EXTRACT(DAY FROM a)) (
PARTITION p VALUES LESS THAN (18),
PARTITION pmax VALUES LESS THAN MAXVALUE);

DROP TABLE t1;

CREATE TABLE t1 (a INT)
PARTITION BY LIST (a)
SUBPARTITION BY HASH (a) SUBPARTITIONS 2
(PARTITION p1 VALUES IN (1) COMMENT "Comment in p1"
 (SUBPARTITION p1spFirst COMMENT "SubPartition comment in p1spFirst",
  SUBPARTITION p1spSecond COMMENT "SubPartition comment in p1spSecond"),
 PARTITION p2 VALUES IN (2) COMMENT "Comment in p2"
 (SUBPARTITION p2spFirst COMMENT "SubPartition comment in p2spFirst",
  SUBPARTITION p2spSecond COMMENT "SubPartition comment in p2spSecond"));
SELECT PARTITION_NAME, SUBPARTITION_NAME, PARTITION_COMMENT FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 't1' AND TABLE_SCHEMA = 'test';
DROP TABLE t1;

CREATE TABLE t1 (a INT)
PARTITION BY LIST (a)
SUBPARTITION BY HASH (a) SUBPARTITIONS 2
(PARTITION p1 VALUES IN (1)
 (SUBPARTITION p1spFirst COMMENT "SubPartition comment in p1spFirst",
  SUBPARTITION p1spSecond),
 PARTITION p2 VALUES IN (2) COMMENT "Comment in p2"
 (SUBPARTITION p2spFirst,
  SUBPARTITION p2spSecond COMMENT "SubPartition comment in p2spSecond"));
SELECT PARTITION_NAME, SUBPARTITION_NAME, PARTITION_COMMENT FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 't1' AND TABLE_SCHEMA = 'test';
DROP TABLE t1;

CREATE TABLE t1
(a INT ,
 KEY inx_a (a) )
PARTITION BY RANGE (a)
SUBPARTITION BY HASH (a) SUBPARTITIONS 2
(PARTITION pUpTo10 VALUES LESS THAN (10) COMMENT
"This is a long comment (2050 ascii characters)   50 pUpTo10 partition ......80-!.................. 100 ................................................................................................ 200....................................................................................................................................................................................................................................................................................................... 500 ............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................... 1000 ..............1024-|.......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................... 1500 .............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................. 2000 ......................................2048-|++"
 (SUBPARTITION `p-10sp0` ,SUBPARTITION `p-10sp1` ),
 PARTITION pMax VALUES LESS THAN MAXVALUE COMMENT
"This is a long comment (2050 ascii characters)   50 pMax partition comment .80-!.................. 100 ................................................................................................ 200....................................................................................................................................................................................................................................................................................................... 500 ............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................... 1000 ..............1024-|.......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................... 1500 .............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................. 2000 ......................................2048-|++"
 (SUBPARTITION `pMaxsp0` ,SUBPARTITION `pMaxsp1` ));
SELECT PARTITION_NAME, SUBPARTITION_NAME, PARTITION_COMMENT FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 't1' AND TABLE_SCHEMA = 'test' ORDER BY PARTITION_NAME, SUBPARTITION_NAME DESC;

DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION p1 VALUES IN (1),
 PARTITION p3 VALUES IN (3,5),
 PARTITION p6 VALUES IN (6,7));
CREATE TABLE t2 LIKE t1;
ALTER TABLE t2 REMOVE PARTITIONING;
INSERT INTO t2 VALUES (2),(3),(4),(6);
ALTER TABLE t1 EXCHANGE PARTITION p1 WITH TABLE t2 WITHOUT VALIDATION;
INSERT INTO t1 VALUES (2);
INSERT INTO t1 PARTITION (p1) VALUES (3);
UPDATE t1 SET a = 3 WHERE (a % 3) != 0;
UPDATE t1 PARTITION (p1) SET a = 3 WHERE (a % 3) != 0;
UPDATE t1 PARTITION (p1) SET a = 5 WHERE (a % 3) = 0;
UPDATE t1 PARTITION (p1) SET a = 3 WHERE (a % 5) > 3;
UPDATE t1 PARTITION (p1,p6) SET a = 7 WHERE (a % 7) > 5;
DELETE FROM t1 PARTITION (p1) WHERE (a % 7) > 2;
DELETE FROM t1 PARTITION (p1,p6) WHERE (a % 7) > 5;
DELETE FROM t1 WHERE a > 0;
DROP TABLE t1, t2;

CREATE TABLE t1(a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
SET sql_mode='';
SELECT FROM_DAYS(3652499), FROM_DAYS(3652500), FROM_DAYS(3652501);
SELECT FROM_DAYS(4294967660), FROM_DAYS(4294967661), FROM_DAYS(4294967663);
INSERT t1 VALUES(ADDTIME(0,0)), (FROM_DAYS(3652499));
DROP TABLE t1;
SET sql_mode=default;
