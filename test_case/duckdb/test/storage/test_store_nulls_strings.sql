PRAGMA force_compression='${compression}';
CREATE TABLE test (a INTEGER, b STRING);;
INSERT INTO test VALUES (NULL, 'hello'), (13, 'abcdefgh'), (12, NULL);
CHECKPOINT;
CREATE TABLE test (a INTEGER, b STRING);;
CREATE TABLE IF NOT EXISTS test (a INTEGER, b STRING);;
DROP TABLE test;
SELECT a, b FROM test ORDER BY a;
SELECT a, b FROM test ORDER BY a;
