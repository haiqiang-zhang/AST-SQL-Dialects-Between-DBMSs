drop table if exists t1, t2;
CREATE TABLE t1 (a int);
CREATE OR REPLACE VIEW v1 AS SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a,b))
PARTITION BY KEY(A, b);
DROP TABLE t1;
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
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TO_DAYS(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TO_DAYS(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (DAYOFMONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (DAYOFMONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (MONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MONTH(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (DAYOFYEAR(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (DAYOFYEAR(a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (HOUR(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (HOUR(a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (MINUTE(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MINUTE(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (QUARTER(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (QUARTER(a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (SECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (SECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (YEARWEEK(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (YEARWEEK(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (WEEKDAY(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (WEEKDAY(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (TO_SECONDS(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TO_SECONDS(a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (MICROSECOND(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (MICROSECOND(a));
DROP TABLE t1;
CREATE TABLE t1
(`date` date,
 `extracted_week` int,
 `yearweek` int,
 `week` int,
 `default_week_format` int);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
INSERT INTO t1 VALUES ('2000-01-01', EXTRACT(WEEK FROM '2000-01-01'), YEARWEEK('2000-01-01'), WEEK('2000-01-01'), @@default_week_format);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(YEAR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(YEAR_MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(QUARTER FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MONTH FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE)
PARTITION BY HASH (EXTRACT(DAY FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE_SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(SECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(DAY_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(MINUTE_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (EXTRACT(SECOND_MICROSECOND FROM a));
DROP TABLE t1;
CREATE TABLE t1 (a DATE, b DATETIME)
PARTITION BY HASH (DATEDIFF(a, b));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME, b DATE)
PARTITION BY HASH (DATEDIFF(a, b));
DROP TABLE t1;
CREATE TABLE t1 (a TIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME)
PARTITION BY HASH (TIME_TO_SEC(a));
DROP TABLE t1;
CREATE TABLE t2 (c TIMESTAMP);
DROP TABLE t2;
CREATE TABLE t1 (c TIMESTAMP)
PARTITION BY RANGE (UNIX_TIMESTAMP(c))
(PARTITION p0 VALUES LESS THAN (UNIX_TIMESTAMP('2000-01-01 00:00:00')),
 PARTITION p1 VALUES LESS THAN (MAXVALUE));
DROP TABLE t1;
CREATE TABLE t1 (a INT) PARTITION BY HASH(a);
DROP TABLE t1;
SELECT @@sql_mode;
CREATE TABLE t1 (a INTEGER NOT NULL, PRIMARY KEY (a));
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER NOT NULL, PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 2;
DROP TABLE t1;
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';
CREATE TABLESPACE ts3 ADD DATAFILE 'ts3.ibd';
select load_file('$MYSQLD_DATADIR/test/t1.par');
DROP TABLESPACE ts1;
DROP TABLESPACE ts3;
CREATE TABLE t1(a int)
  PARTITION BY RANGE (a) (PARTITION p1 VALUES LESS THAN(5));
drop table t1;
CREATE TABLE old (a TIMESTAMP NOT NULL PRIMARY KEY)
PARTITION BY RANGE (UNIX_TIMESTAMP(a)) (
PARTITION p VALUES LESS THAN (1219089600),
PARTITION pmax VALUES LESS THAN MAXVALUE);
ALTER TABLE old ADD COLUMN b DATE;
ALTER TABLE old MODIFY b TIMESTAMP;
DROP TABLE old;
CREATE TABLE t1 (a TIMESTAMP NOT NULL PRIMARY KEY);
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
SELECT PARTITION_NAME, SUBPARTITION_NAME, PARTITION_COMMENT FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 't1' AND TABLE_SCHEMA = 'test' ORDER BY PARTITION_NAME, SUBPARTITION_NAME DESC;
CREATE TABLE t1 (a int)
PARTITION BY LIST (a)
(PARTITION p1 VALUES IN (1),
 PARTITION p3 VALUES IN (3,5),
 PARTITION p6 VALUES IN (6,7));
CREATE TABLE t2 LIKE t1;
ALTER TABLE t2 REMOVE PARTITIONING;
INSERT INTO t2 VALUES (2),(3),(4),(6);
ALTER TABLE t1 EXCHANGE PARTITION p1 WITH TABLE t2 WITHOUT VALIDATION;
DROP TABLE t1, t2;
CREATE TABLE t1(a DATETIME)
PARTITION BY HASH (EXTRACT(HOUR_MICROSECOND FROM a));
SELECT FROM_DAYS(3652499), FROM_DAYS(3652500), FROM_DAYS(3652501);
DROP TABLE t1;
