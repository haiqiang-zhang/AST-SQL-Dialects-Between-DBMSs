SELECT @@global.temptable_use_mmap;
SELECT @@global.temptable_use_mmap;
CREATE TABLE t (c VARCHAR(128));
INSERT INTO t VALUES
(REPEAT('a', 128)),
(REPEAT('b', 128)),
(REPEAT('c', 128)),
(REPEAT('d', 128));
SELECT * FROM
t AS t1,
t AS t2,
t AS t3,
t AS t4,
t AS t5,
t AS t6
ORDER BY 1
LIMIT 2;
DROP TABLE t;
SELECT @@global.temptable_use_mmap;
CREATE TABLE t (c LONGBLOB);
INSERT INTO t VALUES
(REPEAT('a', 128)),
(REPEAT('b', 128)),
(REPEAT('c', 128)),
(REPEAT('d', 128));
SELECT * FROM
t AS t1,
t AS t2,
t AS t3,
t AS t4,
t AS t5,
t AS t6
ORDER BY 1
LIMIT 2;
SELECT @@global.temptable_use_mmap;
DROP TABLE t;
CREATE TABLE t (c LONGBLOB);
INSERT INTO t VALUES
(REPEAT('a', 128)),
(REPEAT('b', 128)),
(REPEAT('c', 128)),
(REPEAT('d', 128));
SELECT * FROM
t AS t1,
t AS t2,
t AS t3,
t AS t4,
t AS t5,
t AS t6
ORDER BY 1
LIMIT 2;
DROP TABLE t;
