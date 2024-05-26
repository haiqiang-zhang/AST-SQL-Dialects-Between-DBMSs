EXPLAIN header = 1, actions = 1 SELECT lhs.id, lhs.value_1, rhs.id, rhs.value_1
FROM test_table_1 AS lhs INNER JOIN test_table_2 AS rhs ON lhs.id = rhs.id;
SELECT '--';
EXPLAIN header = 1, actions = 1 SELECT lhs.id, lhs.value_1, rhs.id, rhs.value_1
FROM test_table_1 AS lhs ASOF JOIN test_table_2 AS rhs ON lhs.id = rhs.id AND lhs.value_2 < rhs.value_2;
DROP TABLE test_table_1;
DROP TABLE test_table_2;
