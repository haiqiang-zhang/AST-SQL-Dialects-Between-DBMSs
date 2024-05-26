EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5 AND rhs.id = 6;
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5 AND rhs.id = 6;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs LEFT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs LEFT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs LEFT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs LEFT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs RIGHT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs RIGHT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs RIGHT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs RIGHT JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE rhs.id = 5;
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5 AND rhs.id = 6;
SELECT '--';
SELECT lhs.id, rhs.id, lhs.value, rhs.value FROM test_table_1 AS lhs FULL JOIN test_table_2 AS rhs ON lhs.id = rhs.id
WHERE lhs.id = 5 AND rhs.id = 6;
DROP TABLE test_table_1;
DROP TABLE test_table_2;
