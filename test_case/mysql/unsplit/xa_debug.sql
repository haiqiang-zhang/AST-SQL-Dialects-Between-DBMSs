CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1(i INT);
INSERT INTO t1 set i=0;
DROP TABLE t1;
CREATE TABLE t1(d VARCHAR(128));
INSERT INTO t1 VALUES ('I: The first string'), ('I: The second string');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('II: The first string'), ('II: The second string');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('III: The first string'), ('III: The second string');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('IV: The first string'), ('IV: The second string');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('V: The first string'), ('V: The second string');
SELECT * FROM t1;
DROP TABLE t1;