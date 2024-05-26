DROP DATABASE IF EXISTS mysqltest_db1;
CREATE DATABASE mysqltest_db1;
CREATE TABLE t_step (step INT);
INSERT INTO t_step VALUES (@step);
CREATE TABLE t1 (count INT, unix_time INT, local_time INT, comment CHAR(80));
CREATE TABLE t2 (count INT);
INSERT INTO t2 VALUES (1);
INSERT INTO t1 VALUES ((SELECT count FROM t2),
                         unix_time, local_time, comment);
UPDATE t2 SET count= count + 1;
