DROP TABLE IF EXISTS test;
DROP TABLE IF EXISTS test_r1;
DROP TABLE IF EXISTS test_r2;
SELECT groupArray(name) FROM system.columns WHERE database = currentDatabase() AND table = 'test';
