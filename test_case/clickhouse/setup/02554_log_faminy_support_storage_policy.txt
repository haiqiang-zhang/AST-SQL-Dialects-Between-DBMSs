DROP TABLE IF EXISTS test_2554_log;
CREATE TABLE test_2554_log (n UInt32) ENGINE = Log SETTINGS storage_policy = 'default';
INSERT INTO test_2554_log SELECT 1;
