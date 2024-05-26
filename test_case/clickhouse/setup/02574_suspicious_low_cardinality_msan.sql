DROP TABLE IF EXISTS table1__fuzz_19;
SET allow_suspicious_low_cardinality_types = 1;
CREATE TABLE table1__fuzz_19 (`id` LowCardinality(UInt16), `v` DateTime64(3, 'UTC')) ENGINE = ReplacingMergeTree(v) PARTITION BY id % 200 ORDER BY id;
INSERT INTO table1__fuzz_19 SELECT number - 205, number FROM numbers(10);
INSERT INTO table1__fuzz_19 SELECT number - 205, number FROM numbers(400, 10);
