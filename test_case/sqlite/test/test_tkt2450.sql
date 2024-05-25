SELECT """cb""" FROM "t a";
SELECT * FROM "t a";
SELECT "t a".* FROM "t a";
CREATE TABLE t1(a);
INSERT INTO t1 VALUES(2);
SELECT * FROM "t a", t1;
