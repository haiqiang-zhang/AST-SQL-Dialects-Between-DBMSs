OPTIMIZE TABLE partitioned_by_tuple;
SELECT * FROM partitioned_by_tuple ORDER BY d, x, w, y;
OPTIMIZE TABLE partitioned_by_tuple FINAL;
SELECT * FROM partitioned_by_tuple ORDER BY d, x, w, y;
DROP TABLE partitioned_by_tuple;
