USE main_01487;
DROP TABLE IF EXISTS shard_0.l;
DROP TABLE IF EXISTS shard_1.l;
DROP TABLE IF EXISTS d;
DROP TABLE IF EXISTS t;
CREATE TABLE shard_0.l (value UInt8) ENGINE = MergeTree ORDER BY value;
CREATE TABLE shard_1.l (value UInt8) ENGINE = MergeTree ORDER BY value;
CREATE TABLE t (value UInt8) ENGINE = Memory;
INSERT INTO shard_0.l VALUES (0);
INSERT INTO shard_1.l VALUES (1);
INSERT INTO t VALUES (0), (1), (2);
USE test_01487;
DROP DATABASE test_01487;
-- That query is invalid on the initiator node.
set allow_experimental_analyzer = 0;
