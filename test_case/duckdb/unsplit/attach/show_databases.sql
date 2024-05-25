PRAGMA enable_verification;
ATTACH DATABASE ':memory:' AS new_database;
USE new_database;
CREATE TABLE tbl AS SELECT 42 i;
SHOW DATABASES;
SELECT name FROM pragma_database_list ORDER BY name;
SELECT * FROM new_database.tbl;
