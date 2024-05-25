SELECT 'distributed_group_by_no_merge';
SELECT 'optimize_skip_unused_shards';
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=0)';
-- since DISTINCT will be done on each shard separatelly, and initiator will
-- not do anything (since we use optimize_skip_unused_shards=1 that must
-- guarantee that the data had been INSERTed according to sharding key,
-- which is not our case, since we use one local table).
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=1)';
DROP TABLE local_01213;
