SELECT value FROM system.rocksdb WHERE database = currentDatabase() and table = '01686_test' and name = 'number.keys.written';
SELECT value FROM system.rocksdb WHERE database = currentDatabase() and table = '01686_test' and name = 'number.keys.written';
SELECT * FROM 01686_test WHERE key = 123;
SELECT '--';
SELECT * FROM 01686_test WHERE key = -123;
SELECT '--';
SELECT * FROM 01686_test WHERE key = 123 OR key = 4567 ORDER BY key;
SELECT '--';
SELECT * FROM 01686_test WHERE key = NULL;
SELECT '--';
SELECT * FROM 01686_test WHERE key = NULL OR key = 0;
SELECT '--';
SELECT * FROM 01686_test WHERE key IN (123, 456, -123) ORDER BY key;
SELECT '--';
DETACH TABLE 01686_test SYNC;
ATTACH TABLE 01686_test;
SELECT * FROM 01686_test WHERE key IN (99, 999, 9999, -123) ORDER BY key;
DROP TABLE IF EXISTS 01686_test;