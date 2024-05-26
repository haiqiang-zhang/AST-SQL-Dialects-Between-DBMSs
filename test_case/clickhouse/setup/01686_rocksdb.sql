DROP TABLE IF EXISTS 01686_test;
CREATE TABLE 01686_test (key UInt64, value String) Engine=EmbeddedRocksDB PRIMARY KEY(key);
