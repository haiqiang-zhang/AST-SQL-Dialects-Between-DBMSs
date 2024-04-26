DROP TABLE IF EXISTS t1;
CREATE TABLE t1
(a INT)
PARTITION BY KEY(a) PARTITIONS 3;
ALTER TABLE t1 REPAIR PARTITION p2,p3,p1;
ALTER TABLE t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY)
PARTITION BY HASH (a)
PARTITIONS 1;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11);
INSERT INTO t1 VALUES (12), (13), (14), (15), (16), (17), (18), (19), (20);
ALTER TABLE t1 REORGANIZE PARTITION p0 INTO (PARTITION pHidden);
ALTER TABLE t1 ADD PARTITION PARTITIONS 1;
ALTER TABLE t1 ADD PARTITION
(PARTITION pNamed1);
ALTER TABLE t1 ADD PARTITION
(PARTITION pNamed2);
ALTER TABLE t1 ADD PARTITION
(PARTITION p5);
ALTER TABLE t1 ADD PARTITION PARTITIONS 1;
ALTER TABLE t1 REBUILD PARTITION all;
ALTER TABLE t1 REBUILD PARTITION pNamed1,p5;
ALTER TABLE t1 COALESCE PARTITION 1;
ALTER TABLE t1 COALESCE PARTITION 2;
DROP TABLE t1;

--
-- Bug 40389: REORGANIZE PARTITION crashes when only using one partition
--
CREATE TABLE t1 (a INT PRIMARY KEY)
PARTITION BY HASH (a)
PARTITIONS 1;
INSERT INTO t1 VALUES (1),(2),(3),(4),(5);
ALTER TABLE t1 REORGANIZE PARTITION;
DROP TABLE t1;

--
-- Bug 21143: mysqld hang when error in number of subparts in
--            REORGANIZE command
--
create table t1 (a int)
partition by range (a)
subpartition by key (a)
(partition p0 values less than (10) (subpartition sp00, subpartition sp01),
 partition p1 values less than (20) (subpartition sp10, subpartition sp11));

-- error ER_PARTITION_WRONG_NO_SUBPART_ERROR
alter table t1 reorganize partition p0 into
(partition p0 values less than (10) (subpartition sp00,
subpartition sp01, subpartition sp02));
drop table t1;

CREATE TABLE t1 (f_date DATE, f_varchar VARCHAR(30))
PARTITION BY HASH(YEAR(f_date)) PARTITIONS 2;
let $MYSQLD_DATADIR= `select @@datadir`;
ALTER TABLE t1 COALESCE PARTITION 1;
drop table t1;
create table t1 (a int)
partition by list (a)
subpartition by hash (a)
(partition p11 values in (1,2),
 partition p12 values in (3,4));

alter table t1 REORGANIZE partition p11, p12 INTO
(partition p1 values in (1,2,3,4));

alter table t1 REORGANIZE partition p1 INTO
(partition p11 values in (1,2),
 partition p12 values in (3,4));

drop table t1;
CREATE TABLE t1 (a INT)
/*!50100 PARTITION BY HASH (a)
/* Test
   of multi-line
   comment */
PARTITIONS 5 */;
DROP TABLE t1;
CREATE TABLE t1 (a INT)
/*!50100 PARTITION BY HASH (a)
-- with a single line comment embedded
PARTITIONS 5 */;
DROP TABLE t1;
CREATE TABLE t1 (a INT)
/*!50100 PARTITION BY HASH (a)
PARTITIONS 5 */;
DROP TABLE t1;
CREATE TABLE t1 (a INT) /*!50100 PARTITION BY HASH (a) PARTITIONS 5 */;
DROP TABLE t1;
