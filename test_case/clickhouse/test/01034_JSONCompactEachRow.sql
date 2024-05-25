DROP TABLE IF EXISTS test_table;
DROP TABLE IF EXISTS test_table_2;
SELECT 1;
/* Check JSONCompactEachRow Output */
CREATE TABLE test_table (value UInt8, name String) ENGINE = MergeTree() ORDER BY value;
INSERT INTO test_table VALUES (1, 'a'), (2, 'b'), (3, 'c');
SELECT 2;
SELECT 3;
SELECT '----------';
SELECT 4;
DROP TABLE IF EXISTS test_table;
SELECT 5;
/* Check JSONCompactEachRow Input */
CREATE TABLE test_table (v1 String, v2 UInt8, v3 DEFAULT v2 * 16, v4 UInt8 DEFAULT 8) ENGINE = MergeTree() ORDER BY v2;
TRUNCATE TABLE test_table;
SELECT 6;
TRUNCATE TABLE test_table;
SELECT 7;
/* Check Nested */
CREATE TABLE test_table_2 (v1 UInt8, n Nested(id UInt8, name String)) ENGINE = MergeTree() ORDER BY v1;
TRUNCATE TABLE test_table_2;
SELECT 8;
TRUNCATE TABLE test_table;
SELECT 9;
SELECT 10;
/* Check Header */
TRUNCATE TABLE test_table;
SELECT 11;
TRUNCATE TABLE test_table;
SELECT '----------';
SELECT 12;
SELECT '----------';
DROP TABLE IF EXISTS test_table;
DROP TABLE IF EXISTS test_table_2;
