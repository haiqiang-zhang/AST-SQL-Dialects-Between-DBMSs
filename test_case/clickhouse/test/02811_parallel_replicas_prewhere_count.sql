SELECT '-- count() ------------------------------';
SELECT count() FROM users PREWHERE uid > 2000;
SET
skip_unavailable_shards=1,
allow_experimental_parallel_reading_from_replicas=1,
max_parallel_replicas=3,
cluster_for_parallel_replicas='parallel_replicas',
parallel_replicas_for_non_replicated_merge_tree=1,
parallel_replicas_min_number_of_rows_per_replica=1000;
SELECT '-- count() with parallel replicas -------';
DROP TABLE IF EXISTS users;
