EXPLAIN header = 1, actions = 1 SELECT id, value FROM test_table PREWHERE id = 5 settings allow_experimental_analyzer=0;
EXPLAIN header = 1, actions = 1 SELECT id, value FROM test_table PREWHERE id = 5 settings allow_experimental_analyzer=1;
DROP TABLE test_table;
