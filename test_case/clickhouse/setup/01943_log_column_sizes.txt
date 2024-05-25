DROP TABLE IF EXISTS test_log;
DROP TABLE IF EXISTS test_tiny_log;
CREATE TABLE test_log (x UInt8, s String, a Array(Nullable(String))) ENGINE = Log;
CREATE TABLE test_tiny_log (x UInt8, s String, a Array(Nullable(String))) ENGINE = TinyLog;
INSERT INTO test_log VALUES (64, 'Value1', ['Value2', 'Value3', NULL]);
INSERT INTO test_tiny_log VALUES (64, 'Value1', ['Value2', 'Value3', NULL]);
