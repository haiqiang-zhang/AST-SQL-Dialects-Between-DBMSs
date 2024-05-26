SELECT test_table_join_1.id, test_table_join_1.value, test_table_join_2.id, test_table_join_2.value
FROM test_table_join_1, test_table_join_2;
SELECT '--';
SELECT t1.id, t1.value, t2.id, t2.value FROM test_table_join_1 AS t1, test_table_join_2 AS t2;
SELECT '--';
SELECT t1.id, test_table_join_1.id, t1.value, test_table_join_1.value, t2.id, test_table_join_2.id, t2.value, test_table_join_2.value
FROM test_table_join_1 AS t1, test_table_join_2 AS t2;
SELECT '--';
SELECT t1.id, t1.value, t2.id, t2.value FROM test_table_join_1 AS t1, test_table_join_2 AS t2;
SELECT '--';
SELECT t1.id, test_table_join_1.id, t1.value, test_table_join_1.value, t2.id, test_table_join_2.id, t2.value, test_table_join_2.value FROM test_table_join_1 AS t1, test_table_join_2 AS t2;
SELECT '--';
SELECT test_table_join_1.id, test_table_join_1.value, test_table_join_2.id, test_table_join_2.value, test_table_join_3.id, test_table_join_3.value
FROM test_table_join_1, test_table_join_2, test_table_join_3;
SELECT '--';
SELECT t1.id, t1.value, t2.id, t2.value, t3.id, t3.value
FROM test_table_join_1 AS t1, test_table_join_2 AS t2, test_table_join_3 AS t3;
SELECT '--';
SELECT t1.id, test_table_join_1.id, t1.value, test_table_join_1.value, t2.id, test_table_join_2.id, t2.value, test_table_join_2.value,
t3.id, test_table_join_3.id, t3.value, test_table_join_3.value
FROM test_table_join_1 AS t1, test_table_join_2 AS t2, test_table_join_3 AS t3;
DROP TABLE test_table_join_1;
DROP TABLE test_table_join_2;
DROP TABLE test_table_join_3;
