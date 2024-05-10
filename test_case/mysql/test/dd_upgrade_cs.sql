CREATE TABLE t1 (f1 INT CHECK (f1 < 10));
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
DROP TABLE t1;
SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES
         WHERE TABLE_NAME = 'schema_auto_increment_columns' OR
               TABLE_NAME = 'schema_object_overview' OR
               TABLE_NAME = 'schema_redundant_indexes' OR
               TABLE_NAME = 'schema_unused_indexes' OR
               TABLE_NAME = 'x$schema_flattened_keys'
         ORDER BY TABLE_NAME;
