-- (databases can be removed in background, so this test should not be run in parallel)

DROP TABLE IF EXISTS t;
CREATE TABLE t (b UInt8) ENGINE = Memory;
DROP TABLE t;
