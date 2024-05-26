SELECT rootpage FROM sqlite_master;
CREATE TABLE t2(a);
SELECT rootpage FROM sqlite_master WHERE name = 't2';
SELECT * FROM t2;
