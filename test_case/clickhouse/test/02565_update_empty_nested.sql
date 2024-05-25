SET mutations_sync = 2;
INSERT INTO t_update_empty_nested SELECT 1, range(number % 10) FROM numbers(100000);
ALTER TABLE t_update_empty_nested ADD COLUMN `nested.arr2` Array(UInt64);
ALTER TABLE t_update_empty_nested UPDATE `nested.arr2` = `nested.arr1` WHERE 1;
SELECT sum(length(nested.arr1)), sum(length(nested.arr2)) FROM t_update_empty_nested;
DROP TABLE t_update_empty_nested;
