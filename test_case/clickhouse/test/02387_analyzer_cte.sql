WITH cte_subquery AS (SELECT 1) SELECT * FROM cte_subquery;
SELECT '--';
WITH cte_subquery AS (SELECT * FROM test_table) SELECT * FROM cte_subquery;
SELECT '--';
WITH cte_subquery AS (SELECT 1 UNION DISTINCT SELECT 1) SELECT * FROM cte_subquery;
SELECT '--';
WITH cte_subquery AS (SELECT * FROM test_table UNION DISTINCT SELECT * FROM test_table) SELECT * FROM cte_subquery;
DROP TABLE test_table;
