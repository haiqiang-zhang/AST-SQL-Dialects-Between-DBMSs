SELECT * FROM t1c;
DROP TABLE t1c, t1p;
CREATE TABLE t1 ( a INT, KEY( a ) INVISIBLE );
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SELECT @@optimizer_switch;
SELECT @@optimizer_switch;
SELECT @@optimizer_switch;
DROP TABLE t1;
CREATE TABLE t1 (
 id INT NOT NULL PRIMARY KEY,
 b INT NOT NULL,
 INDEX (b) INVISIBLE
);
INSERT INTO t1 VALUES (1, 1), (2,2),(3,3),(4,4),(5,5);
DROP TABLE t1;
