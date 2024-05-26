SYSTEM STOP MERGES t_sparse_distinct;
INSERT INTO t_sparse_distinct SELECT number % 10, toString(number % 100 = 0) FROM numbers(100);
INSERT INTO t_sparse_distinct(id) SELECT number % 10 FROM numbers(100);
SELECT name, column, serialization_kind
FROM system.parts_columns
WHERE table = 't_sparse_distinct' AND database = currentDatabase() AND column = 'v'
ORDER BY name;
set optimize_distinct_in_order=1;
set max_threads=1;
select trimLeft(explain) from (explain pipeline SELECT DISTINCT id, v FROM t_sparse_distinct) where explain ilike '%DistinctSortedChunkTransform%';
DROP TABLE t_sparse_distinct;
