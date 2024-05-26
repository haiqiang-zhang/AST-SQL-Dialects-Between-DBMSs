SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS foo;
CREATE TABLE foo (key UInt32, a String, b Int64, c String) ENGINE = TinyLog;
INSERT INTO foo VALUES (1, 'one', -1, 'een'), (2, 'two', -2, 'twee'), (3, 'three', -3, 'drie'), (4, 'four', -4, 'vier'), (5, 'five', -5, 'vijf');
SET allow_experimental_analyzer = 1;
SELECT '---';
SELECT * FROM mysql('127.0.0.1:9004', currentDatabase(), foo, 'default', '', SETTINGS connect_timeout = 100, connection_wait_timeout = 100) ORDER BY key;
SELECT '---';
SELECT count() FROM mysql('127.0.0.1:9004', currentDatabase(), foo, 'default', '', SETTINGS connect_timeout = 100, connection_wait_timeout = 100);
SELECT '---';
SELECT '---';
SELECT '---';
SELECT '---';
SELECT '---';
SELECT '---';
EXPLAIN QUERY TREE dump_ast = 1
SELECT * FROM mysql(
    '127.0.0.1:9004', currentDatabase(), foo, 'default', '',
    SETTINGS connection_wait_timeout = 123, connect_timeout = 40123002, read_write_timeout = 40123001, connection_pool_size = 3
);
SELECT '---';
DROP TABLE foo;
