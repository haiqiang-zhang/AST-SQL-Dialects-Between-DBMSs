--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
-- We can't create ''@'%' unless we delete row from mysql.db
create table mysql.db_copy as select * from mysql.db;
delete from mysql.db where host='%';

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;
use test;

-- Create user user1 with no particular access rights
create user user1@localhost;
create user ''@'%';
create user user1;
delete from mysql.db;
insert into mysql.db select * from mysql.db_copy;
drop table if exists t1;
drop database if exists db1_secret;
create database db1_secret;

-- Can create a procedure in other db
create procedure db1_secret.dummy() begin end;
drop procedure db1_secret.dummy;

use db1_secret;

create table t1 ( u varchar(64), i int );
insert into t1 values('test', 0);

-- A test procedure and function
create procedure stamp(i int)
  insert into db1_secret.t1 values (user(), i);
create function db() returns varchar(64)
begin
  declare v varchar(64);

  select u into v from t1 limit 1;

-- root can, of course
call stamp(1);
select * from t1;
select db();


--
-- User1 can
--
connection con2user1;

-- This should work...
call db1_secret.stamp(2);
select db1_secret.db();

-- ...but not this
--error ER_TABLEACCESS_DENIED_ERROR
select * from db1_secret.t1;

-- ...and not this
--error ER_DBACCESS_DENIED_ERROR
create procedure db1_secret.dummy() begin end;
drop procedure db1_secret.dummy;
drop procedure db1_secret.stamp;
drop function db1_secret.db;


--
-- Anonymous can
--
connection con3anon;

-- This should work...
call db1_secret.stamp(3);
select db1_secret.db();

-- ...but not this
--error ER_TABLEACCESS_DENIED_ERROR
select * from db1_secret.t1;

-- ...and not this
--error ER_DBACCESS_DENIED_ERROR
create procedure db1_secret.dummy() begin end;
drop procedure db1_secret.dummy;
drop procedure db1_secret.stamp;
drop function db1_secret.db;


--
-- Check it out
--
connection con1root;
select * from t1;

--
-- Change to invoker's rights
--
alter procedure stamp sql security invoker;

alter function db sql security invoker;

-- root still can
call stamp(4);
select * from t1;
select db();

--
-- User1 cannot
--
connection con2user1;

-- This should not work
--error ER_TABLEACCESS_DENIED_ERROR
call db1_secret.stamp(5);
select db1_secret.db();

--
-- Anonymous cannot
--
connection con3anon;

-- This should not work
--error ER_TABLEACCESS_DENIED_ERROR
call db1_secret.stamp(6);
select db1_secret.db();

--
-- Bug#2777 Stored procedure doesn't observe definer's rights
--

connection con1root;
drop database if exists db2;
create database db2;

use db2;

create table t2 (s1 int);
insert into t2 values (0);

create user user2@localhost;
use db2;

create procedure p () insert into t2 values (1);

-- Check that this doesn't work.
--error ER_TABLEACCESS_DENIED_ERROR
call p();
use db2;

-- This should not work, since p is executed with definer's (user1's) rights.
--error ER_PROCACCESS_DENIED_ERROR
call p();
select * from t2;

create procedure q () insert into t2 values (2);
select * from t2;
use db2;

-- This should work
call q();
select * from t2;

--
-- Bug#6030 Stored procedure has no appropriate DROP privilege
-- (or ALTER for that matter)

-- still connection con2user1 in db2

-- This should work:
alter procedure p modifies sql data;
drop procedure p;

-- This should NOT work
--error ER_PROCACCESS_DENIED_ERROR
alter procedure q modifies sql data;
drop procedure q;
use db2;
alter procedure q modifies sql data;
drop procedure q;


-- Clean up
-- Still connection con1root;
use test;
select routine_type, routine_schema, routine_name
from information_schema.routines where routine_schema like 'db%'
order by routine_type, routine_name;
drop database db1_secret;
drop database db2;
select routine_type, routine_schema, routine_name
from information_schema.routines where routine_schema like 'db%';
delete from mysql.user where user='user1' or user='user2';
delete from mysql.user where user='' and host='%';
delete from mysql.procs_priv where user='user1' or user='user2';
delete from mysql.procs_priv where user='' and host='%';
delete from mysql.db where user='user1' or user='user2';
create user usera@localhost;
create user userb@localhost;
create user userc@localhost;
create database sptest;
create table t1 ( u varchar(64), i int );
create procedure sptest.p1(i int) insert into test.t1 values (user(), i);
drop procedure sptest.p1;
drop procedure sptest.p1;
drop procedure sptest.p1;
drop procedure sptest.p1;
select * from t1;
use test;
drop database sptest;
delete from mysql.user where user='usera' or user='userb' or user='userc';
delete from mysql.procs_priv where user='usera' or user='userb' or user='userc';
delete from mysql.tables_priv where user='usera';
drop table t1;

--
-- Bug#9503 reseting correct parameters of thread after error in SP function
--
connect (root,localhost,root,,test);

create user user1@localhost;
drop function if exists bug_9503;
create database mysqltest//
use mysqltest//
create table t1 (s1 int)//
grant select on t1 to user1@localhost//
create function bug_9503 () returns int sql security invoker begin declare v int;
select min(s1) into v from t1;
use mysqltest;
select bug_9503();
use test;
drop function bug_9503;
use test;
drop database mysqltest;

--
-- correct value from current_user() in function run from "security definer"
-- (Bug#7291 Stored procedures: wrong CURRENT_USER value)
--
connection con1root;
use test;

select current_user();
select user();
create procedure bug7291_0 () sql security invoker select current_user(), user();
create procedure bug7291_1 () sql security definer call bug7291_0();
create procedure bug7291_2 () sql security invoker call bug7291_0();
drop procedure bug7291_1;
drop procedure bug7291_2;
drop procedure bug7291_0;
drop user user1@localhost;

--
-- Bug#12318 Wrong error message when accessing an inaccessible stored
-- procedure in another database when the current database is
-- information_schema.
--

--disable_warnings
drop database if exists mysqltest_1;

create database mysqltest_1;
create procedure mysqltest_1.p1()
begin
   select 1 from dual;

create user mysqltest_1@localhost;

drop procedure mysqltest_1.p1;
drop database mysqltest_1;
drop user mysqltest_1@localhost;

--
-- Bug#12812 create view calling a function works without execute right
--           on function
delimiter |;
drop function if exists bug12812|
--enable_warnings
create function bug12812() returns char(2)
begin
  return 'ok';
create user user_bug12812@localhost IDENTIFIED BY 'ABC'|
--replace_result $MASTER_MYPORT MYSQL_PORT $MASTER_MYSOCK MYSQL_SOCK
connect (test_user_12812,localhost,user_bug12812,ABC,test)|
--error ER_PROCACCESS_DENIED_ERROR
SELECT test.bug12812()|
--error ER_PROCACCESS_DENIED_ERROR
CREATE VIEW v1 AS SELECT test.bug12812()|
-- Cleanup
connection default|
disconnect test_user_12812|
DROP USER user_bug12812@localhost|
drop function bug12812|
delimiter ;


--
-- Bug#14834 Server denies to execute Stored Procedure
--
-- The problem here was with '_' in the database name.
--
create database db_bug14834;

create user user1_bug14834@localhost identified by '';

create user user2_bug14834@localhost identified by '';

create user user3_bug14834@localhost identified by '';
create procedure p_bug14834() select user(), current_user();

-- Cleanup
connection default;
drop user user1_bug14834@localhost;
drop user user2_bug14834@localhost;
drop user user3_bug14834@localhost;
drop database db_bug14834;


--
-- Bug#14533 'desc tbl' in stored procedure causes error
-- ER_TABLEACCESS_DENIED_ERROR
--
create database db_bug14533;
use db_bug14533;
create table t1 (id int);
create user user_bug14533@localhost identified by '';

create procedure bug14533_1()
    sql security definer
  desc db_bug14533.t1;

create procedure bug14533_2()
    sql security definer
   select * from db_bug14533.t1;

-- These should work
call db_bug14533.bug14533_1();

-- For reference, these should not work
--error ER_TABLEACCESS_DENIED_ERROR
desc db_bug14533.t1;
select * from db_bug14533.t1;

-- Cleanup
connection default;
drop user user_bug14533@localhost;
drop database db_bug14533;


--
-- WL#2897 Complete definer support in the stored routines.
--
-- The following cases are tested:
--   1. check that if DEFINER-clause is not explicitly specified, stored routines
--     are created with CURRENT_USER privileges;
--   2. check that if DEFINER-clause specifies non-current user, SUPER privilege
--     is required to create a stored routine;
--   3. check that if DEFINER-clause specifies non-existent user, a warning is
--     emitted.
--   4. check that SHOW CREATE PROCEDURE | FUNCTION works correctly;
--   - check that mysqldump dumps new attribute correctly;
--   - check that slave replicates CREATE-statements with explicitly specified
--     DEFINER correctly.
--

-- Setup the environment.

--echo
--echo ---> connection: root
--connection con1root

--disable_warnings
DROP DATABASE IF EXISTS mysqltest;

CREATE DATABASE mysqltest;

CREATE USER mysqltest_1@localhost;

CREATE USER mysqltest_2@localhost;

-- test case (1).

--echo
--echo ---> connection: mysqltest_2_con
--connection mysqltest_2_con

USE mysqltest;

CREATE PROCEDURE wl2897_p1() SELECT 1;

CREATE FUNCTION wl2897_f1() RETURNS INT RETURN 1;

-- test case (2).

--echo
--echo ---> connection: mysqltest_1_con
--connection mysqltest_1_con

USE mysqltest;
CREATE DEFINER=root@localhost PROCEDURE wl2897_p2() SELECT 2;
CREATE DEFINER=root@localhost FUNCTION wl2897_f2() RETURNS INT RETURN 2;

-- test case (3).

--echo
--echo ---> connection: mysqltest_2_con
--connection mysqltest_2_con

use mysqltest;

CREATE DEFINER='a @ b @ c'@localhost PROCEDURE wl2897_p3() SELECT 3;

CREATE DEFINER='a @ b @ c'@localhost FUNCTION wl2897_f3() RETURNS INT RETURN 3;

-- test case (4).

--echo
--echo ---> connection: con1root
--connection con1root

USE mysqltest;

-- Cleanup.

DROP USER mysqltest_1@localhost;
DROP USER mysqltest_2@localhost;

DROP DATABASE mysqltest;


--
-- Bug#13198 SP executes if definer does not exist
--

-- Prepare environment.

--echo
--echo ---> connection: root
--connection con1root

--disable_warnings
DROP DATABASE IF EXISTS mysqltest;

CREATE DATABASE mysqltest;

CREATE USER mysqltest_1@localhost;

CREATE USER mysqltest_2@localhost;

-- Create a procedure/function under u1.

--echo
--echo ---> connection: mysqltest_1_con
--connection mysqltest_1_con

USE mysqltest;

CREATE PROCEDURE bug13198_p1()
  SELECT 1;

CREATE FUNCTION bug13198_f1() RETURNS INT
  RETURN 1;

SELECT bug13198_f1();

-- Check that u2 can call the procedure/function.

--echo
--echo ---> connection: mysqltest_2_con
--connection mysqltest_2_con

USE mysqltest;

SELECT bug13198_f1();

-- Drop user u1 (definer of the object);

DROP USER mysqltest_1@localhost;

-- Check that u2 can not call the procedure/function.

--echo
--echo ---> connection: mysqltest_2_con
--connection mysqltest_2_con

USE mysqltest;
SELECT bug13198_f1();

-- Cleanup.

--echo
--echo ---> connection: root
--connection con1root

--disconnect mysqltest_2_con

DROP USER mysqltest_2@localhost;

DROP DATABASE mysqltest;

--
-- Bug#19857 When a user with CREATE ROUTINE priv creates a routine,
--           it results in NULL p/w
--


CREATE USER user19857@localhost IDENTIFIED BY 'meow';
SELECT Host,User FROM mysql.user WHERE User='user19857';

USE test;
  CREATE PROCEDURE sp19857() DETERMINISTIC
  BEGIN
    DECLARE a INT;
    SET a=1;
    SELECT a;
  END //
DELIMITER ;

DROP PROCEDURE IF EXISTS test.sp19857;

SELECT Host,User FROM mysql.user WHERE User='user19857';

DROP USER user19857@localhost;
use test;

--
-- Bug#18630 Arguments of suid routine calculated in wrong security context
--
-- Arguments of suid routines were calculated in definer's security
-- context instead of caller's context thus creating security hole.
--
--disable_warnings
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP FUNCTION IF EXISTS f_suid;
DROP PROCEDURE IF EXISTS p_suid;
DROP FUNCTION IF EXISTS f_evil;
DELETE FROM mysql.user WHERE user LIKE 'mysqltest\_%';
DELETE FROM mysql.db WHERE user LIKE 'mysqltest\_%';
DELETE FROM mysql.tables_priv WHERE user LIKE 'mysqltest\_%';
DELETE FROM mysql.columns_priv WHERE user LIKE 'mysqltest\_%';

CREATE TABLE t1 (i INT);
CREATE FUNCTION f_suid(i INT) RETURNS INT SQL SECURITY DEFINER RETURN 0;
CREATE PROCEDURE p_suid(IN i INT) SQL SECURITY DEFINER SET @c:= 0;

CREATE USER mysqltest_u1@localhost;
CREATE DEFINER=mysqltest_u1@localhost FUNCTION f_evil () RETURNS INT
  SQL SECURITY INVOKER
BEGIN
  SET @a:= CURRENT_USER();
  SET @b:= (SELECT COUNT(*) FROM t1);

CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT f_evil();
SELECT COUNT(*) FROM t1;
SELECT f_evil();
SELECT @a, @b;
SELECT f_suid(f_evil());
SELECT @a, @b;
SELECT @a, @b;
SELECT * FROM v1;
SELECT @a, @b;

DROP VIEW v1;
DROP FUNCTION f_evil;
DROP USER mysqltest_u1@localhost;
DROP PROCEDURE p_suid;
DROP FUNCTION f_suid;
DROP TABLE t1;

CREATE DATABASE B48872;
USE B48872;
CREATE TABLE `TestTab` (id INT);
INSERT INTO `TestTab` VALUES (1),(2);
CREATE FUNCTION `f_Test`() RETURNS INT RETURN 123;
CREATE FUNCTION `f_Test_denied`() RETURNS INT RETURN 123;
CREATE USER 'tester';
CREATE USER 'Tester';

SELECT f_Test();
SELECT * FROM TestTab;

SELECT * FROM TestTab;
SELECT `f_Test`();
SELECT `F_TEST`();
SELECT f_Test();
SELECT F_TEST();
SELECT * FROM TestTab;
SELECT `f_Test`();
SELECT `F_TEST`();
SELECT f_Test();
SELECT F_TEST();
SELECT `f_Test_denied`();
SELECT `F_TEST_DENIED`();
DROP TABLE `TestTab`;
DROP FUNCTION `f_Test`;
DROP FUNCTION `f_Test_denied`;

USE test;
DROP USER 'tester';
DROP USER 'Tester';
DROP DATABASE B48872;
drop database if exists mysqltest_db;
create database mysqltest_db;
create user bug57061_user@localhost;
create function mysqltest_db.f1() returns int return 0;
create procedure mysqltest_db.p1() begin end;
drop function if exists mysqltest_db.f_does_not_exist;
drop procedure if exists mysqltest_db.p_does_not_exist;
drop function if exists mysqltest_db.f1;
drop procedure if exists mysqltest_db.p1;
drop user bug57061_user@localhost;
drop database mysqltest_db;
drop database if exists mysqltest_db;
create database mysqltest_db;
create function mysqltest_db.f1() returns int return 0;
create procedure mysqltest_db.p1() begin end;
create user bug12602983_user@localhost;
select mysqltest_db.f_does_not_exist();
select mysqltest_db.f1();
create view bug12602983_v1 as select mysqltest_db.f_does_not_exist();
create view bug12602983_v1 as select mysqltest_db.f1();
drop user bug12602983_user@localhost;
drop database mysqltest_db;

CREATE DATABASE mysqltest_db;
CREATE PROCEDURE mysqltest_db.p1(IN f1 INT) SELECT 1;

let $select_routines=
SELECT routine_schema, routine_name, routine_type, routine_definition
FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_schema = 'mysqltest_db';
let $select_parameters=
SELECT specific_schema, specific_name, parameter_name
FROM INFORMATION_SCHEMA.PARAMETERS WHERE specific_schema = 'mysqltest_db';
CREATE USER user@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE DEFINER=root@localhost PROCEDURE p1() SELECT current_user();
SELECT CURRENT_USER();
DROP PROCEDURE p1;
DROP USER u1@localhost;

-- Cleanup
--connection default
--disconnect conn1
--disconnect conn2
DROP USER user@localhost;
DROP DATABASE mysqltest_db;
CREATE ROLE r1;
CREATE DEFINER=r1 PROCEDURE p1() SELECT current_user();
DROP PROCEDURE p1;
DROP ROLE r1;

CREATE SCHEMA testdb;
CREATE USER usr_no_priv@localhost, usr_show_routine@localhost, usr_global_select@localhost, usr_definer@localhost, usr_role@localhost, usr_create_routine@localhost, usr_alter_routine@localhost, usr_execute@localhost;
CREATE ROLE role_show_routine;
CREATE PROCEDURE testdb.proc_root() SELECT "ProcRoot";
CREATE FUNCTION testdb.func_root() RETURNS VARCHAR(8) DETERMINISTIC RETURN "FuncRoot";
CREATE DEFINER = `usr_definer`@`localhost` PROCEDURE testdb.proc_definer() SELECT "ProcDefiner";
CREATE DEFINER = `usr_definer`@`localhost` FUNCTION testdb.func_definer() RETURNS VARCHAR(11) DETERMINISTIC RETURN "FuncDefiner";
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SET ROLE role_show_routine;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SET @start_partial_revokes = @@global.partial_revokes;
SET @@global.partial_revokes=ON;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
DROP USER usr_global_select@localhost;
SET @@global.partial_revokes = @start_partial_revokes;
DROP USER usr_no_priv@localhost, usr_show_routine@localhost, usr_definer@localhost, usr_role@localhost, usr_create_routine@localhost, usr_alter_routine@localhost, usr_execute@localhost;
DROP ROLE role_show_routine;
DROP SCHEMA testdb;

-- Restore mysql.db to its original state
delete from mysql.db;
insert into mysql.db select * from mysql.db_copy;
drop table mysql.db_copy;

SET GLOBAL sql_mode= @orig_sql_mode_global;
SET SESSION sql_mode= @orig_sql_mode_session;
SET GLOBAL partial_revokes = @orig_partial_revokes;
