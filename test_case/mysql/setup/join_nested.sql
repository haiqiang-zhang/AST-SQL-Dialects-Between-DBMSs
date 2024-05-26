DROP TABLE IF EXISTS t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;
CREATE TABLE t0 (a int, b int, c int);
CREATE TABLE t1 (a int, b int, c int);
CREATE TABLE t2 (a int, b int, c int);
CREATE TABLE t3 (a int, b int, c int);
CREATE TABLE t4 (a int, b int, c int);
CREATE TABLE t5 (a int, b int, c int);
CREATE TABLE t6 (a int, b int, c int);
CREATE TABLE t7 (a int, b int, c int);
CREATE TABLE t8 (a int, b int, c int);
CREATE TABLE t9 (a int, b int, c int);
INSERT INTO t0 VALUES (1,1,0), (1,2,0), (2,2,0);
INSERT INTO t1 VALUES (1,3,0), (2,2,0), (3,2,0);
INSERT INTO t2 VALUES (3,3,0), (4,2,0), (5,3,0);
INSERT INTO t3 VALUES (1,2,0), (2,2,0);
INSERT INTO t4 VALUES (3,2,0), (4,2,0);
INSERT INTO t5 VALUES (3,1,0), (2,2,0), (3,3,0);
INSERT INTO t6 VALUES (3,2,0), (6,2,0), (6,1,0);
INSERT INTO t7 VALUES (1,1,0), (2,2,0);
INSERT INTO t8 VALUES (0,2,0), (1,2,0);
INSERT INTO t9 VALUES (1,1,0), (1,2,0), (3,3,0);
CREATE TABLE t34 (a3 int, b3 int, c3 int, a4 int, b4 int, c4 int);
INSERT INTO t34
SELECT t3.*, t4.*
FROM t3 CROSS JOIN t4;
CREATE TABLE t345 (a3 int, b3 int, c3 int, a4 int, b4 int, c4 int,
                   a5 int, b5 int, c5 int);
INSERT INTO t345
SELECT t3.*, t4.*, t5.*
FROM t3 CROSS JOIN t4 CROSS JOIN t5;
CREATE TABLE t67 (a6 int, b6 int, c6 int, a7 int, b7 int, c7 int);
INSERT INTO t67
SELECT t6.*, t7.*
FROM t6 CROSS JOIN t7;
