SELECT * EXCEPT (id) FROM test_table;
SELECT * REPLACE STRICT (1 AS id, 2 AS value) FROM test_table;
DROP TABLE IF EXISTS test_table;
