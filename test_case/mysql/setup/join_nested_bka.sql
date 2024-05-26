CREATE TABLE t5 (a int, b int, c int, PRIMARY KEY(a), KEY b_i (b));
CREATE TABLE t6 (a int, b int, c int, PRIMARY KEY(a), KEY b_i (b));
CREATE TABLE t7 (a int, b int, c int, PRIMARY KEY(a), KEY b_i (b));
CREATE TABLE t8 (a int, b int, c int, PRIMARY KEY(a), KEY b_i (b));
INSERT INTO t5 VALUES (1,1,0), (2,2,0), (3,3,0);
INSERT INTO t6 VALUES (1,2,0), (3,2,0), (6,1,0);
INSERT INTO t7 VALUES (1,1,0), (2,2,0);
INSERT INTO t8 VALUES (0,2,0), (1,2,0);
