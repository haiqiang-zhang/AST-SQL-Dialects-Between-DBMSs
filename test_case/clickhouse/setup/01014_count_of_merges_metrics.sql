DROP TABLE IF EXISTS new_table_test;
DROP TABLE IF EXISTS check_table_test;
CREATE TABLE new_table_test(name String) ENGINE = MergeTree ORDER BY name;
INSERT INTO new_table_test VALUES ('test');
CREATE TABLE check_table_test(value1 UInt64, value2 UInt64) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO check_table_test (value1) SELECT value FROM system.events WHERE event = 'Merge';
