
-- Store the time of password_last_changed column from mysql.user table
-- to restore it back later for the different users.
--disable_query_log
create temporary table user_copy as select * from mysql.user;


SET NAMES binary;

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;

--
-- GRANT tests that require several connections
-- (usually it's GRANT, reconnect as another user, try something)
--


-- prepare playground before tests
--disable_warnings
drop database if exists mysqltest;
drop database if exists mysqltest_1;
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

create user mysqltest_1@localhost, mysqltest_3@localhost, mysqltest_4@localhost;
create user mysqltest_2@localhost;
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

--
-- wild_compare fun
--

create user mysqltest_1@localhost, mysqltest_2@localhost,
            mysqltest_3@localhost, mysqltest_4@localhost;
select current_user();
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';

--
-- wild_compare part two - acl_cache
--
create database mysqltest_1;
create user mysqltest_1@localhost;
select current_user();
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
drop database mysqltest_1;

--
-- Bug#6173 One can circumvent missing UPDATE privilege if he has SELECT and
--          INSERT privilege for table with primary key
--
create database mysqltest;
create user mysqltest_1@localhost;
use mysqltest;
create table t1 (id int primary key, data varchar(255));
insert into t1 values (1, 'I can''t change it!');
update t1 set data='I can change it!' where id = 1;
insert into t1 values (1, 'XXX') on duplicate key update data= 'I can change it!';
select * from t1;
drop table t1;
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
create table t1 (a int, b int);
create user  mysqltest_1@localhost;
drop table t1;
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

drop database mysqltest;
use test;


--
-- Bug#15775 "drop user" command does not refresh acl_check_hosts
--

-- Create some test users
create user mysqltest_1@host1;
create user mysqltest_2@host2;
create user mysqltest_3@host3;
create user mysqltest_4@host4;
create user mysqltest_5@host5;
create user mysqltest_6@host6;
create user mysqltest_7@host7;

-- Drop one user
drop user mysqltest_3@host3;

-- This connect failed before fix since the acl_check_hosts list was corrupted by the "drop user"
connect (con8,127.0.0.1,root,,test,$MASTER_MYPORT,);

-- Clean up - Drop all of the remaining users at once
drop user mysqltest_1@host1, mysqltest_2@host2, mysqltest_4@host4,
  mysqltest_5@host5, mysqltest_6@host6, mysqltest_7@host7;

-- Check that it's still possible to connect
connect (con9,127.0.0.1,root,,test,$MASTER_MYPORT,);

--
-- Bug#16180 Setting SQL_LOG_OFF without SUPER privilege is silently ignored
--
create database mysqltest_1;
create user mysqltest_1@localhost;
set sql_log_off = 1;
set sql_log_bin = 0;
delete from mysql.user where user like 'mysqltest\_1';
delete from mysql.db where user like 'mysqltest\_1';
drop database mysqltest_1;

-- End of 4.1 tests
-- Create and drop user
--
set sql_mode='ANSI';
drop table if exists t1, t2;
create table t1(c1 int);
create table t2(c1 int, c2 int);
create user 'mysqltest_1';
create user 'mysqltest_1';
create user 'mysqltest_2' identified by 'Mysqltest-2';
create user 'mysqltest_3' identified with 'caching_sha2_password' as 'fffffffffffffffffffffffffffffffffffffffff';
select host,user,length(authentication_string) from mysql.user where user like 'mysqltest_%' order by host,user,authentication_string;
select host,db,user from mysql.db where user like 'mysqltest_%' order by host,db,user;
select host,db,user,table_name from mysql.tables_priv where user like 'mysqltest_%' order by host,db,user,table_name;
select host,db,user,table_name,column_name from mysql.columns_priv where user like 'mysqltest_%' order by host,db,user,table_name,column_name;
drop user 'mysqltest_1';
select host,user,length(authentication_string) from mysql.user where user like 'mysqltest_%' order by host,user,authentication_string;
select host,db,user from mysql.db where user like 'mysqltest_%' order by host,db,user;
select host,db,user,table_name from mysql.tables_priv where user like 'mysqltest_%' order by host,db,user,table_name;
select host,db,user,table_name,column_name from mysql.columns_priv where user like 'mysqltest_%' order by host,db,user,table_name,column_name;
select host,user,length(authentication_string) from mysql.user where user like 'mysqltest_%' order by host,user,authentication_string;
select host,db,user from mysql.db where user like 'mysqltest_%' order by host,db,user;
select host,db,user,table_name from mysql.tables_priv where user like 'mysqltest_%' order by host,db,user,table_name;
select host,db,user,table_name,column_name from mysql.columns_priv where user like 'mysqltest_%' order by host,db,user,table_name,column_name;
drop user 'mysqltest_1';
drop user 'mysqltest_1';
drop table t1, t2;
insert into mysql.db set user='mysqltest_1', db='%', host='%';
drop user 'mysqltest_1';
select host,db,user from mysql.db where user = 'mysqltest_1' order by host,db,user;
insert into mysql.tables_priv set host='%', db='test', user='mysqltest_1', table_name='t1';
drop user 'mysqltest_1';
select host,db,user,table_name from mysql.tables_priv where user = 'mysqltest_1' order by host,db,user,table_name;
insert into mysql.columns_priv set host='%', db='test', user='mysqltest_1', table_name='t1', column_name='c1';
drop user 'mysqltest_1';
select host,db,user,table_name,column_name from mysql.columns_priv where user = 'mysqltest_1' order by host,db,user,table_name,column_name;
create user 'mysqltest_1', 'mysqltest_2', 'mysqltest_3';
drop user 'mysqltest_1', 'mysqltest_2', 'mysqltest_3';
create user 'mysqltest_1', 'mysqltest_2' identified by 'Mysqltest-2', 'mysqltest_3' identified by 'haha';
drop user 'mysqltest_1', 'mysqltest_2', 'mysqltest_3';
drop user 'mysqltest_1a', 'mysqltest_2a', 'mysqltest_3a';
create user 'mysqltest_1', 'mysqltest_2', 'mysqltest_3';
create user 'mysqltest_1a', 'mysqltest_2', 'mysqltest_3a';
create user 'mysqltest_1a', 'mysqltest_3a';
drop user 'mysqltest_1', 'mysqltest_2', 'mysqltest_3';
drop user 'mysqltest_1b', 'mysqltest_2b', 'mysqltest_3b';
drop user 'mysqltest_1a', 'mysqltest_3a';
create user 'mysqltest_2' identified by 'Mysqltest-2';
drop user 'mysqltest_2' identified by 'Mysqltest-2';
drop user 'mysqltest_2';
create user '%@b'@'b';
drop user '%@a'@'a';
create user mysqltest_2@localhost;
select host,user,length(authentication_string) from mysql.user where user like 'mysqltest_%' order by host,user,authentication_string;
create user mysqltest_A@'%';
drop user mysqltest_B@'%';
drop user mysqltest_2@localhost;
create user mysqltest_3@localhost;
select host,user,length(authentication_string) from mysql.user where user like 'mysqltest_%' order by host,user,authentication_string;
insert ignore into mysql.user set host='%', user='mysqltest_B';
create user mysqltest_A@'%';
drop user mysqltest_C@'%';
drop user mysqltest_A@'%';
drop user mysqltest_3@localhost;
set @@sql_mode='';
create user mysqltest_1@'127.0.0.0/255.0.0.0';
create database mysqltest_1;
create table mysqltest_1.t1 (i int);
insert into mysqltest_1.t1 values (1),(2),(3);
select * from t1;
delete from mysql.user where user like 'mysqltest\_1';
drop table mysqltest_1.t1;

--
-- Bug#12302 Hostname resolution preventing password changes
-- 'SET PASSWORD = ...' didn't work if connecting hostname !=
-- hostname the current user is authenticated as. Note that a test for this
-- was also added to the test above.
--
create user mysqltest_1@'127.0.0.1';
select current_user();
set password = 'changed';
select host, length(authentication_string) from mysql.user where user like 'mysqltest\_1';
delete from mysql.user where user like 'mysqltest\_1';
create user mysqltest_1@'127.0.0.0/255.0.0.0';
select current_user();
set password = 'changed';
select host, length(authentication_string) from mysql.user where user like 'mysqltest\_1';
delete from mysql.user where user like 'mysqltest\_1';
drop database mysqltest_1;

-- But anonymous users can't change their password
connect (n5,localhost,test,,test,$MASTER_MYPORT,$MASTER_MYSOCK);
set password = "changed";


-- Bug#12423 "Deadlock when doing FLUSH PRIVILEGES and GRANT in
-- multi-threaded environment". We should be able to execute FLUSH
-- PRIVILEGES and SET PASSWORD simultaneously with other account
-- management commands (such as GRANT and REVOKE) without causing
-- deadlocks. To achieve this we should ensure that all account
-- management commands take table and internal locks in the same order.
connect (con2root,localhost,root,,);
create user 'mysqltest_1'@'localhost';
drop user 'mysqltest_1'@'localhost';

-- End of 4.1 tests

--
-- Bug#17279 user with no global privs and with create
--           priv in db can create databases
--

create database TESTDB;
create table t2(a int);
create temporary table t1 as select * from mysql.user;
delete from mysql.user where host='localhost';
INSERT INTO mysql.user (host, user) VALUES
('%','mysqltest_1');
INSERT INTO mysql.db (host, db, user, select_priv) VALUES
('%','TESTDB','mysqltest_1','Y');

-- The user mysqltest_1 should only be allowed access to
-- database TESTDB, not TEStdb
-- On system with "lowercase names" we get error "ER_DB_CREATE_EXISTS: Can't create db..."
--error ER_DBACCESS_DENIED_ERROR, ER_DB_CREATE_EXISTS
create database TEStdb;

-- Clean-up
connection default;
delete from mysql.user;
delete from mysql.db where host='%' and user='mysqltest_1' and db='TESTDB';
insert into mysql.user select * from t1;
drop table t1, t2;
drop database TESTDB;

--
-- Bug#13310 incorrect user parsing by SP
--

SET @old_log_bin_trust_function_creators= @@global.log_bin_trust_function_creators;
SET GLOBAL log_bin_trust_function_creators = 1;

CREATE USER `a@`@localhost;
CREATE TABLE t2 (s1 INT);
INSERT INTO t2 VALUES (1);
DROP FUNCTION IF EXISTS f2;
CREATE FUNCTION f2 () RETURNS INT
BEGIN DECLARE v INT;
SELECT f2();

DROP FUNCTION f2;
DROP TABLE t2;
DROP USER `a@`@localhost;

SET @@global.log_bin_trust_function_creators= @old_log_bin_trust_function_creators;


--
-- Bug#25578 CREATE TABLE LIKE does not require any privileges on source table
--
--disable_warnings
drop database if exists mysqltest_1;
drop database if exists mysqltest_2;
drop user mysqltest_u1@localhost;

create database mysqltest_1;
create database mysqltest_2;
create user mysqltest_u1@localhost;
use mysqltest_2;
create table t1 (i int);

-- Connect as user with all rights on mysqltest_1 but with no rights on mysqltest_2.
connect (user1,localhost,mysqltest_u1,,mysqltest_1);
create table t1 like mysqltest_2.t1;

-- Now let us check that SELECT privilege on the source is enough
connection default;
create table t1 like mysqltest_2.t1;

-- Clean-up
connection default;
use test;
drop database mysqltest_1;
drop database mysqltest_2;
drop user mysqltest_u1@localhost;


--
-- Bug#18660 Can't grant any privileges on single table in database
--           with underscore char
--
create user mysqltest_1@localhost, mysqltest_2@localhost;

create database mysqltest_1;
use mysqltest_1;
create table t1 (f1 int);
create database mysqltest_3;
use mysqltest_1;
create table t2(f1 int);
select * from t1;
drop database mysqltest_1;
drop user mysqltest_1@localhost;
drop user mysqltest_2@localhost;


--
-- Bug#30468 column level privileges not respected when joining tables
--
CREATE DATABASE db1;

USE db1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(2,2);

CREATE TABLE t2 (b INT, c INT);
INSERT INTO t2 VALUES (1,100),(2,200);

CREATE USER mysqltest1@localhost;
USE db1;
SELECT c FROM t2;
SELECT * FROM t2;
SELECT * FROM t1 JOIN t2 USING (b);
USE test;
DROP TABLE db1.t1, db1.t2;
DROP USER mysqltest1@localhost;
DROP DATABASE db1;

--
-- Bug #48319: Server crashes on "GRANT/REVOKE ... TO CURRENT_USER"
--

-- work out who we are.
USE mysql;
SELECT LEFT(CURRENT_USER(),INSTR(CURRENT_USER(),'@')-1) INTO @u;
SELECT MID(CURRENT_USER(),INSTR(CURRENT_USER(),'@')+1)  INTO @h;
SELECT authentication_string FROM user WHERE user=@u AND host=@h INTO @pwd;

-- show current privs.
SELECT user,host,length(authentication_string),insert_priv FROM user WHERE user=@u AND host=@h;

-- toggle INSERT
UPDATE user SET insert_priv='N' WHERE user=@u AND host=@h;
SELECT user,host,length(authentication_string),insert_priv FROM user WHERE user=@u AND host=@h;

-- show that GRANT ... TO CURRENT_USER() no longer crashes
GRANT INSERT ON *.* TO CURRENT_USER();
SELECT user,host,length(authentication_string),insert_priv FROM user WHERE user=@u AND host=@h;
UPDATE user SET insert_priv='N' WHERE user=@u AND host=@h;

UPDATE user SET authentication_string=@pwd WHERE user=@u AND host=@h;
SELECT user,host,length(authentication_string),insert_priv FROM user WHERE user=@u AND host=@h;

USE test;
DROP DATABASE IF EXISTS mysqltest_db1;
DROP DATABASE IF EXISTS mysqltest_db2;

CREATE DATABASE mysqltest_db1;
CREATE DATABASE mysqltest_db2;
CREATE USER mysqltest_u1@localhost, mysqltest_u2@localhost,
            mysqltest_u3@localhost, mysqltest_u4@localhost,
            mysqltest_u5@localhost;
CREATE PROCEDURE mysqltest_db1.p0(i INT) SELECT i;
CREATE DEFINER = mysqltest_u3@localhost PROCEDURE mysqltest_db1.p1()
  CREATE TEMPORARY TABLE t4(x INT);

CREATE DEFINER = mysqltest_u3@localhost PROCEDURE mysqltest_db1.p2()
  INSERT INTO t4 VALUES (1), (2), (3);

CREATE DEFINER = mysqltest_u3@localhost PROCEDURE mysqltest_db1.p3()
  SELECT * FROM t4 ORDER BY x;
SET GLOBAL keycache1.key_buffer_size = 128 * 1024;

CREATE TABLE mysqltest_db2.t2_1(a INT);
CREATE TEMPORARY TABLE t1(a INT) engine=myisam;
CREATE TEMPORARY TABLE t2 LIKE t1;
CREATE TEMPORARY TABLE t3(a INT, b INT, PRIMARY KEY (a)) engine=myisam;
CREATE TEMPORARY TABLE t4 SELECT * FROM t1;
CREATE TEMPORARY TABLE t5(a INT) ENGINE = MyISAM;
CREATE TEMPORARY TABLE t6(a INT) ENGINE = MERGE UNION = (t5);
CREATE TEMPORARY TABLE t6(a INT) ENGINE = MERGE UNION = ();
INSERT INTO t1 VALUES (1), (2), (3);
SELECT * FROM t1 ORDER BY a;
CREATE INDEX idx1 ON t3(b);
DROP INDEX idx1 ON t3;
ALTER TABLE t4 ADD COLUMN b INT;
ALTER TABLE t6 UNION = ();
ALTER TABLE t6 UNION = (t5);
INSERT INTO t1 VALUES (4);
INSERT INTO t2 SELECT a FROM t1;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
UPDATE t1 SET a = a * 10;
UPDATE t1 SET a = 100 WHERE a = 10;
UPDATE t1, t2 SET t1.a = 200 WHERE t1.a = t2.a * 10 AND t1.a = 20;
SELECT * FROM t1 ORDER BY a;
DELETE FROM t1 WHERE a = 100;
DELETE t1 FROM t1, t2 WHERE t1.a = t2.a * 100 AND t1.a = 200;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 ORDER BY a;
INSERT INTO t1 VALUES (1), (2), (3);
SELECT * FROM t1 ORDER BY a;
SET @a := (SELECT COUNT(*) FROM t1);
SELECT @a;
INSERT INTO t3 VALUES (1, 111), (2, 222), (3, 333);
SELECT * FROM t2 ORDER BY a;
SELECT * FROM t3 ORDER BY a;
DELETE FROM t1;
DROP TABLE t1;

CREATE TEMPORARY TABLE t1(a INT);
DROP TEMPORARY TABLE t1;
CREATE TEMPORARY TABLE t2(a INT);
INSERT INTO t4 VALUES (4);
UPDATE t4 SET x = 10 WHERE x = 1;
DELETE FROM t4 WHERE x < 3;
SELECT * FROM t4 ORDER BY x;
DROP TEMPORARY TABLE t4;
INSERT INTO t4 VALUES (4);
UPDATE t4 SET x = 10 WHERE x = 1;
DELETE FROM t4 WHERE x < 3;
SELECT * FROM t4 ORDER BY x;
DROP TEMPORARY TABLE t4;

CREATE TEMPORARY TABLE t7(a INT) engine=myisam;
CREATE TEMPORARY TABLE t8(a INT) engine=myisam;
CREATE TEMPORARY TABLE t9(a INT) engine=myisam;
CREATE TEMPORARY TABLE t10(a INT) ENGINE = MERGE UNION = (t7, t8);

ALTER TABLE t10 UNION = (t9);
ALTER TABLE t10 UNION = (mysqltest_db2.t2_1);

CREATE TEMPORARY TABLE mysqltest_db2.t2_2(a INT) ENGINE = MERGE UNION = (t7, t8);

ALTER TABLE mysqltest_db2.t2_2 UNION = (t9);
ALTER TABLE mysqltest_db2.t2_2 UNION = ();

DROP TEMPORARY TABLE mysqltest_db2.t2_2;
DROP TEMPORARY TABLE t10;

DROP TEMPORARY TABLE t7;
DROP TEMPORARY TABLE t8;
DROP TEMPORARY TABLE t9;

SET GLOBAL keycache1.key_buffer_size = 0;
DROP DATABASE mysqltest_db1;
DROP DATABASE mysqltest_db2;
DROP USER mysqltest_u1@localhost;
DROP USER mysqltest_u2@localhost;
DROP USER mysqltest_u3@localhost;
DROP USER mysqltest_u4@localhost;
DROP USER mysqltest_u5@localhost;

set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;
delete from mysql.user;
insert into mysql.user select * from user_copy;
SET GLOBAL partial_revokes = @orig_partial_revokes;
