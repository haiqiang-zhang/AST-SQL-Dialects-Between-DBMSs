CREATE TABLE t (k1 UInt64, k2 UInt64, v UInt64) ENGINE = ReplacingMergeTree() ORDER BY (k1, k2);
SET optimize_on_insert = 0;
INSERT INTO t VALUES (1, 2, 3) (1, 2, 4) (2, 3, 4), (2, 3, 5);
