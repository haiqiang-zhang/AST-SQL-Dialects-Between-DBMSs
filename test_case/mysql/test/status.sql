select * from performance_schema.session_status where variable_name like 'Table_lock%';
drop table if exists t1;
create table t1(n int);
insert into t1 values(1);
select get_lock('mysqltest_lock', 100);
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;
select 1;
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
select * from t1 where a=6;
select 1;
drop table t1;
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2);
SELECT a FROM t1 LIMIT 1;
SELECT a FROM t1 UNION SELECT a FROM t1 ORDER BY a;
SELECT a IN (SELECT a FROM t1) FROM t1 LIMIT 1;
SELECT (SELECT a FROM t1 LIMIT 1) x FROM t1 LIMIT 1;
SELECT * FROM t1 a, t1 b ORDER BY a.a, b.a LIMIT 1;
DROP TABLE t1;
create database db37908;
create table db37908.t1(f1 int);
drop database db37908;
SELECT COUNT(*) = 0
  FROM information_schema.processlist
  WHERE  id in ('$root_connection_id','$user1_connection_id');
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
select * from t1;
select * from t1;
select * from t2;
select * from t2;
select * from t1 as a, t2 as b, t1 as c, t2 as d, t1 as e, t2 as f;
select * from t1;
select * from t1 as a, t2 as b, t1 as c, t2 as d, t1 as e, t2 as f;
select * from t3;
drop tables t1, t2, t3;
CREATE TABLE t1(x INT, y INT);
INSERT INTO t1 VALUES (1, 2), (3, 4), (5, 6);
SELECT * FROM t1 WHERE y > 0;
SELECT * FROM t1 WHERE y > 0;
SELECT * FROM t1 WHERE x > 0
        UNION ALL
        SELECT * FROM t1 WHERE y > 0;
SELECT * FROM t1 WHERE x > 0
        UNION DISTINCT
        SELECT * FROM t1 WHERE y > 0;
DROP TABLE t1;
CREATE TABLE t1 (pk INTEGER PRIMARY KEY,
                 i1 INTEGER,
                 i2 INTEGER NOT NULL,
                 INDEX k1 (i1),
                 INDEX k2 (i1, i2));
INSERT INTO t1 VALUES
  (1, NULL, 43), (11, NULL, 103), (10, 32,50), (9, 12, 43),
  (8, NULL, 13), (7, 48, 90), (6, 56, 90), (5, 87, 84),
  (4, 58, 98), (3, 30, 82), (2, 54, 57), (12, 232, 43),
  (13, 43, 103), (14, 32, 45), (15, 12, 43), (16, 89, 23),
  (17, 48, 90), (18, 56, 90), (19, 87, 84);
CREATE TABLE t2 (pk INTEGER PRIMARY KEY,
                 i1 INTEGER NOT NULL,
                 INDEX k1 (i1));
INSERT INTO t2 VALUES
  (3, 89), (4, 98), (5, 84), (6, 8), (7, 99), (8, 110),
  (9, 84), (10, 98), (11, 103), (12, 50), (13, 84),
  (14, 57), (15, 82), (16, 103), (2, 98), (1, 90);
DROP TABLE t1, t2;
