EXPLAIN QUERY TREE SELECT grouping(id), grouping(value) FROM test_table GROUP BY id, value;
SELECT grouping(id) AS grouping_id, grouping(value) AS grouping_value, id, value FROM test_table
GROUP BY id, value ORDER BY grouping_id, grouping_value;
SELECT grouping(id) AS grouping_id, grouping(value) AS grouping_value, id, value FROM test_table
GROUP BY ROLLUP (id, value) ORDER BY grouping_id, grouping_value;
SELECT grouping(id) AS grouping_id, grouping(value) AS grouping_value, id, value FROM test_table
GROUP BY CUBE (id, value) ORDER BY grouping_id, grouping_value;
SELECT grouping(id) AS grouping_id, grouping(value) AS grouping_value, id, value FROM test_table
GROUP BY GROUPING SETS (id, value) ORDER BY grouping_id, grouping_value;
SELECT grouping(id) AS grouping_id, grouping(value) AS grouping_value, id, value FROM test_table
GROUP BY GROUPING SETS ((id), (value)) ORDER BY grouping_id, grouping_value;
DROP TABLE test_table;
