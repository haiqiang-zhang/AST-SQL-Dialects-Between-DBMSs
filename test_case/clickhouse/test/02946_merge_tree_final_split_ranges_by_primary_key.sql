OPTIMIZE TABLE test_table;
SELECT COUNT() FROM system.parts WHERE database = currentDatabase() AND table = 'test_table' AND active = 1;
SYSTEM STOP MERGES test_table;
SELECT '--';
SELECT id, value FROM test_table FINAL ORDER BY id;
SELECT '--';
INSERT INTO test_table SELECT 5, '5';
SELECT id, value FROM test_table FINAL ORDER BY id;
SELECT '--';
INSERT INTO test_table SELECT number + 8, number + 8 FROM numbers(8);
SELECT id, value FROM test_table FINAL ORDER BY id;
SELECT '--';
INSERT INTO test_table SELECT number, number FROM numbers(32);
SELECT id, value FROM test_table FINAL ORDER BY id;
DROP TABLE test_table;