CREATE TABLE t1(t text, b blob);
SELECT substr(t, 1, 1) FROM t1;
SELECT substring('abcdefg', 1, 1);
SELECT hex(substr(b, 1, 1)) FROM t1;
