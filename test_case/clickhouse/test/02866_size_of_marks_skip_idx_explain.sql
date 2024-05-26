EXPLAIN indexes = 1 SELECT * FROM test_skip_idx WHERE id < 2;
EXPLAIN indexes = 1 SELECT * FROM test_skip_idx WHERE id < 3;
DROP TABLE test_skip_idx;
