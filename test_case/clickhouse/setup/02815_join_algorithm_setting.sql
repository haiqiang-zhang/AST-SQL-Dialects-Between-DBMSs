DROP TABLE IF EXISTS rdb;
DROP TABLE IF EXISTS t2;
CREATE TABLE rdb ( `key` UInt32, `value` String )
ENGINE = EmbeddedRocksDB PRIMARY KEY key;
INSERT INTO rdb VALUES (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e');
CREATE TABLE t2 ( `k` UInt16 ) ENGINE = TinyLog;
INSERT INTO t2 VALUES (4), (5), (6);
