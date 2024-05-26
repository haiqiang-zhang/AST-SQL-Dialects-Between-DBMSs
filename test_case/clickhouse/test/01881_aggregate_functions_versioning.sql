SHOW CREATE TABLE test_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test
ENGINE = Null AS
WITH (
        SELECT arrayReduce('sumMapState', [(['foo'], arrayMap(x -> -0., ['foo']))])
    ) AS all_metrics
SELECT
    (finalizeAggregation(arrayReduce('sumMapMergeState', [all_metrics])) AS metrics_tuple).1 AS metric_names,
    metrics_tuple.2 AS metric_values
FROM system.one;
