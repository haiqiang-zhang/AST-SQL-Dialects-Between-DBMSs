SELECT * FROM t;
SET mutations_sync = 1;
ALTER TABLE t UPDATE x = x - 1 WHERE x % 2 = 1;
SELECT '---';
SELECT * FROM t;
DROP TABLE t;
