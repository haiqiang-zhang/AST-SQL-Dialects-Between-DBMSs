CREATE TABLE t(a INT, b INT, c INT, KEY k1 (a,b));
INSERT INTO t(a,b) VALUES (1,1),(1,2),(1,3),(2,1),(2,2),(2,2),(2,2),(2,3),(2,3),(2,4);
DROP TABLE t;
