SELECT k, sum(v) AS s FROM group_by_pk_lc_uint128 GROUP BY k ORDER BY k ASC LIMIT 1024 SETTINGS optimize_aggregation_in_order = 1;
CREATE TABLE group_by_pk_lc_uint256 (`k` LowCardinality(UInt256), `v` UInt32) ENGINE = MergeTree ORDER BY k PARTITION BY v%50;
INSERT INTO group_by_pk_lc_uint256 SELECT number / 100, number FROM numbers(1000);
SELECT k, sum(v) AS s FROM group_by_pk_lc_uint256 GROUP BY k ORDER BY k ASC LIMIT 1024 SETTINGS optimize_aggregation_in_order = 1;
