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
