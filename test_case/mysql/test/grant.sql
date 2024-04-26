let $date_to_restore_root=`SELECT password_last_changed from mysql.user where user='root'`;
let $date_to_restore_sys=`SELECT password_last_changed from mysql.user where user='mysql.sys'`;
let $date_to_restore_session_user=`SELECT password_last_changed from mysql.user where user='mysql.session'`;
let $date_to_restore_inf_schema_user=`SELECT password_last_changed from mysql.user where user='mysql.infoschema'`;

-- Test of GRANT commands

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

SET @old_log_bin_trust_function_creators= @@global.log_bin_trust_function_creators;
SET GLOBAL log_bin_trust_function_creators = 1;

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
SET NAMES binary;
create user mysqltest_1@localhost;
drop user  mysqltest_1@localhost;
create user mysqltest_1@localhost;
delete from mysql.user where user='mysqltest_1';
delete from mysql.db where user='mysqltest_1';
delete from mysql.tables_priv where user='mysqltest_1';
delete from mysql.columns_priv where user='mysqltest_1';

--
-- Test what happens when you have same table and colum level grants
--

create user mysqltest_1@localhost;
create table t1 (a int);
select table_priv,column_priv from mysql.tables_priv where user="mysqltest_1";
select table_priv,column_priv from mysql.tables_priv where user="mysqltest_1";
create user mysqltest_2@localhost, mysqltest_3@localhost;
delete from mysql.user where user='mysqltest_1' or user="mysqltest_2" or user="mysqltest_3";
delete from mysql.db where user='mysqltest_1' or user="mysqltest_2" or user="mysqltest_3";
delete from mysql.tables_priv where user='mysqltest_1' or user="mysqltest_2" or user="mysqltest_3";
delete from mysql.columns_priv where user='mysqltest_1' or user="mysqltest_2" or user="mysqltest_3";
drop table t1;

--
-- Test grants on long column names (causes std::string to allocate memory)
--
create user mysqltest_1@localhost;
create table t1 (abcdefghijklmnopqrstuvwxyz int);
select table_priv,column_priv from mysql.tables_priv where user="mysqltest_1";
drop table t1;

--
-- Test some error conditions
--
--error ER_WRONG_USAGE
GRANT FILE on mysqltest.*  to mysqltest_1@localhost;
select 1;
drop user mysqltest_1@localhost;

--
-- Bug#4898 User privileges depending on ORDER BY Settings of table db
--
insert ignore into mysql.user (host, user) values ('localhost', 'test11');
insert into mysql.db (host, db, user, select_priv) values
('localhost', 'a%', 'test11', 'Y'), ('localhost', 'ab%', 'test11', 'Y');
alter table mysql.db order by db asc;
alter table mysql.db order by db desc;
delete from mysql.user where user='test11';
delete from mysql.db where user='test11';

--
-- Bug#6123 GRANT USAGE inserts useless Db row
--
create user test6123 identified by 'magic123';
create database mysqltest1;
select host,db,user,select_priv,insert_priv from mysql.db where db="mysqltest1";
delete from mysql.user where user='test6123';
drop database mysqltest1;

--
-- Test for 'drop user', 'revoke privileges, grant'
--

create user drop_user@localhost, drop_user2@localhost;
create table t1 (a int);

--
-- Bug#3086 SHOW GRANTS doesn't follow ANSI_QUOTES
--
set sql_mode=ansi_quotes;
set sql_mode=default;

set sql_quote_show_create=0;
set sql_mode="ansi_quotes";
set sql_quote_show_create=1;
set sql_mode="";
drop user drop_user@localhost;

create user drop_user1@localhost, drop_user3@localhost, drop_user4@localhost;
drop user drop_user1@localhost, drop_user2@localhost, drop_user3@localhost,
drop_user4@localhost;
drop user drop_user1@localhost, drop_user2@localhost, drop_user3@localhost,
drop_user4@localhost;
drop table t1;
create user mysqltest_1@localhost identified by "password";
drop user mysqltest_1@localhost;

--
-- Bug#3403 Wrong encoding in SHOW GRANTS output
--
SET NAMES koi8r;
CREATE DATABASE ��;
USE ��;
CREATE TABLE ��� (��� INT);

CREATE USER ����@localhost;

-- Revoke does not drop user. Leave a clean user table for the next tests.
DROP USER ����@localhost;

DROP DATABASE ��;
SET NAMES latin1;

--
-- Bug#5831 REVOKE ALL PRIVILEGES, GRANT OPTION does not revoke everything
--
USE test;
create user testuser@localhost;
CREATE TABLE t1 (a int );
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
CREATE TABLE t4 LIKE t1;
CREATE TABLE t5 LIKE t1;
CREATE TABLE t6 LIKE t1;
CREATE TABLE t7 LIKE t1;
CREATE TABLE t8 LIKE t1;
CREATE TABLE t9 LIKE t1;
CREATE TABLE t10 LIKE t1;
CREATE DATABASE testdb1;
CREATE DATABASE testdb2;
CREATE DATABASE testdb3;
CREATE DATABASE testdb4;
CREATE DATABASE testdb5;
CREATE DATABASE testdb6;
CREATE DATABASE testdb7;
CREATE DATABASE testdb8;
CREATE DATABASE testdb9;
CREATE DATABASE testdb10;
DROP USER testuser@localhost;
DROP TABLE t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;
DROP DATABASE testdb1;
DROP DATABASE testdb2;
DROP DATABASE testdb3;
DROP DATABASE testdb4;
DROP DATABASE testdb5;
DROP DATABASE testdb6;
DROP DATABASE testdb7;
DROP DATABASE testdb8;
DROP DATABASE testdb9;
DROP DATABASE testdb10;

--
-- Bug#6932 a problem with 'revoke ALL PRIVILEGES'
--

create table t1(a int, b int, c int, d int);
create user grant_user@localhost;
select Host,Db,User,Table_name,Column_name,Column_priv from mysql.columns_priv order by Column_name;
select Host,Db,User,Table_name,Column_name,Column_priv from mysql.columns_priv;
drop user grant_user@localhost;
drop table t1;

--
-- Bug#7391 Cross-database multi-table UPDATE security problem
--
create database mysqltest_1;
create database mysqltest_2;
create table mysqltest_1.t1 select 1 a, 2 q;
create table mysqltest_1.t2 select 1 b, 2 r;
create table mysqltest_2.t1 select 1 c, 2 s;
create table mysqltest_2.t2 select 1 d, 2 t;

-- test the column privileges
create user mysqltest_3@localhost;
SELECT * FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_NAME,COLUMN_NAME,PRIVILEGE_TYPE;
SELECT * FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_NAME,PRIVILEGE_TYPE;
SELECT * from INFORMATION_SCHEMA.SCHEMA_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_SCHEMA,PRIVILEGE_TYPE;
SELECT * from INFORMATION_SCHEMA.USER_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_CATALOG,PRIVILEGE_TYPE;
update mysqltest_1.t1, mysqltest_1.t2 set q=10 where b=1;
update mysqltest_1.t2, mysqltest_2.t2 set d=20 where d=1;
update mysqltest_1.t1, mysqltest_2.t2 set d=20 where d=1;
update mysqltest_2.t1, mysqltest_1.t2 set c=20 where b=1;
update mysqltest_2.t1, mysqltest_2.t2 set d=10 where s=2;
update mysqltest_1.t1, mysqltest_2.t2 set a=10,d=10;
update mysqltest_1.t1, mysqltest_2.t1 set a=20 where c=20;
select t1.*,t2.* from mysqltest_1.t1,mysqltest_1.t2;
select t1.*,t2.* from mysqltest_2.t1,mysqltest_2.t2;

-- test the db/table level privileges
grant all on mysqltest_2.* to mysqltest_3@localhost;
use mysqltest_1;
update mysqltest_2.t1, mysqltest_2.t2 set c=500,d=600;
update mysqltest_1.t1, mysqltest_1.t2 set a=100,b=200;
use mysqltest_2;
update mysqltest_1.t1, mysqltest_1.t2 set a=100,b=200;
update mysqltest_2.t1, mysqltest_1.t2 set c=100,b=200;
update mysqltest_1.t1, mysqltest_2.t2 set a=100,d=200;
select t1.*,t2.* from mysqltest_1.t1,mysqltest_1.t2;
select t1.*,t2.* from mysqltest_2.t1,mysqltest_2.t2;

delete from mysql.user where user='mysqltest_3';
delete from mysql.db where user="mysqltest_3";
delete from mysql.tables_priv where user="mysqltest_3";
delete from mysql.columns_priv where user="mysqltest_3";
delete from mysql.global_grants where user="mysqltest_3";
drop database mysqltest_1;
drop database mysqltest_2;

--
-- just SHOW PRIVILEGES test
--
--sorted_result
SHOW PRIVILEGES;

--
-- Rights for renaming test (Bug#3270)
--
connect (root,localhost,root,,test,$MASTER_MYPORT,$MASTER_MYSOCK);
create database mysqltest;
create table mysqltest.t1 (a int,b int,c int);
create user mysqltest_1@localhost;
alter table t1 rename t2;
delete from mysql.user where user=_binary'mysqltest_1';
drop database mysqltest;

--
-- check all new table privileges
--
CREATE USER dummy@localhost;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
CREATE VIEW mysqltest.dummyview AS SELECT dummyfield FROM mysqltest.dummytable;
use INFORMATION_SCHEMA;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
use test;
DROP USER dummy@localhost;
DROP DATABASE mysqltest;
CREATE USER dummy@localhost;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
CREATE VIEW mysqltest.dummyview AS SELECT dummyfield FROM mysqltest.dummytable;
use INFORMATION_SCHEMA;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
use test;
DROP USER dummy@localhost;
DROP DATABASE mysqltest;
CREATE USER dummy@localhost;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
CREATE VIEW mysqltest.dummyview AS SELECT dummyfield FROM mysqltest.dummytable;
use INFORMATION_SCHEMA;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
SELECT TABLE_SCHEMA, TABLE_NAME, GROUP_CONCAT(PRIVILEGE_TYPE ORDER BY
PRIVILEGE_TYPE SEPARATOR ', ') AS PRIVILEGES FROM TABLE_PRIVILEGES WHERE GRANTEE
= '\'dummy\'@\'localhost\'' GROUP BY TABLE_SCHEMA, TABLE_NAME;
use test;
DROP USER dummy@localhost;
DROP DATABASE mysqltest;
use mysql;
insert into tables_priv values ('','test_db','mysqltest_1','test_table','test_grantor',CURRENT_TIMESTAMP,'Select','Select');
delete from tables_priv where host = '' and user = 'mysqltest_1';
use test;

--
-- Bug#10892 user variables not auto cast for comparisons
-- Check that we don't get illegal mix of collations
--
set @user123="non-existent";
select * from mysql.db where user=@user123;

set names koi8r;
create database ��;
select hex(Db) from mysql.db where Db='��';
drop database ��;
set names latin1;

--
-- Bug#15598 Server crashes in specific case during setting new password
-- - Caused by a user with host ''
--
create user mysqltest_7@;
alter user mysqltest_7@ identified by 'systpass';
drop user mysqltest_7@;

--
-- Bug#14385 GRANT and mapping to correct user account problems
--
create database mysqltest;
use mysqltest;
create table t1(f1 int);
CREATE USER mysqltest1@'%', mysqltest1@'192.%';
delete from mysql.user where user='mysqltest1';
delete from mysql.db where user='mysqltest1';
delete from mysql.tables_priv where user='mysqltest1';
drop database mysqltest;

--
-- Bug#27515 DROP previlege is not required for RENAME TABLE
--
connection master;
create database db27515;
use db27515;
create table t1 (a int);
create user user27515@localhost;
drop user user27515@localhost;
drop database db27515;

--
-- Bug#16297 In memory grant tables not flushed when users's hostname is ""
--
use test;
create table t1 (a int);

-- Backup anonymous users and remove them. (They get in the way of
-- the one we test with here otherwise.)
create table t2 as select * from mysql.user where user='';
delete from mysql.user where user='';

-- Create some users with different hostnames
create user mysqltest_8@'';
create user mysqltest_8;
create user mysqltest_8@host8;

-- Try to create them again
--error ER_CANNOT_USER
create user mysqltest_8@'';
create user mysqltest_8;
create user mysqltest_8@host8;

select user, QUOTE(host) from mysql.user where user="mysqltest_8";
select * from  information_schema.schema_privileges
where grantee like "'mysqltest_8'%";
select * from t1;
select * from  information_schema.schema_privileges
where grantee like "'mysqltest_8'%";
select * from  information_schema.column_privileges;
select * from t1;
select * from  information_schema.column_privileges;
select * from  information_schema.table_privileges where table_schema NOT IN ('sys','mysql');
select * from t1;
select * from  information_schema.table_privileges where table_schema NOT IN ('sys','mysql');
select * from  information_schema.user_privileges
where grantee like "'mysqltest_8'%";
select * from t1;
drop user mysqltest_8@'';
select * from  information_schema.user_privileges
where grantee like "'mysqltest_8'%";
drop user mysqltest_8;
drop user mysqltest_8@host8;

-- Restore the anonymous users.
insert into mysql.user select * from t2;
drop table t2;
drop table t1;

--
-- Bug#20214 Incorrect error when user calls SHOW CREATE VIEW on non
--           privileged view
--

connection master;

CREATE DATABASE mysqltest3;
USE mysqltest3;

CREATE TABLE t_nn (c1 INT);
CREATE VIEW  v_nn AS SELECT * FROM t_nn;

CREATE DATABASE mysqltest2;
USE mysqltest2;

CREATE TABLE t_nn (c1 INT);
CREATE VIEW  v_nn AS SELECT * FROM t_nn;
CREATE VIEW  v_yn AS SELECT * FROM t_nn;
CREATE VIEW  v_gy AS SELECT * FROM t_nn;
CREATE VIEW  v_ny AS SELECT * FROM t_nn;
CREATE VIEW  v_yy AS SELECT * FROM t_nn WHERE c1=55;
CREATE USER 'mysqltest_1'@'localhost' IDENTIFIED BY 'mysqltest_1';

-- fail because of missing SHOW VIEW (have generic SELECT)
--error ER_TABLEACCESS_DENIED_ERROR
SHOW CREATE VIEW  mysqltest2.v_nn;

-- fail because of missing SHOW VIEW
--error ER_TABLEACCESS_DENIED_ERROR
SHOW CREATE VIEW  mysqltest2.v_yn;

-- succeed (despite of missing SELECT, having SHOW VIEW bails us out)
SHOW CREATE TABLE mysqltest2.v_ny;

-- succeed (despite of missing SELECT, having SHOW VIEW bails us out)
SHOW CREATE VIEW  mysqltest2.v_ny;

-- fail because of missing (specific or generic) SELECT
--error ER_TABLEACCESS_DENIED_ERROR
SHOW CREATE TABLE mysqltest3.t_nn;

-- fail because of missing (specific or generic) SELECT (not because it's not a view!)
--error ER_TABLEACCESS_DENIED_ERROR
SHOW CREATE VIEW  mysqltest3.t_nn;

-- fail because of missing missing (specific or generic) SELECT (and SHOW VIEW)
--error ER_TABLEACCESS_DENIED_ERROR
SHOW CREATE VIEW  mysqltest3.v_nn;

-- succeed thanks to generic SELECT
SHOW CREATE TABLE mysqltest2.t_nn;

-- fail because it's not a view!  (have generic SELECT though)
--error ER_WRONG_OBJECT
SHOW CREATE VIEW  mysqltest2.t_nn;

-- succeed, have SELECT and SHOW VIEW
SHOW CREATE VIEW mysqltest2.v_yy;

-- succeed, have SELECT and SHOW VIEW
SHOW CREATE TABLE mysqltest2.v_yy;

-- clean-up
connection master;

-- succeed, we're root
SHOW CREATE TABLE mysqltest2.v_nn;

-- fail because it's not a view!
--error ER_WRONG_OBJECT
SHOW CREATE VIEW mysqltest2.t_nn;

DROP VIEW  mysqltest2.v_nn;
DROP VIEW  mysqltest2.v_yn;
DROP VIEW  mysqltest2.v_ny;
DROP VIEW  mysqltest2.v_yy;
DROP TABLE mysqltest2.t_nn;
DROP DATABASE mysqltest2;
DROP VIEW  mysqltest3.v_nn;
DROP TABLE mysqltest3.t_nn;
DROP DATABASE mysqltest3;
DROP USER 'mysqltest_1'@'localhost';

-- restore the original database
USE test;


--
-- Bug#10668 CREATE USER does not enforce username length limit
--
--error ER_WRONG_STRING_LENGTH
create user mysqltest1_thisisreallyreallyreallyreallyreallyireallyreallytoolong;

--
-- Test for Bug#16899 Possible buffer overflow in handling of DEFINER-clause.
--
-- These checks are intended to ensure that appropriate errors are risen when
-- illegal user name or hostname is specified in user-clause of GRANT/REVOKE
-- statements.
--

--
-- Bug#22369 Alter table rename combined with other alterations causes lost tables
--
CREATE DATABASE mysqltest1;
CREATE TABLE mysqltest1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);
CREATE TABLE mysqltest1.t2 (int_field INT);
CREATE USER mysqltest_1@localhost;
SELECT USER();
ALTER TABLE t1 RENAME TO t2;
ALTER TABLE t1 RENAME TO t2;
ALTER TABLE t1 RENAME TO t2;
DROP TABLE mysqltest1.t2;
ALTER TABLE t1 RENAME TO t2;
ALTER TABLE t2 RENAME TO t1;
ALTER TABLE t1 RENAME TO t2;

DROP USER mysqltest_1@localhost;
DROP DATABASE mysqltest1;
USE test;

-- Working with database-level privileges.

--error ER_WRONG_STRING_LENGTH
GRANT CREATE ON mysqltest.* TO 1234567890abcdefGHIKL1234567890abcdefGHIKL@localhost;

-- Working with table-level privileges.

--error ER_WRONG_STRING_LENGTH
GRANT CREATE ON t1 TO 1234567890abcdefGHIKL1234567890abcdefGHIKL@localhost;

-- Working with routine-level privileges.

--error ER_WRONG_STRING_LENGTH
GRANT EXECUTE ON PROCEDURE p1 TO 1234567890abcdefGHIKL1234567890abcdefGHIKL@localhost;


--
-- Bug#23556 TRUNCATE TABLE still maps to DELETE
--
CREATE USER bug23556@localhost;
CREATE DATABASE bug23556;
USE bug23556;
CREATE TABLE t1 (a INT PRIMARY KEY);
USE bug23556;
USE bug23556;
USE bug23556;
USE bug23556;
DROP TABLE t1;
USE test;
DROP DATABASE bug23556;
DROP USER bug23556@localhost;


--
-- Bug#6774 Replication fails with Wrong usage of DB GRANT and GLOBAL PRIVILEGES
--
-- Check if GRANT ... ON * ... fails when no database is selected
connect (con1, localhost, root,,*NO-ONE*);


--
-- Bug#9504 Stored procedures: execute privilege doesn't make 'use database'
-- okay.
--

-- Prepare.

CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;
CREATE DATABASE mysqltest3;
CREATE DATABASE mysqltest4;

CREATE PROCEDURE mysqltest1.p_def() SQL SECURITY DEFINER
  SELECT 1;

CREATE PROCEDURE mysqltest2.p_inv() SQL SECURITY INVOKER
  SELECT 1;

CREATE FUNCTION mysqltest3.f_def() RETURNS INT SQL SECURITY DEFINER
  RETURN 1;

CREATE FUNCTION mysqltest4.f_inv() RETURNS INT SQL SECURITY INVOKER
  RETURN 1;

CREATE USER mysqltest_1@localhost;

-- Test.

--connect (bug9504_con1,localhost,mysqltest_1,,)
--echo
--echo ---> connection: bug9504_con1

-- - Check that we can switch to the db;

use mysqltest1;

use mysqltest2;

use mysqltest3;

use mysqltest4;

-- - Check that we can call stored routines;

use test;

SELECT mysqltest3.f_def();

SELECT mysqltest4.f_inv();

-- Cleanup.

--connection default
--echo
--echo ---> connection: default

--disconnect bug9504_con1

DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
DROP DATABASE mysqltest3;
DROP DATABASE mysqltest4;

DROP USER mysqltest_1@localhost;


--
-- Bug#27337 Privileges are not restored properly.
--
-- Actually, the patch for this bugs fixes two problems. So, here are two test
-- cases.

-- Test case 1: privileges are not restored properly after calling a stored
-- routine defined with SQL SECURITY INVOKER clause.

-- Prepare.

CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;

CREATE USER mysqltest_1@localhost;

CREATE PROCEDURE mysqltest1.p1() SQL SECURITY INVOKER
  SELECT 1;

-- Test.

--connect (bug27337_con1,localhost,mysqltest_1,,mysqltest2)
--echo
--echo ---> connection: bug27337_con1

--error ER_TABLEACCESS_DENIED_ERROR
CREATE TABLE t1(c INT);
CREATE TABLE t1(c INT);
CREATE TABLE t1(c INT);

-- Cleanup.

--connection default
--echo
--echo ---> connection: default

--disconnect bug27337_con2

DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;

DROP USER mysqltest_1@localhost;

-- Test case 2: privileges are not checked properly for prepared statements.

-- Prepare.

CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;

CREATE TABLE mysqltest1.t1(c INT);
CREATE TABLE mysqltest2.t2(c INT);

CREATE USER mysqltest_1@localhost, mysqltest_2@localhost;

-- Test.

--connect (bug27337_con1,localhost,mysqltest_1,,mysqltest1)
--echo
--echo ---> connection: bug27337_con1

SHOW TABLES FROM mysqltest1;

-- Cleanup.

--connection default
--echo
--echo ---> connection: default

--disconnect bug27337_con1
--disconnect bug27337_con2

DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;

DROP USER mysqltest_1@localhost;
DROP USER mysqltest_2@localhost;

--
-- Bug#27878 Unchecked privileges on a view referring to a table from another
--           database.
--
USE test;
CREATE TABLE t1 (f1 int, f2 int);
INSERT INTO t1 VALUES(1,1), (2,2);
CREATE DATABASE db27878;
CREATE USER 'mysqltest_1'@'localhost';
USE db27878;
CREATE SQL SECURITY INVOKER VIEW db27878.v1 AS SELECT * FROM test.t1;
USE db27878;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
UPDATE v1 SET f2 = 4;
SET sql_mode = default;
SELECT * FROM test.t1;
DROP USER mysqltest_1@localhost;
DROP DATABASE db27878;
USE test;
DROP TABLE t1;
CREATE TEMPORARY TABLE mysql.user (id INT);
DROP TABLE mysql.user;


--
-- Bug#33201 Crash occurs when granting update privilege on one column of a view
--
drop table if exists test;
drop function if exists test_function;
drop view if exists v1;
create table test (col1 varchar(30));
create function test_function() returns varchar(30)
begin
        declare tmp varchar(30);
        select col1 from test limit 1 into tmp;
        return '1';
create view v1 as select test.* from test where test.col1=test_function();
create user 'greg'@'localhost';
drop user 'greg'@'localhost';
drop view v1;
drop table test;
drop function test_function;

--
-- Bug#41456 SET PASSWORD hates CURRENT_USER()
--
SELECT CURRENT_USER();
SET PASSWORD FOR CURRENT_USER() = "admin";
SET PASSWORD FOR CURRENT_USER() = "";

--
-- Bug#57952: privilege change is not taken into account by EXECUTE.
--

--echo
--echo -- Bug#57952
--echo

CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;

use mysqltest1;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (1, 1);

CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES (2);

CREATE TABLE mysqltest2.t3(a INT);
INSERT INTO mysqltest2.t3 VALUES (4);

CREATE USER testuser@localhost;

CREATE PROCEDURE p1() SELECT b FROM t1;
CREATE PROCEDURE p2() SELECT a FROM t2;
CREATE PROCEDURE p3() SHOW TABLES FROM mysqltest2;
SELECT b FROM t1;
SELECT SUM(b) OVER () FROM t1;
SELECT a FROM t2;
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
DROP USER testuser@localhost;
use test;
create database mysqltest1;
create function mysqltest1.f1() returns int return 0;
create procedure mysqltest1.p1() begin end;
create user mysqluser1@localhost;
select db, routine_name, routine_type, proc_priv from mysql.procs_priv where user='mysqluser1' and host='localhost';
select mysqltest1.f1();
drop user mysqluser1@localhost;
select mysqltest1.f1();
create user mysqluser1@localhost;
select db, routine_name, routine_type, proc_priv from mysql.procs_priv where user='mysqluser1' and host='localhost';
select mysqltest1.f1();
create user mysqluser11@localhost;
create table mysqltest1.t11 (i int);
create table mysqltest1.t22 (i int);
select db, routine_name, routine_type, proc_priv from mysql.procs_priv where user='mysqluser1' and host='localhost';
select db, table_name, table_priv from mysql.tables_priv where user='mysqluser1' and host='localhost';
select mysqltest1.f1();
select * from mysqltest1.t11;
select * from mysqltest1.t22;
select mysqltest1.f1();
select * from mysqltest1.t11;
select * from mysqltest1.t22;
create user mysqluser1@localhost;
select db, routine_name, routine_type, proc_priv from mysql.procs_priv where user='mysqluser1' and host='localhost';
select db, table_name, table_priv from mysql.tables_priv where user='mysqluser1' and host='localhost';
select mysqltest1.f1();
select * from mysqltest1.t11;
select * from mysqltest1.t22;
select db, routine_name, routine_type, proc_priv from mysql.procs_priv where user='mysqluser10' and host='localhost';
select db, table_name, table_priv from mysql.tables_priv where user='mysqluser10' and host='localhost';
select mysqltest1.f1();
select * from mysqltest1.t11;
select * from mysqltest1.t22;
drop user mysqluser1@localhost;
drop user mysqluser10@localhost;
drop user mysqluser11@localhost;
drop database mysqltest1;

--
-- Bug#21432 Database/Table name limited to 64 bytes, not chars, problems with multi-byte
--
--character_set utf8mb3
set names utf8mb3;
create user юзер_юзер@localhost;
drop user юзер_юзер@localhost;
set names default;

--
-- Bug#20901 CREATE privilege is enough to insert into a table
--

create database mysqltest;
use mysqltest;

create user mysqltest@localhost;
create table t1 (i INT);
insert into t1 values (1);
create table t2 (i INT);
create table t4 (i INT);
insert into t2 values (1);


-- CREATE IF NOT EXISTS...SELECT, t1 exists, no INSERT, must fail
--error ER_TABLEACCESS_DENIED_ERROR
create table if not exists t1 select * from t2;

-- CREATE IF NOT EXISTS...SELECT, no t3 yet, no INSERT, must fail
--error ER_TABLEACCESS_DENIED_ERROR
create table if not exists t3 select * from t2;

-- CREATE IF NOT EXISTS...SELECT, t4 exists, have INSERT, must succeed
create table if not exists t4 select * from t2;

-- CREATE IF NOT EXISTS...SELECT, no t5 yet, have INSERT, must succeed
create table if not exists t5 select * from t2;


-- CREATE...SELECT, no t6 yet, have INSERT, must succeed
create table t6 select * from t2;

-- CREATE...SELECT, no t7 yet, no INSERT, must fail
--error ER_TABLEACCESS_DENIED_ERROR
create table t7 select * from t2;

-- CREATE...SELECT, t4 exists, have INSERT, must still fail (exists)
--error 1050
create table t4 select * from t2;

-- CREATE...SELECT, t1 exists, no INSERT, must fail
--error ER_TABLEACCESS_DENIED_ERROR
create table t1 select * from t2;
drop table t1,t2,t4,t5,t6;
drop user mysqltest@localhost;
drop database mysqltest;
use test;


--
-- Bug#16470 crash on grant if old grant tables
--

call mtr.add_suppression("Can't open and lock privilege tables");
CREATE DATABASE mysqltest1;
CREATE PROCEDURE mysqltest1.test() SQL SECURITY DEFINER
  SELECT 1;
CREATE FUNCTION mysqltest1.test() RETURNS INT RETURN 1;
DROP DATABASE mysqltest1;


--
-- Bug#33464 DROP FUNCTION caused a crash.
--
CREATE DATABASE dbbug33464;
CREATE USER 'userbug33464'@'localhost';
CREATE PROCEDURE sp3(v1 char(20))
BEGIN
   SELECT * from dbbug33464.t6 where t6.f2= 'xyz';
CREATE FUNCTION fn1() returns char(50) SQL SECURITY INVOKER
BEGIN
   return 1;
CREATE FUNCTION fn2() returns char(50) SQL SECURITY DEFINER
BEGIN
   return 2;

-- cleanup
connection default;
USE dbbug33464;

SELECT fn1();
SELECT fn2();
DROP USER 'userbug33464'@'localhost';

DROP FUNCTION fn1;
DROP FUNCTION fn2;
DROP PROCEDURE sp3;
DROP USER 'userbug33464'@'localhost';

USE test;
DROP DATABASE dbbug33464;


SET @@global.log_bin_trust_function_creators= @old_log_bin_trust_function_creators;

--
-- Bug#44658 Create procedure makes server crash when user does not have ALL privilege
--
CREATE USER user1@localhost;
CREATE USER user2;
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
CREATE DATABASE db1;
CREATE PROCEDURE db1.proc1(p1 INT)
 BEGIN
 SET @x = 0;
 END ;
CREATE PROCEDURE db1.proc2(p1 INT)
 BEGIN
 SET @x = 0;
 END ;
DROP PROCEDURE db1.proc1;
DROP PROCEDURE db1.proc2;
DROP USER 'user1'@'localhost';
DROP USER 'user2';
DROP DATABASE db1;

CREATE USER mysqltest_1;
DROP USER mysqltest_1;

USE test;

CREATE USER mysqltest_1;
DROP USER mysqltest_1;

CREATE USER mysqltest_1;
DROP USER mysqltest_1;


--
-- Bug #53371: COM_FIELD_LIST can be abused to bypass table level grants.
--

CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE USER 'testbug'@localhost;
USE db2;
CREATE TABLE t1 (a INT);
USE test;
SELECT * FROM `../db2/tb2`;
SELECT * FROM `../db2`.tb2;
SELECT * FROM `--mysql50#/../db2/tb2`;
DROP USER 'testbug'@localhost;
DROP TABLE db2.t1;
DROP DATABASE db1;
DROP DATABASE db2;
create user myuser@Localhost identified by 'foo';
select host,user from mysql.user where User='myuser';
delete from mysql.user where User='myuser';

DELETE FROM mysql.user WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.db WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.tables_priv WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.columns_priv WHERE User LIKE 'mysqltest_%';

CREATE DATABASE mysqltest_db1;

CREATE TABLE mysqltest_db1.t1(a INT);
CREATE USER mysqltest_u1@localhost;
DROP DATABASE mysqltest_db1;

DROP USER mysqltest_u1@localhost;
create database mysqltest_db1;
create user mysqltest_u1;
drop database mysqltest_db1;
drop user mysqltest_u1;

CREATE DATABASE secret;
CREATE USER 'untrusted'@localhost;
CREATE PROCEDURE no_such_db.foo() BEGIN END;
CREATE PROCEDURE secret.peek_at_secret() BEGIN END;
DROP USER 'untrusted'@localhost;
DROP DATABASE secret;

CREATE USER foo@'127.0.0.1';
SELECT user(), current_user();
SELECT user(), current_user();
SELECT user(), current_user();
DROP USER foo@'127.0.0.1';

SET @saved_value = @@global.default_password_lifetime;
SET GLOBAL default_password_lifetime = 2;

CREATE USER 'wl7131' IDENTIFIED BY 'wl7131';
SELECT (SELECT now()-(SELECT password_last_changed from mysql.user where user='wl7131')) <= 2;
UPDATE mysql.user SET password_last_changed = (now() - INTERVAL 3 DAY) where user='wl7131';
SELECT 1;
ALTER USER wl7131 IDENTIFIED BY 'new_wl7131';
SELECT 1;
SELECT 1;
DROP USER 'wl7131';

CREATE USER 'wl7131' IDENTIFIED BY 'wl7131';
ALTER USER 'wl7131' PASSWORD EXPIRE NEVER;
SELECT password_lifetime FROM mysql.user where user='wl7131';
UPDATE mysql.user SET password_last_changed = (now() - INTERVAL 5 DAY) where user='wl7131';

ALTER USER 'wl7131' PASSWORD EXPIRE DEFAULT;
SELECT password_lifetime FROM mysql.user where user='wl7131';

SET GLOBAL default_password_lifetime = 0;

ALTER USER 'wl7131' PASSWORD EXPIRE INTERVAL 4 DAY;
SELECT password_lifetime FROM mysql.user where user='wl7131';

SET GLOBAL default_password_lifetime = @saved_value;

ALTER USER 'wl7131' PASSWORD EXPIRE INTERVAL 6 DAY;
select password_lifetime from mysql.user where user='wl7131';
DROP USER 'wl7131';

CREATE USER 'wl7131';
let $password_change_time_1=`SELECT password_last_changed FROM mysql.user where user='wl7131'`;
ALTER USER 'wl7131' REQUIRE SSL;
let $password_change_time_2=`SELECT password_last_changed FROM mysql.user where user='wl7131'`;
ALTER USER 'wl7131' PASSWORD EXPIRE INTERVAL -2 DAY;
ALTER USER 'wl7131' PASSWORD EXPIRE INTERVAL 0 DAY;
ALTER USER 'wl7131' PASSWORD EXPIRE INTERVAL 65536 DAY;
ALTER USER 'wl7131' IDENTIFIED BY '';
SELECT (SELECT now()-(SELECT password_last_changed from mysql.user where user='wl7131')) <= 2;
DROP USER 'wl7131';

CREATE USER 'wl7131'@'localhost' IDENTIFIED BY 'wl7131';
SELECT (SELECT password_last_changed FROM mysql.user where user='wl7131') IS NOT NULL;

DROP USER 'wl7131'@'localhost';

set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

--echo --
--echo -- WL#2284: Increase the length of a user name
--echo --

CREATE TABLE t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);

CREATE PROCEDURE p1() SELECT b FROM t1;

CREATE USER user_name_len_16@localhost;
CREATE USER user_name_len_22_01234@localhost;
CREATE USER user_name_len_32_012345678901234@localhost;
CREATE USER user_name_len_33_0123456789012345@localhost;
CREATE USER user_name_len_40_01234567890123456789012@localhost;

-- Working with database-level privileges.

GRANT CREATE ON mysqltest.* TO user_name_len_16@localhost;

-- Working with table-level privileges.

GRANT CREATE ON t1 TO user_name_len_16@localhost;

-- Working with routine-level privileges.

GRANT EXECUTE ON PROCEDURE p1 TO user_name_len_16@localhost;
DROP USER user_name_len_40_01234567890123456789012@localhost;
set names utf8mb3;

-- 16 characters user name
CREATE USER очень_длинный_юз@localhost;
CREATE USER очень_очень_длинный_юзер@localhost;
CREATE USER очень_очень_очень_длинный_юзер__@localhost;
CREATE USER очень_очень_очень_очень_длинный_юзер@localhost;


CREATE USER user_name_len_25_01234567@localhost;

CREATE DATABASE db_1;

CREATE TABLE db_1.test_table (name varchar(15) not null, surname varchar(20) not null, 
email varchar(50) null, street varchar(50) null, city varchar(50) null, 
is_active int default 1 );
INSERT INTO db_1.test_table values('rob', 'g', 'robg@oracle.com', 'couldbeworse_street',
'couldbeworse_city', 1);
INSERT INTO db_1.test_table values('rob', 'g', 'robg@oracle.com', 'couldbeworse_street',
'couldbeworse_city', 1);

INSERT INTO db_1.test_table values('kam', 'g', 'kamg@oracle.com', 'couldbeworse_street',
'couldbeworse_city', 1);
SELECT * FROM db_1.test_table;
SELECT * FROM db_1.test_table;
UPDATE db_1.test_table SET street='couldbemuchworse_street' WHERE name='rob';
UPDATE db_1.test_table SET street='couldbemuchworse_street' WHERE name='rob';
DELETE FROM db_1.test_table WHERE name='rob';
DELETE FROM db_1.test_table WHERE name='rob';
DROP TABLE db_1.test_table;

DROP TABLE db_1.test_table;
DROP DATABASE db_1;

-- cleanup

DROP USER очень_длинный_юз@localhost;
DROP USER очень_очень_длинный_юзер@localhost;
DROP USER очень_очень_очень_длинный_юзер__@localhost;
DROP USER очень_очень_очень_очень_длинный_юзер@localhost;

set names default;

DROP USER user_name_len_16@localhost;
DROP USER user_name_len_22_01234@localhost;
DROP USER user_name_len_32_012345678901234@localhost;
DROP USER user_name_len_25_01234567@localhost;

DROP TABLE t1;
DROP PROCEDURE p1;

--
-- Bug#21762656 AFTER RUNNING MYSQL_UPGRADE PROXIES_PRIV USER COLUMNS ARE NOT UPDATED TO 32
--

CREATE USER user_name_len_22_01234@localhost;

CREATE USER user_name_len_32_012345678901234@localhost;
CREATE USER proxy_native_0123456789@localhost IDENTIFIED WITH mysql_native_password;
SELECT USER, PROXIED_USER, GRANTOR FROM mysql.proxies_priv WHERE Proxied_host='localhost';
DROP USER user_name_len_22_01234@localhost;
DROP USER user_name_len_32_012345678901234@localhost;
DROP USER proxy_native_0123456789@localhost;

CREATE DATABASE db8657;
CREATE TABLE db8657.t1 (i INT);

CREATE USER 'untrusted8657'@'localhost';
CREATE INDEX idx1 ON db8657.t1 (i);

DROP USER 'untrusted8657'@localhost;
DROP DATABASE db8657;

CREATE DATABASE db8063;
CREATE TABLE db8063.t1(a VARCHAR(20));

CREATE USER 'untrusted8063'@'localhost';

DROP USER 'untrusted8063'@localhost;
DROP DATABASE db8063;
CREATE DATABASE mysqltest_1;
CREATE USER mysqluser1@localhost, MySQLuser1@localhost;
CREATE VIEW mysqltest_1.v1 AS SELECT 1;
SELECT view_definition
  FROM information_schema.views
  WHERE table_schema='mysqltest_1' AND table_name='v1';
SELECT view_definition FROM information_schema.views
  WHERE table_schema='mysqltest_1' AND table_name='v1';
DROP USER mysqluser1@localhost, MySQLuser1@localhost;
DROP DATABASE mysqltest_1;

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

--echo --
--echo -- Test prepared statements and REVOKE between PREPARE and EXECUTE
--echo --

CREATE DATABASE mysqltest;

CREATE USER mysqltest@localhost;

CREATE TABLE mysqltest.visible(s INTEGER, u INTEGER, d INTEGER);

CREATE VIEW mysqltest.v0 AS SELECT s, u, d FROM mysqltest.visible;

CREATE TABLE mysqltest.cols(
 s1 INTEGER, s2 INTEGER,
 u1 INTEGER, u2 INTEGER,
 i1 INTEGER, i2 INTEGER);

CREATE TABLE mysqltest.ins(i1 INTEGER, i2 INTEGER, i3 INTEGER);

CREATE TABLE mysqltest.source(b1 INTEGER, b2 INTEGER);

INSERT INTO mysqltest.source VALUES(1, 1);

CREATE VIEW mysqltest.v1 AS
SELECT s1, s2, u1, u2, i1, i2 FROM mysqltest.cols;

CREATE FUNCTION mysqltest.f1() RETURNS INTEGER DETERMINISTIC RETURN 1;

CREATE PROCEDURE mysqltest.p1(a INTEGER) SELECT a;

CREATE PROCEDURE mysqltest.p2(a INTEGER) SELECT a;

DROP TABLE mysqltest.visible, mysqltest.cols, mysqltest.source, mysqltest.ins;
DROP VIEW mysqltest.v0, mysqltest.v1;
DROP FUNCTION mysqltest.f1;
DROP PROCEDURE mysqltest.p1;
DROP PROCEDURE mysqltest.p2;

DROP DATABASE mysqltest;

DROP USER mysqltest@localhost;
CREATE USER 'user01'@'localhost' IDENTIFIED BY '';
CREATE USER 'user02'@'localhost' IDENTIFIED BY '';

CREATE DATABASE test01;
CREATE TABLE test01.c (id int primary key, a varchar(100));
INSERT INTO test01.c SET id = 1, a = "xyz";

CREATE DATABASE test02;
CREATE TABLE test02.tbl01 (id int primary key, a varchar(100));
INSERT INTO test02.tbl01 SET id = 1, a = "xyz";
CREATE TABLE test02.tbl02 (id int primary key, a varchar(100));

CREATE DEFINER='user01'@'localhost' TRIGGER test02.trg01
  AFTER UPDATE ON test02.tbl01 FOR EACH ROW
    UPDATE test02.tbl02 SET a = (SELECT a FROM test01.c WHERE id = 1) WHERE id = NEW.id;
CREATE DEFINER='user01'@'localhost' FUNCTION test02.sf() RETURNS INT
BEGIN
   SELECT tbl02.id FROM test02.tbl02 as tbl02, test01.c as c
                   WHERE tbl02.id  = c.id INTO @a;
DROP PREPARE stmt;
DROP PREPARE stmt;
DROP DATABASE test01;
DROP DATABASE test02;
DROP USER 'user01'@'localhost';
DROP USER 'user02'@'localhost';

CREATE USER bug33578113;

DROP USER bug33578113;
