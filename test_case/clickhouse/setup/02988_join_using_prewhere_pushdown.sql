DROP TABLE IF EXISTS t;
SET allow_suspicious_low_cardinality_types = 1;
CREATE TABLE t (`id` UInt16, `u` LowCardinality(Int32), `s` LowCardinality(String))
ENGINE = MergeTree ORDER BY id;
INSERT INTO t VALUES (1,1,'a'),(2,2,'b');
