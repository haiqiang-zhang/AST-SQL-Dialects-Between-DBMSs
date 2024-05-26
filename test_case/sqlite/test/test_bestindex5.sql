SELECT * FROM t3 WHERE (a, b) != (45, 46);
SELECT * FROM t3 WHERE (a, b) != ('45', '46');
SELECT * FROM t3 WHERE (a, b) == (45, 46);
SELECT * FROM t3 WHERE (a, b) == ('45', '46');
CREATE TABLE t4x(a INTEGER);
INSERT INTO t4x VALUES(245);
