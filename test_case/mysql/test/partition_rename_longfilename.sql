DROP TABLE IF EXISTS t1, t2;
let $MYSQLD_DATADIR= `SELECT @@datadir`;

--
-- Bug#30102: rename table does corrupt tables with partition files on failure
-- This test case renames the table such that the partition file name 
-- is 255 chars long. Due the restriction of 260 char path name (including drive label)
-- this will fail in windows.
--
CREATE TABLE t1 (a INT)
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (6),
 PARTITION `p1....................` VALUES LESS THAN (9),
 PARTITION p2 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
--                      1234567890123456789012345678
-- t2_ + end
--     .MY[ID]
--         #P#p[012]
--             28 * @002e
-- 6 + 4 + 5 + 28 * 5 = 155
--echo -- List of files in database `test`, should not be any t1-files here
--list_files $MYSQLD_DATADIR/test t1*
--echo -- List of files in database `test`, should be all t2-files here
--list_files $MYSQLD_DATADIR/test t2*
--sorted_result
SELECT * FROM `t2_............................end`;
SELECT * FROM t1;
DROP TABLE t1;
