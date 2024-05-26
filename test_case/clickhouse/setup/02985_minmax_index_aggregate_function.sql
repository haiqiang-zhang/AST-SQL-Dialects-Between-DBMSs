DROP TABLE IF EXISTS t_index_agg_func;
CREATE TABLE t_index_agg_func
(
    id UInt64,
    v AggregateFunction(avg, UInt64),
)
ENGINE = AggregatingMergeTree ORDER BY id
SETTINGS index_granularity = 4;
ALTER TABLE t_index_agg_func ADD INDEX idx_v finalizeAggregation(v) TYPE minmax GRANULARITY 1;
INSERT INTO t_index_agg_func SELECT number % 10, initializeAggregation('avgState', toUInt64(number % 20)) FROM numbers(1000);
INSERT INTO t_index_agg_func SELECT number % 10, initializeAggregation('avgState', toUInt64(number % 20)) FROM numbers(1000, 1000);
