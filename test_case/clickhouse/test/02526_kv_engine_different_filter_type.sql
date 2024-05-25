DROP TABLE IF EXISTS 02526_keeper_map;
DROP TABLE IF EXISTS 02526_rocksdb;
CREATE TABLE 02526_rocksdb (`key` String, `value` UInt32) ENGINE = EmbeddedRocksDB PRIMARY KEY key;
INSERT INTO 02526_rocksdb SELECT * FROM generateRandom('`key` String, `value` UInt32') LIMIT 100;
DROP TABLE 02526_rocksdb;
