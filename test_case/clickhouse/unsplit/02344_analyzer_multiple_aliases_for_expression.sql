SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=TinyLog;
INSERT INTO test_table VALUES (0, 'Value');
SELECT 1 AS value, 1 AS value;
SELECT id AS value, id AS value FROM test_table;
WITH x -> x + 1 AS lambda, x -> x + 1 AS lambda SELECT lambda(1);
SELECT (SELECT 1) AS subquery, (SELECT 1) AS subquery;
DROP TABLE test_table;
