select sum(NULL);
select quantile(0.5)(NULL);
select quantiles(0.1, 0.2)(NULL :: Nullable(UInt32));
select quantile(0.5)(NULL), quantiles(0.1, 0.2)(NULL :: Nullable(UInt32)), count(NULL), sum(NULL);
SELECT '-- notinhgs:';
SELECT nothing() as n, toTypeName(n);
SELECT '-- quantile:';
SELECT '-- quantiles:';
SELECT '-- nothing:';
SELECT '-- nothing(UInt64):';
SELECT '-- nothing(Nullable(Nothing)):';
SELECT '-- sum:';
SELECT '-- count:';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (`n` UInt64) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO t1 SELECT * FROM numbers(10);
SET
    allow_experimental_parallel_reading_from_replicas=1,
    max_parallel_replicas=2,
    use_hedged_requests=0,
    cluster_for_parallel_replicas='test_cluster_one_shard_three_replicas_localhost',
    parallel_replicas_for_non_replicated_merge_tree=1;
