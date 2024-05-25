CREATE TABLE join_inner_table__fuzz_1
(
    `id` UUID,
    `key` Nullable(Date),
    `number` Int64,
    `value1` LowCardinality(String),
    `value2` LowCardinality(String),
    `time` Int128
)
ENGINE = MergeTree
ORDER BY (id, number, key)
SETTINGS allow_nullable_key = 1;
INSERT INTO join_inner_table__fuzz_1 SELECT
    CAST('833c9e22-c245-4eb5-8745-117a9a1f26b1', 'UUID') AS id,
    CAST(rowNumberInAllBlocks(), 'String') AS key,
    *
FROM generateRandom('number Int64, value1 String, value2 String, time Int64', 1, 10, 2)
LIMIT 100;
SET max_parallel_replicas = 3,  prefer_localhost_replica = 1, cluster_for_parallel_replicas = 'test_cluster_one_shard_three_replicas_localhost', allow_experimental_parallel_reading_from_replicas = 1;
SET send_logs_level='error';
