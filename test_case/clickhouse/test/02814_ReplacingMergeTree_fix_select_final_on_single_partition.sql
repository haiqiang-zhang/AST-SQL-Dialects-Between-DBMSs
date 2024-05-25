OPTIMIZE TABLE t FINAL;
SELECT count() FROM t;
SELECT count() FROM t FINAL;
-- Previously, `do_not_merge_across_partitions_select_final = 1` showed more rows, 
-- as if no rows were deleted.
SELECT count() FROM t FINAL SETTINGS do_not_merge_across_partitions_select_final = 1;
SELECT count() FROM t FINAL SETTINGS do_not_merge_across_partitions_select_final = 0;
DROP TABLE t;
