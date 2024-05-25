ALTER TABLE test CLEAR COLUMN x;
ALTER TABLE test ADD COLUMN z String DEFAULT 'Hello';
ALTER TABLE test CLEAR COLUMN x;
ALTER TABLE test CLEAR COLUMN z;
INSERT INTO test (x, y, z) VALUES (1, 1, 'a'), (2, 2, 'b'), (3, 3, 'c');
ALTER TABLE test CLEAR COLUMN z;
ALTER TABLE test CLEAR COLUMN x;
SELECT * FROM test ORDER BY y;
DROP TABLE IF EXISTS test;
