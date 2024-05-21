DROP TABLE IF EXISTS src_00726;
DROP TABLE IF EXISTS mv1_00726;
DROP TABLE IF EXISTS mv2_00726;
CREATE TABLE src_00726 (x UInt8) ENGINE = Null;
CREATE MATERIALIZED VIEW mv1_00726 ENGINE = Memory AS SELECT x FROM src_00726 WHERE x % 2 = 0;
CREATE MATERIALIZED VIEW mv2_00726 ENGINE = Memory AS SELECT x FROM src_00726 WHERE x % 2 = 1;
SET parallel_view_processing = 1;
INSERT INTO src_00726 VALUES (1), (2);
SET parallel_view_processing = 0;
INSERT INTO src_00726 VALUES (3), (4);
SELECT * FROM mv1_00726 ORDER BY x;
SELECT * FROM mv2_00726 ORDER BY x;
DROP TABLE mv1_00726;
DROP TABLE mv2_00726;
DROP TABLE src_00726;