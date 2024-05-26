SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
CREATE TABLE test (id UInt64, `amax` AggregateFunction(argMax, String, DateTime))
ENGINE=MergeTree()
ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization=1 -- Sparse columns will take more bytes for a single row
AS
    SELECT number, argMaxState(number::String, '2023-04-12 16:23:01'::DateTime)
    FROM numbers(1)
    GROUP BY number;
INSERT INTO test
    SELECT number, argMaxState(number::String, '2023-04-12 16:23:01'::DateTime)
    FROM numbers(9)
    GROUP BY number;
INSERT INTO test
SELECT number, argMaxState(number::String, '2023-04-12 16:23:01'::DateTime)
FROM numbers(990)
GROUP BY number;
