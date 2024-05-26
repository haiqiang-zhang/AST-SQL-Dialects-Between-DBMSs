SET allow_suspicious_low_cardinality_types = 1;
CREATE TABLE group_by_pk_lc_uint128 (`k` LowCardinality(UInt128), `v` UInt32) ENGINE = MergeTree ORDER BY k PARTITION BY v%50;
INSERT INTO group_by_pk_lc_uint128 SELECT number / 100, number FROM numbers(1000);
