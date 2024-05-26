SET optimize_move_to_prewhere = 1;
DROP TABLE IF EXISTS t;
CREATE TABLE t (x UInt8) ENGINE = MergeTree ORDER BY x;
INSERT INTO t VALUES (1), (2), (3);
SELECT count() FROM t;
DROP ROW POLICY IF EXISTS filter ON t;
DROP TABLE t;
