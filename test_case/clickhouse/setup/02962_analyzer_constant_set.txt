DROP TABLE IF EXISTS test_parallel_index;
CREATE TABLE test_parallel_index
(
    z UInt64,
    INDEX i z TYPE set(8)
)
ENGINE = MergeTree
ORDER BY ();
insert into test_parallel_index select number from numbers(10);
