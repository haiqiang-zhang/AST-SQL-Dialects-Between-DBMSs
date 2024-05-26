CREATE TABLE IF NOT EXISTS local_01213 (id Int) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO local_01213 SELECT toString(number) FROM numbers(2);
INSERT INTO local_01213 SELECT toString(number) FROM numbers(2);
SELECT 'distributed_group_by_no_merge';
SELECT 'optimize_skip_unused_shards';
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=0)';
SELECT 'optimize_skip_unused_shards lack of WHERE (optimize_distributed_group_by_sharding_key=1)';
DROP TABLE local_01213;
