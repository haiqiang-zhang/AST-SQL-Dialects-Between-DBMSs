DROP TABLE IF EXISTS test_alter;
CREATE TABLE test_alter (x Date, s String) ENGINE = MergeTree ORDER BY s PARTITION BY x;
ALTER TABLE test_alter MODIFY COLUMN s DEFAULT 'Hello';
ALTER TABLE test_alter MODIFY COLUMN x DEFAULT '2000-01-01';
DESCRIBE TABLE test_alter;
DROP TABLE test_alter;
DROP TABLE IF EXISTS test_alter_r1;
DROP TABLE IF EXISTS test_alter_r2;
