
CREATE TABLE t1 (a int) PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (1),
 PARTITION p1 VALUES LESS THAN (2));

INSERT INTO t1 VALUES (0),(1);
SELECT * FROM t1;
ALTER TABLE t1 DROP PARTITION p3;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS tbl_with_partitions;

CREATE TABLE tbl_with_partitions ( i INT ) 
	PARTITION BY HASH(i);
INSERT INTO tbl_with_partitions VALUES (1);
SET AUTOCOMMIT = 0;
SELECT * FROM tbl_with_partitions;
set session debug="+d,abort_copy_table";
ALTER TABLE tbl_with_partitions ADD COLUMN f INT, ALGORITHM=COPY;
SELECT * FROM tbl_with_partitions;
DROP TABLE tbl_with_partitions;
