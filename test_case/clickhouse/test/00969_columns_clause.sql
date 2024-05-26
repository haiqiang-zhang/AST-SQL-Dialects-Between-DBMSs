SELECT COLUMNS('product.*') from ColumnsClauseTest ORDER BY product_price;
DROP TABLE ColumnsClauseTest;
SELECT number, COLUMNS('') FROM numbers(2);
SELECT * FROM numbers(2) WHERE NOT ignore();
SELECT COLUMNS('n') + COLUMNS('u') FROM system.numbers LIMIT 2;
SELECT COLUMNS('a') + COLUMNS('b') FROM (SELECT 1 AS a, 2 AS b);
SELECT COLUMNS('a') + COLUMNS('a') FROM (SELECT 1 AS a, 2 AS b);
SELECT COLUMNS('b') + COLUMNS('b') FROM (SELECT 1 AS a, 2 AS b);
SELECT plus(COLUMNS('^(a|b)$')) FROM (SELECT 1 AS a, 2 AS b);
