SELECT * FROM test_2554_log;
DROP TABLE test_2554_log;
DROP TABLE IF EXISTS test_2554_tinylog;
CREATE TABLE test_2554_tinylog (n UInt32) ENGINE = Log SETTINGS storage_policy = 'default';
INSERT INTO test_2554_tinylog SELECT 1;
SELECT * FROM test_2554_tinylog;
DROP TABLE test_2554_tinylog;
DROP TABLE IF EXISTS test_2554_stripelog;
