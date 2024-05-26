SELECT * from const_len_bug;
DROP TABLE const_len_bug;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (4),(3),(2),(1);
INSERT INTO t2 SELECT * FROM t1;
DROP TABLE t1,t2;
drop function if exists metaphon;
create database db_31767;
drop database db_31767;
drop function if exists no_such_func;
drop procedure if exists no_such_proc;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2), (3);
SELECT IF( a = 1, a, a ) AS `b` FROM t1 ORDER BY field( `b` + 1, 1 );
DROP TABLE t1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES(1),(50);
DROP TABLE t1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock" AND
        info = "DROP FUNCTION metaphon";
UNLOCK TABLES;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock";
UNLOCK TABLES;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 values
(1, 1), (1, 2), (1, 200),
(2, 1), (2, 200), (2, 200), (2, 1000),
(3, 1), (3, 1), (3, 100), (3, 100), (3, 42);
DROP TABLE t1;
CREATE TABLE users(id INTEGER, name VARCHAR(255));
INSERT INTO users(id, name) VALUES (1, 'Jason'), (2, 'Brian');
CREATE TABLE user_values(id INTEGER, user_id INTEGER, value INTEGER);
INSERT INTO user_values(id, user_id, value) VALUES (1,1,1), (2,2,10);
DROP TABLE users, user_values;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(fld1 INT);
DROP TABLE t1;
CREATE TABLE t1(f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,100),(1,2),(2,100),(2,3);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
DROP TABLE t1;
