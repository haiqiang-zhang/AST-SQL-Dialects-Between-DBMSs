SELECT table2.parent_id = '', isNull(table2.parent_id)
FROM table1 ANY LEFT JOIN table2 ON table1.id = table2.parent_id;
SET join_use_nulls = 1;
SELECT table2.parent_id = '', isNull(table2.parent_id)
FROM table1 ANY LEFT JOIN table2 ON table1.id = table2.parent_id;
DROP TABLE table1;
DROP TABLE table2;
