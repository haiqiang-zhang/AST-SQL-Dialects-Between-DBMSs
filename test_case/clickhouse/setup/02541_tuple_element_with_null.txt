DROP TABLE IF EXISTS test_tuple_element;
CREATE TABLE test_tuple_element
(
    tuple Tuple(k1 Nullable(UInt64), k2 UInt64)
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO test_tuple_element VALUES (tuple(1,2)), (tuple(NULL, 3));
