CREATE TABLE dict (key UInt64, value String) ENGINE = EmbeddedRocksDB PRIMARY KEY key;
INSERT INTO dict SELECT number, toString(number) FROM numbers(121);
