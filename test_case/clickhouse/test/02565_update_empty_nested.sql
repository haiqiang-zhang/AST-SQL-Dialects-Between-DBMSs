SELECT sum(length(nested.arr1)), sum(length(nested.arr2)) FROM t_update_empty_nested;
DROP TABLE t_update_empty_nested;
