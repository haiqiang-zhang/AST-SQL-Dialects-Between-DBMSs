CREATE TABLE t1 ENGINE=MYISAM AS SELECT repeat('a', 5) AS s1 LIMIT 0;
INSERT INTO t1 VALUES ('x'),('y'),('z'),('X'),('Y'),('Z');
