DROP TABLE IF EXISTS t;
CREATE TABLE t (x UInt8, PROJECTION p (SELECT x GROUP BY x)) ENGINE = MergeTree ORDER BY () SETTINGS allow_experimental_block_number_column=true;
INSERT INTO t VALUES (0);
INSERT INTO t VALUES (1),(1);
INSERT INTO t VALUES (2),(3);
SELECT x FROM t GROUP BY x;
OPTIMIZE TABLE t FINAL;
SELECT '*** AFTER FIRST OPTIMIZE ***';
SELECT x,_block_number FROM t;
INSERT INTO t VALUES (4), (5), (6);
OPTIMIZE TABLE t FINAL;
SELECT '*** AFTER SECOND OPTIMIZE ***';
SELECT x,_block_number FROM t;
DROP TABLE t;