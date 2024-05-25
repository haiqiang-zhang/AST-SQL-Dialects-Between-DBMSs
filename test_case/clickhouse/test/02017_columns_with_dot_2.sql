SELECT * FROM test_nested;
ALTER TABLE test_nested ADD COLUMN `with_dot.bool` UInt8;
SELECT * FROM test_nested;
DROP TABLE test_nested;
