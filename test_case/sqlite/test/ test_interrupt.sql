CREATE TABLE t1(a,b);
SELECT name FROM sqlite_master;
DROP TABLE t1;
SELECT name FROM sqlite_master;
PRAGMA integrity_check;
BEGIN;
CREATE TABLE t1(a,b);
INSERT INTO t1 SELECT a+2, a || '-' || b FROM t1;
INSERT INTO t1 SELECT a+4, a || '-' || b FROM t1;
INSERT INTO t1 SELECT a+8, a || '-' || b FROM t1;
INSERT INTO t1 SELECT a+16, a || '-' || b FROM t1;
INSERT INTO t1 SELECT a+32, a || '-' || b FROM t1;
UPDATE t1 SET b=substr(b,-5,5);
SELECT count(*) from t1;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
VACUUM;
EXPLAIN SELECT max(a,b), a, b FROM t1;
PRAGMA integrity_check;
BEGIN;
CREATE TEMP TABLE t2(x,y);
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
BEGIN;
SELECT name FROM sqlite_temp_master;
INSERT INTO t2 SELECT * FROM t1;
SELECT name FROM temp.sqlite_master;
SELECT name FROM sqlite_temp_master;
SELECT name FROM temp.sqlite_master;
CREATE TABLE t2(a,b,c);
