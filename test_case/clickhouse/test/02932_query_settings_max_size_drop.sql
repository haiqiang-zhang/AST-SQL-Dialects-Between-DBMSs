ALTER TABLE test_max_size_drop DROP PARTITION tuple();
DROP TABLE test_max_size_drop;
CREATE TABLE test_max_size_drop
Engine = MergeTree()
ORDER BY number
AS SELECT number
FROM numbers(1000);
ALTER TABLE test_max_size_drop DROP PART 'all_1_1_0';
DROP TABLE test_max_size_drop;
