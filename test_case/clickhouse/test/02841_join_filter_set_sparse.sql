SELECT countIf(ignore(*) == 0) FROM t1 JOIN t2 ON t1.s = t2.s;
SET join_algorithm = 'full_sorting_merge', max_rows_in_set_to_optimize_join = 100_000;
SELECT countIf(ignore(*) == 0) FROM t1 JOIN t2 ON t1.s = t2.s;
DROP TABLE t1;
DROP TABLE t2;