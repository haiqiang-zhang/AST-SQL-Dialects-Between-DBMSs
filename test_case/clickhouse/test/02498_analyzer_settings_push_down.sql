SELECT value FROM (SELECT tupleElement(value, 'a') AS value FROM test_table);
EXPLAIN QUERY TREE SELECT value FROM (
    SELECT tupleElement(value, 'a') AS value FROM test_table
);
SELECT '--';
EXPLAIN QUERY TREE SELECT value FROM (
    SELECT tupleElement(value, 'a') AS value FROM test_table
) SETTINGS optimize_functions_to_subcolumns = 1;
SELECT '--';
EXPLAIN QUERY TREE SELECT value FROM (
    SELECT tupleElement(value, 'a') AS value FROM test_table SETTINGS optimize_functions_to_subcolumns = 0
) SETTINGS optimize_functions_to_subcolumns = 1;
SELECT '--';
EXPLAIN QUERY TREE SELECT value FROM (
    SELECT tupleElement(value, 'a') AS value FROM test_table
) SETTINGS optimize_functions_to_subcolumns = 0;
SELECT '--';
EXPLAIN QUERY TREE SELECT value FROM (
    SELECT tupleElement(value, 'a') AS value FROM test_table SETTINGS optimize_functions_to_subcolumns = 1
) SETTINGS optimize_functions_to_subcolumns = 0;
DROP TABLE test_table;
