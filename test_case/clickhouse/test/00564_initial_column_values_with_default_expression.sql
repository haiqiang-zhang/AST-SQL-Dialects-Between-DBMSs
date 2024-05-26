SELECT * FROM test ORDER BY id;
INSERT INTO test(id, track, codec, content) VALUES(2, 0, 'h264', 'CONTENT');
SELECT * FROM test ORDER BY id;
DROP TABLE IF EXISTS test;
