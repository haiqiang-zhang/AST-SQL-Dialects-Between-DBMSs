SELECT 'distributed_group_by_no_merge';
SELECT 'optimize_skip_unused_shards';
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=0)';
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=1)';
DROP TABLE local_01213;
