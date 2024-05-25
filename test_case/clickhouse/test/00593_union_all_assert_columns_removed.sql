SET max_columns_to_read = 1;
SELECT a FROM (SELECT * FROM columns);
SELECT a FROM (SELECT * FROM (SELECT * FROM columns));
SELECT a FROM (SELECT * FROM columns UNION ALL SELECT * FROM columns);
DROP TABLE columns;
