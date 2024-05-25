CREATE TABLE t1 (a int) PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (1),
 PARTITION p1 VALUES LESS THAN (2));
INSERT INTO t1 VALUES (0),(1);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS tbl_with_partitions;
CREATE TABLE tbl_with_partitions ( i INT ) 
	PARTITION BY HASH(i);
INSERT INTO tbl_with_partitions VALUES (1);
LOCK TABLE tbl_with_partitions READ;
SELECT * FROM tbl_with_partitions;
SELECT * FROM tbl_with_partitions;
UNLOCK TABLES;
DROP TABLE tbl_with_partitions;
