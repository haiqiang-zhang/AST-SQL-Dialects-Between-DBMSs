SELECT * FROM test_table
WHERE 1 == 1 AND col1 == col1 OR
       0 AND col2 == NULL;
drop table if exists test_table;