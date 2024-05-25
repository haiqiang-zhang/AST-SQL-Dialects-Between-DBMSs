SET parallel_replicas_for_non_replicated_merge_tree=1;
CREATE TABLE join_inner_table__fuzz_146 (`id` UUID, `key` String, `number` Int64, `value1` String, `value2` String, `time` Nullable(Int64)) ENGINE = MergeTree ORDER BY (id, number, key);
INSERT INTO join_inner_table__fuzz_146 SELECT CAST('833c9e22-c245-4eb5-8745-117a9a1f26b1', 'UUID') AS id, CAST(rowNumberInAllBlocks(), 'String') AS key, * FROM generateRandom('number Int64, value1 String, value2 String, time Int64', 1, 10, 2) LIMIT 100;
CREATE TABLE t_02709__fuzz_23 (`key` Nullable(UInt8), `sign` Int8, `date` DateTime64(3)) ENGINE = CollapsingMergeTree(sign) PARTITION BY date ORDER BY key SETTINGS allow_nullable_key=1;
INSERT INTO t_02709__fuzz_23 values (1, 1, '2023-12-01 00:00:00.000');
