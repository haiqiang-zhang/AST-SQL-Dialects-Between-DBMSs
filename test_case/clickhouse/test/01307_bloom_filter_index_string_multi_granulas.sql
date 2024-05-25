SELECT count() FROM test_01307 WHERE identity(val) = '2';
SELECT count() FROM test_01307 WHERE val = '2';
OPTIMIZE TABLE test_01307 FINAL;
SELECT count() FROM test_01307 WHERE identity(val) = '2';
SELECT count() FROM test_01307 WHERE val = '2';
DROP TABLE test_01307;
