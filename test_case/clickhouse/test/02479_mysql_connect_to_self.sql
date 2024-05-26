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
