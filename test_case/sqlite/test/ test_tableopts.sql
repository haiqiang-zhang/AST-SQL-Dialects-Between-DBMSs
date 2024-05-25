SELECT c FROM t1 WHERE a IN (1,2) ORDER BY b;
VACUUM;
SELECT c FROM t1 WHERE a IN (1,2) ORDER BY b;
CREATE TABLE without(x INTEGER PRIMARY KEY, without TEXT);
INSERT INTO without VALUES(1, 'xyzzy'), (2, 'fizzle');
SELECT * FROM without WHERE without='xyzzy';
