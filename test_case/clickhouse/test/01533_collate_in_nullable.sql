SELECT 'Order by without collate';
SELECT * FROM test_collate ORDER BY s, x;
SELECT 'Order by with collate';
SELECT 'Order by tuple without collate';
SELECT * FROM test_collate ORDER BY x, s;
SELECT 'Order by tuple with collate';
DROP TABLE test_collate;
