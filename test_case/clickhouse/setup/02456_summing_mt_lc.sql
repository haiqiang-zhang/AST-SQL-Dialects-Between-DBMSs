SET allow_suspicious_low_cardinality_types = 1;
DROP TABLE IF EXISTS t_summing_lc;
CREATE TABLE t_summing_lc
(
    `key` UInt32,
    `val` LowCardinality(UInt32),
    `date` DateTime
)
ENGINE = SummingMergeTree(val)
PARTITION BY date
ORDER BY key;
INSERT INTO t_summing_lc VALUES (1, 1, '2020-01-01'), (2, 1, '2020-01-02'), (1, 5, '2020-01-01'), (2, 5, '2020-01-02');
