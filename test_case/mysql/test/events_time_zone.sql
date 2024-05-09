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
SELECT * FROM t1 ORDER BY count, comment;
DROP TABLE t1, t2;
CREATE TABLE t1 (event CHAR(2), dt DATE, offset INT);
SELECT * FROM t1 ORDER BY dt, event;
DROP TABLE t1;
DROP TABLE t_step;
DROP DATABASE mysqltest_db1;
SELECT COUNT(*) = 0 FROM information_schema.processlist
  WHERE db='mysqltest_db1' AND command = 'Connect' AND user=current_user();
