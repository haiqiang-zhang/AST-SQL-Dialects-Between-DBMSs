
CREATE DATABASE wl6797;
USE wl6797;
CREATE TABLE t1 (a int);
SELECT * FROM t1 ORDER BY 1;

CREATE TEMPORARY TABLE temp1(a int);
INSERT INTO temp1 VALUES (1),(2),(3),(4);
SELECT * FROM temp1 ORDER BY 1;
SELECT * FROM temp1 ORDER BY 1;

set @a:=1;
SELECT @a;
SELECT @a;

-- set variables to default
--reset_connection
SHOW SESSION VARIABLES like 'autocommit';
set autocommit=0;
set transaction_isolation='SERIALIZABLE';
set names 'big5';
set max_join_size=100;
set max_join_size=1000;
set max_join_size=100;

-- since table_open_cache_hits return different value
-- with/without ps_protocol, hence disabling the below testcase

--disable_ps_protocol

FLUSH TABLES;
CREATE TABLE newt( a int );
INSERT INTO newt VALUES (1),(2);
SELECT * FROM newt ORDER BY 1;
DELETE FROM newt;
DROP TABLE newt;
SELECT * FROM t1 ORDER BY 1;
SET GLOBAL DEBUG='d,debug_test_cleanup_connection';
SET GLOBAL DEBUG='';

CREATE TABLE t2(a int not null auto_increment, key(a));
INSERT INTO t2 VALUES (NULL);
INSERT INTO t2 VALUES (NULL);
INSERT INTO t2 VALUES (NULL), (NULL);
DROP TABLE t2;

-- test for @@insert_id
CREATE TABLE t2(a int not null auto_increment, key(a));
SET INSERT_ID=12;
INSERT INTO t2 VALUES (NULL);
SELECT * FROM t2;
DROP TABLE t2;
CREATE TABLE t2(a int not null auto_increment, key(a));
SET INSERT_ID=12;
INSERT INTO t2 VALUES (NULL);
SELECT * FROM t2;
DROP TABLE t2;

DROP TABLE IF EXISTS t1;
DROP DATABASE wl6797;

create user 'user_wl6797'@'localhost';
ALTER USER user_wl6797@localhost PASSWORD EXPIRE;
DROP USER user_wl6797@localhost;

SET TIMESTAMP=200;
SELECT @@TIMESTAMP;
SELECT @@TIMESTAMP=200;

CREATE DATABASE T18329560;
USE T18329560;
CREATE TABLE T(a DOUBLE);
SET SESSION RAND_SEED1=1;
SET SESSION RAND_SEED2=1;
INSERT INTO T VALUES(rand());
SET SESSION RAND_SEED1=1;
SET SESSION RAND_SEED2=1;
SELECT IF(a=rand(),'1','0') FROM T;
DROP TABLE T;
DROP DATABASE T18329560;

SET SESSION SORT_BUFFER_SIZE= 1;

SET PROFILING=1;
SELECT 1;
SELECT 2;
