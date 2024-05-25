DROP TABLE IF EXISTS t1__fuzz_0;
CREATE TABLE t1__fuzz_0
(
    `x` UInt8,
    `str` String
)
ENGINE = MergeTree ORDER BY x;
INSERT INTO t1__fuzz_0 SELECT number, toString(number) FROM numbers(10);
DROP TABLE IF EXISTS left_join__fuzz_2;
CREATE TABLE left_join__fuzz_2
(
    `x` UInt32,
    `s` LowCardinality(String)
) ENGINE = Join(`ALL`, LEFT, x);
INSERT INTO left_join__fuzz_2 SELECT number, toString(number) FROM numbers(10);
