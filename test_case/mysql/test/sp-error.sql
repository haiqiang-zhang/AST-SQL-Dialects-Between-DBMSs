--

-- ER_STACK_OVERRUN_NEED_MORE does not currenly work well with TSan
--source include/not_tsan.inc

delimiter |;

-- This should give three syntax errors (sometimes crashed;
--  passed despite the bug.)
--error 1064
create procedure syntaxerror(t int)|
--error 1064
create procedure syntaxerror(t int)|
--error 1064
create procedure syntaxerror(t int)|

-- Check that we get the right error, i.e. UDF declaration parses correctly,
-- but foo.so doesn't exist.
--    This generates an error message containing a misleading errno which
--    might vary between systems (it usually doesn't have anything to do with
--    the actual failing dlopen()).
----error 1126
--create function foo returns real soname "foo.so"|


create table t3 ( x int )|
insert into t3 values (2), (3)|

create procedure bad_into(out param int)
  select x from t3 into param|

--error 1172
call bad_into(@x)|

drop procedure bad_into|
drop table t3|


create procedure proc1()
  set @x = 42|

create function func1() returns int
  return 42|

-- Can't create recursively
--error 1303
create procedure foo()
  create procedure bar() set @x=3|
--error 1303
create procedure foo()
  create function bar() returns double return 2.3|

-- Already exists
--error 1304
create procedure proc1()
  set @x = 42|
--error 1304
create function func1() returns int
  return 42|

drop procedure proc1|
drop function func1|

-- Does not exist
--error 1305
alter procedure foo|
--error 1305
alter function foo|
--error 1305
drop procedure foo|
--error 1305
drop function foo|
--error 1305
call foo()|
drop procedure if exists foo|
--error 1305
show create procedure foo|
--error 1305
show create function foo|

-- LEAVE/ITERATE with no match
--error 1308
create procedure foo()
foo: loop
  leave bar;
end loop|
--error 1308
create procedure foo()
foo: loop
  iterate bar;
end loop|
--error 1308
create procedure foo()
foo: begin
  iterate foo;

-- Redefining label
--error 1309
create procedure foo()
foo: loop
  foo: loop
    set @x=2;
  end loop foo;
end loop foo|

-- End label mismatch
--error 1310
create procedure foo()
foo: loop
  set @x=2;
end loop bar|

-- RETURN in FUNCTION only
--error 1313
create procedure foo()
  return 42|

-- Wrong number of arguments
create procedure p(x int)
  set @x = x|
create function f(x int) returns int
  return x+42|

--error 1318
call p()|
--error 1318
call p(1, 2)|
--error 1318
select f()|
--error 1318
select f(1, 2)|

drop procedure p|
drop function f|

--error 1319 
create procedure p(val int, out res int)
begin
  declare x int default 0;

  insert into test.t1 values (val);
  if (x) then
    set res = 0;
    set res = 1;
  end if;
create procedure p(val int, out res int)
begin
  declare x int default 0;

  insert into test.t1 values (val);
  if (x) then
    set res = 0;
    set res = 1;
  end if;
create function f(val int) returns int
begin
  declare x int;

  set x = val+3;

create function f(val int) returns int
begin
  declare x int;

  set x = val+3;
  if x < 4 then
    return x;
  end if;
select f(10)|

drop function f|

--error ER_PARSE_ERROR
create procedure p()
begin
  declare c cursor for insert into test.t1 values ("foo", 42);
create procedure p()
begin
  declare x int;
create procedure p()
begin
  declare c cursor for select * from test.t;

create table t1 (val int)|

create procedure p()
begin
  declare c cursor for select * from test.t1;
drop procedure p|

create procedure p()
begin
  declare c cursor for select * from test.t1;
drop procedure p|

--error 1305
alter procedure bar3 sql security invoker|

drop table t1|

create table t1 (val int, x float)|
insert into t1 values (42, 3.1), (19, 1.2)|

--error 1327
create procedure p()
begin
  declare x int;

create procedure p()
begin
  declare x int;
drop procedure p|

create procedure p()
begin
  declare x int;
drop procedure p|

--error 1330
create procedure p(in x int, x char(10))
begin
end|
--error 1330
create function p(x int, x char(10))
begin
end|

--error 1331
create procedure p()
begin
  declare x float;
create procedure p()
begin
  declare c condition for 1064;
create procedure p()
begin
  declare c cursor for select * from t1;

-- USE is not allowed
--error ER_SP_BADSTATEMENT 
create procedure u()
  use sptmp|

-- Enforced standard order of declarations
--error 1337
create procedure p()
begin
  declare c cursor for select * from t1;
create procedure p()
begin
  declare x int;
create procedure p()
begin
  declare x int;

-- Check in and inout arguments.
create procedure p(in x int, inout y int, out z int)
begin
  set y = x+y;
  set z = x+y;

set @tmp_x = 42|
set @tmp_y = 3|
set @tmp_z = 0|
-- For reference: this is ok
call p(@tmp_x, @tmp_y, @tmp_z)|
select @tmp_x, @tmp_y, @tmp_z|

--error ER_SP_NOT_VAR_ARG
call p(42, 43, @tmp_z)|
--error ER_SP_NOT_VAR_ARG
call p(42, @tmp_y, 43)|

drop procedure p|


--
-- Let us test that we can access routines definitions in LOCK TABLE mode.
--
create procedure p() begin end|
lock table t1 read|
-- This should succeed
call p()|
unlock tables|
drop procedure p|


--
-- Check that in functions we don't allow to update tables which
-- are used by statements which invoke these functions.
--
create function f1(i int) returns int
begin
  insert into t1 (val) values (i);
select val, f1(val) from t1|
-- Table alias should not matter
--error ER_CANT_UPDATE_USED_TABLE_IN_SF_OR_TRG
select val, f1(val) from t1 as tab|
select * from t1|
--error ER_CANT_UPDATE_USED_TABLE_IN_SF_OR_TRG
update t1 set val= f1(val)|
select * from t1|
-- But this should be OK
select f1(17)|
select * from t1|
-- Cleanup
delete from t1 where val= 17|
drop function f1|


--
-- BUG#1965
--
create procedure bug1965()
begin
  declare c cursor for select val from t1 order by valname;
drop procedure bug1965|

--
-- BUG#1966
--
--error 1327
select 1 into a|

--
-- BUG#1653
--
create table t3 (column_1_0 int)|

create procedure bug1653()
  update t3 set column_1 = 0|

--error 1054
call bug1653()|
drop table t3|
create table t3 (column_1 int)|
call bug1653()|

drop procedure bug1653|
drop table t3|

--
-- BUG#2259
--
-- Note: When this bug existed, it did not necessarily cause a crash
--       in all builds, but valgrind did give warnings.
create procedure bug2259()
begin
  declare v1 int;
drop procedure bug2259|

--
-- BUG#2272
--
create procedure bug2272()
begin
  declare v int;

  update t1 set v = 42;

insert into t1 values (666, 51.3)|
--error 1054
call bug2272()|
truncate table t1|
drop procedure bug2272|

--
-- BUG#2329
--
create procedure bug2329_1()
begin
  declare v int;

  insert into t1 (v) values (5);

create procedure bug2329_2()
begin
  declare v int;
drop procedure bug2329_1|
drop procedure bug2329_2|

--
-- BUG#3287
--
create function bug3287() returns int
begin
  declare v int default null;
    when v is not null then return 1;
  end case;
select bug3287()|
drop function bug3287|

create procedure bug3287(x int)
case x
when 0 then
  insert into test.t1 values (x, 0.1);
  insert into test.t1 values (x, 1.1);
end case|
--error 1339
call bug3287(2)|
drop procedure bug3287|

--
-- BUG#3297
--
create table t3 (s1 int, primary key (s1))|
insert into t3 values (5),(6)|

create procedure bug3279(out y int) 
begin
  declare x int default 0;
    declare exit handler for sqlexception set x = x+1;
    insert into t3 values (5);
  if x < 2 then
    set x = x+1;
    insert into t3 values (6);
  end if;
  set y = x;

set @x = 0|
--error ER_DUP_ENTRY
call bug3279(@x)|
select @x|
drop procedure bug3279|
drop table t3|

--
-- BUG#3339
--
--error 1049
create procedure nodb.bug3339() begin end|

--
-- BUG#2653
--
create procedure bug2653_1(a int, out b int)
  set b = aa|

create procedure bug2653_2(a int, out b int)
begin
  if aa < 0 then
    set b = - a;
    set b = a;
  end if;

drop procedure bug2653_1|
drop procedure bug2653_2|

--
-- BUG#4344
--
--error 1357
create procedure bug4344() drop procedure bug4344|
--error 1357
create procedure bug4344() drop function bug4344|

--
-- BUG#3294: Stored procedure crash if table dropped before use
-- (Actually, when an error occurs within an error handler.)
create procedure bug3294()
begin
  declare continue handler for sqlexception drop table t5;
  drop table t5;
  drop table t5;

create table t5 (x int)|
--error 1051
call bug3294()|
drop procedure bug3294|

--
-- BUG#876: Stored Procedures: Invalid SQLSTATE is allowed in 
--          a DECLARE ? HANDLER FOR stmt.
--
--disable_warnings
drop procedure if exists bug8776_1|
drop procedure if exists bug8776_2|
drop procedure if exists bug8776_3|
drop procedure if exists bug8776_4|
--enable_warnings
--error ER_SP_BAD_SQLSTATE
create procedure bug8776_1()
begin
  declare continue handler for sqlstate '42S0200test' begin end;
create procedure bug8776_2()
begin
  declare continue handler for sqlstate '4200' begin end;
create procedure bug8776_3()
begin
  declare continue handler for sqlstate '420000' begin end;
create procedure bug8776_4()
begin
  declare continue handler for sqlstate '42x00' begin end;


--
-- BUG#6600: Stored procedure crash after repeated calls with check table
--
--error ER_SP_BADSTATEMENT
create procedure bug6600()
  check table t1|

-- Check these two as well, while we're at it. (Although it isn't really
-- related to the bug report, but to the fix.)
--error ER_SP_BADSTATEMENT
create procedure bug6600()
  lock table t1 read|
--error ER_SP_BADSTATEMENT
create procedure bug6600()
  unlock table t1|


--
-- BUG#7299: Stored procedures: exception handler catches not-found conditions
--
create procedure bug7299()
begin
  declare v int;
drop procedure bug7299|


--
-- BUG#9073: Able to declare two handlers for same condition in same scope
--
--error ER_SP_DUP_HANDLER
create procedure bug9073()
begin
  declare continue handler for sqlexception select 1;
create procedure bug9073()
begin
  declare condname1 condition for 1234;
create procedure bug9073()
begin
  declare condname1 condition for sqlstate '42000';
create procedure bug9073()
begin
  declare condname1 condition for sqlstate '42000';

-- This should still work.
create procedure bug9073()
begin
  declare condname1 condition for sqlstate '42000';
    declare exit handler for sqlstate '42000' select 2;
    begin
      declare continue handler for sqlstate '42000' select 3;
    end;
drop procedure bug9073|


--
-- BUG#7047: Stored procedure crash if alter procedure
--
--error ER_SP_NO_DROP_SP
create procedure bug7047()
  alter procedure bug7047|
--error ER_SP_NO_DROP_SP
create function bug7047() returns int
begin
  alter function bug7047;


--
-- BUG#8408: Stored procedure crash if function contains SHOW
-- BUG#9058: Stored Procedures: Crash if function included SELECT
--

-- Some things are caught when parsing
--error ER_SP_NO_RETSET
create function bug8408() returns int
begin
  select * from t1;
create function bug8408() returns int
begin
  show warnings;
create function bug8408(a int) returns int
begin
  declare b int;
  select b;
drop function if exists bug8408_f|
drop procedure if exists bug8408_p|
--enable_warnings

-- Some things must be caught at invokation time
create function bug8408_f() returns int
begin
  call bug8408_p();
create procedure bug8408_p()
  select * from t1|

call bug8408_p()|
--error ER_SP_NO_RETSET
select bug8408_f()|

drop procedure bug8408_p|
drop function bug8408_f|

-- But this is ok
create function bug8408() returns int
begin
  declare n int default 0;
  select count(*) into n from t1;

insert into t1 value (2, 2.7), (3, 3.14), (7, 7.0)|
select *,bug8408() from t1|

drop function bug8408|
truncate table t1|


--
-- BUG#10537: Server crashes while loading data file into table through
--            procedure.
-- Disable load until it's PS and SP safe
--error ER_SP_BADSTATEMENT
create procedure bug10537()
  load data local infile '/tmp/somefile' into table t1|


--
-- BUG#8409: Stored procedure crash if function contains FLUSH
--
--error ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG
create function bug8409()
  returns int
begin
  flush tables;
create function bug8409() returns int begin reset binary logs and gtids;
create function bug8409() returns int begin reset slave;
create function bug8409() returns int begin flush privileges;
create function bug8409() returns int begin flush tables with read lock;
create function bug8409() returns int begin flush tables;
create function bug8409() returns int begin flush logs;
create function bug8409() returns int begin flush status;
create function bug8409() returns int begin flush user_resources;


--
-- BUG#9529: Stored Procedures: No Warning on truncation of procedure name
--           during creation.
-- BUG#17015: Routine name truncation not an error
--            When we started using utf8mb3 for mysql.proc, this limit appeared
--            to be higher, but in reality the names were truncated.
--error ER_TOO_LONG_IDENT
create procedure bug9529_901234567890123456789012345678901234567890123456789012345()
begin
end|

-- Check the upper limit, just to make sure.
create procedure bug17015_0123456789012345678901234567890123456789012345678901234()
begin
end|

--replace_column 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show procedure status like 'bug17015%'|
drop procedure bug17015_0123456789012345678901234567890123456789012345678901234|


--
-- BUG#10969: Stored procedures: crash if default() function
--
--error ER_WRONG_COLUMN_NAME
create procedure bug10969()
begin
  declare s1 int default 0;
  select default(s1) from t30;

-- This should work
create procedure bug10969()
begin
  declare s1 int default 0;
  select default(t30.s1) from t30;

drop procedure bug10969|


drop table t1|

delimiter ;

-- BUG#9814: Closing a cursor that is not open 
create table t1(f1 int);
create table t2(f1 int);
CREATE PROCEDURE SP001()
P1: BEGIN
  DECLARE ENDTABLE INT DEFAULT 0;

  SET ENDTABLE=0;
  SET TEMP_SUM=0;
  SET TEMP_NUM=0;
  
  OPEN C1;
          SET TEMP_SUM=TEMP_NUM+TEMP_SUM;
          FETCH C1 INTO TEMP_NUM;
  END WHILE;
  SELECT TEMP_SUM;
  SELECT 'end of proc';
END P1|
delimiter ;
drop procedure SP001;
drop table t1, t2;

-- Bug #11394 "Recursion in SP crash server" and bug #11600 "Stored
-- procedures: crash with function calling itself".
-- We have to disable recursion since in many cases LEX and many
-- Item's can't be used in reentrant way nowdays.
delimiter |;
drop function if exists bug11394|
drop function if exists bug11394_1|
drop function if exists bug11394_2|
drop procedure if exists bug11394|
--enable_warnings
create function bug11394(i int) returns int
begin
  if i <= 0 then
    return 0;
    return (i in (100, 200, bug11394(i-1), 400));
  end if;
select bug11394(2)|
drop function bug11394|
create function bug11394_1(i int) returns int
begin
  if i <= 0 then
    return 0;
    return (select bug11394_1(i-1));
  end if;
select bug11394_1(2)|
drop function bug11394_1|
-- Note that the following should be allowed since it does not contains
-- recursion
create function bug11394_2(i int) returns int return i|
select bug11394_2(bug11394_2(10))|
drop function bug11394_2|
create procedure bug11394(i int, j int)
begin
  if i > 0 then
    call bug11394(i - 1,(select 1));
  end if;
set @@max_sp_recursion_depth=10|
call bug11394(2, 1)|
set @@max_sp_recursion_depth=default|
drop procedure bug11394|
delimiter ;


--
-- BUG 12490 (Packets out of order if calling HELP CONTENTS from Stored Procedure)
--
--error ER_SP_BADSTATEMENT
CREATE PROCEDURE BUG_12490() HELP CONTENTS;
CREATE FUNCTION BUG_12490() RETURNS INT HELP CONTENTS;
CREATE TABLE t_bug_12490(a int);
CREATE TRIGGER BUG_12490 BEFORE UPDATE ON t_bug_12490 FOR EACH ROW HELP CONTENTS;
DROP TABLE t_bug_12490;

--
-- Bug#11834 "Re-execution of prepared statement with dropped function
-- crashes server". Also tests handling of prepared stmts which use
-- stored functions but does not require prelocking.
--
--disable_warnings
drop function if exists bug11834_1;
drop function if exists bug11834_2;
create function bug11834_1() returns int return 10;
create function bug11834_2() returns int return bug11834_1();
drop function bug11834_1;

-- NOTE! The error we get from the below query indicates that the sp bug11834_2
-- does not exist(this is wrong but can be accepted)
-- This behaviour has been reported as bug#21294
--error ER_SP_DOES_NOT_EXIST
execute stmt;
drop function bug11834_2;

--
-- Bug#12953 "Stored procedures: crash if OPTIMIZE TABLE in function"
--
delimiter |;
CREATE FUNCTION bug12953() RETURNS INT
BEGIN
  OPTIMIZE TABLE t1;

--
-- Bug##12995 "Inside function "Table 't4' was not locked with LOCK TABLES"
--
delimiter |;
CREATE FUNCTION bug12995() RETURNS INT
BEGIN
  HANDLER t1 OPEN;
CREATE FUNCTION bug12995() RETURNS INT
BEGIN
  HANDLER t1 READ FIRST;
CREATE FUNCTION bug12995() RETURNS INT
BEGIN
  HANDLER t1 CLOSE;
SELECT bug12995()|
delimiter ;


--
-- BUG#12712: SET AUTOCOMMIT should fail within SP/functions/triggers
--
--disable_warnings
drop procedure if exists bug12712;
drop function if exists bug12712;
create procedure bug12712()
  set session autocommit = 0;

select @@autocommit;
set @au = @@autocommit;
select @@autocommit;
set session autocommit = @au;
create function bug12712()
  returns int
begin
  call bug12712();

-- Can't...
--error ER_SP_CANT_SET_AUTOCOMMIT
set @x = bug12712()|
drop procedure bug12712|
drop function bug12712|
--error ER_SP_CANT_SET_AUTOCOMMIT
create function bug12712()
    returns int
begin
  set session autocommit = 0;
create function bug12712()
    returns int
begin
  set @@autocommit = 0;
create function bug12712()
    returns int
begin
  set local autocommit = 0;
create trigger bug12712
  before insert on t1 for each row set session autocommit = 0;

--
-- BUG#9367: Stored procedures: client hang after "show warnings"
--
--disable_testcase BUG--0000
create table t1 (s1 int);
select s1 from t1;
create procedure bug9367()
begin
  declare v int;
  select v;
drop procedure bug9367;
drop table t1;

--
-- BUG#13510: Setting password local variable changes current password
--
delimiter |;
drop procedure if exists bug13510_1|
drop procedure if exists bug13510_2|
drop procedure if exists bug13510_3|
drop procedure if exists bug13510_4|
--enable_warnings

--error ER_SP_BAD_VAR_SHADOW
create procedure bug13510_1()
begin
  declare password varchar(10);

  set password = 'foo1';
  select password;

-- Check that an error message is sent
--error ER_PARSE_ERROR
set names='foo2'|

--error ER_SP_BAD_VAR_SHADOW
create procedure bug13510_2()
begin
  declare names varchar(10);

  set names = 'foo2';
  select names;

create procedure bug13510_3()
begin
  declare password varchar(10);

  set `password` = 'foo3';
  select password;

create procedure bug13510_4()
begin
  declare names varchar(10);

  set `names` = 'foo4';
  select names;

drop procedure bug13510_3|
drop procedure bug13510_4|


--
-- Test that statements which implicitly commit transaction are prohibited
-- in stored function and triggers. Attempt to create function or trigger
-- containing such statement should produce error (includes test for
-- bug #13627).
--

CREATE TABLE t1 (a int)|
-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN DROP TRIGGER test1;
CREATE FUNCTION bug_13627_f() returns int BEGIN DROP TRIGGER test1;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create table t2 (a int);
CREATE FUNCTION bug_13627_f() returns int BEGIN create table t2 (a int);

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create index t1_i on t1 (a);
CREATE FUNCTION bug_13627_f() returns int BEGIN create index t1_i on t1 (a);

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN alter table t1 add column  b int;
CREATE FUNCTION bug_13627_f() returns int BEGIN alter table t1 add column  b int;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN rename table t1 to t2;
CREATE FUNCTION bug_13627_f() returns int BEGIN rename table t1 to t2;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN truncate table t1;
CREATE FUNCTION bug_13627_f() returns int BEGIN truncate table t1;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop table t1;
CREATE FUNCTION bug_13627_f() returns int BEGIN drop table t1;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop index t1_i on t1;
CREATE FUNCTION bug_13627_f() returns int BEGIN drop index t1_i on t1;

-- error ER_SP_BADSTATEMENT
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN unlock tables;
CREATE FUNCTION bug_13627_f() returns int BEGIN unlock tables;

-- error ER_SP_BADSTATEMENT
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN LOCK TABLE t1 READ;
CREATE FUNCTION bug_13627_f() returns int BEGIN LOCK TABLE t1 READ;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create database mysqltest;
CREATE FUNCTION bug_13627_f() returns int BEGIN create database mysqltest;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop database mysqltest;
CREATE FUNCTION bug_13627_f() returns int BEGIN drop database mysqltest;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create user 'mysqltest_1';
CREATE FUNCTION bug_13627_f() returns int BEGIN create user 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER bug21975 BEFORE INSERT ON t1 FOR EACH ROW BEGIN grant select on t1 to 'mysqltest_1';
CREATE FUNCTION bug21975() returns int BEGIN grant select on t1 to 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER bug21975 BEFORE INSERT ON t1 FOR EACH ROW BEGIN revoke select on t1 from 'mysqltest_1';
CREATE FUNCTION bug21975() returns int BEGIN revoke select on t1 from 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER bug21975 BEFORE INSERT ON t1 FOR EACH ROW BEGIN revoke all privileges on *.* from 'mysqltest_1';
CREATE FUNCTION bug21975() returns int BEGIN revoke all privileges on *.* from 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop user 'mysqltest_1';
CREATE FUNCTION bug_13627_f() returns int BEGIN drop user 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN rename user 'mysqltest_2' to 'mysqltest_1';
CREATE FUNCTION bug_13627_f() returns int BEGIN rename user 'mysqltest_2' to 'mysqltest_1';

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create view v1 as select 1;
CREATE FUNCTION bug_13627_f() returns int BEGIN create view v1 as select 1;

-- error ER_SP_BADSTATEMENT
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN alter view v1 as select 1;
CREATE FUNCTION bug_13627_f() returns int BEGIN alter view v1 as select 1;

-- error ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop view v1;
CREATE FUNCTION bug_13627_f() returns int BEGIN drop view v1;

-- error ER_SP_NO_RECURSIVE_CREATE
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create trigger tr2 before insert on t1 for each row do select 1;
CREATE FUNCTION bug_13627_f() returns int BEGIN create trigger tr2 before insert on t1 for each row do select 1;

-- error ER_SP_NO_DROP_SP
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN drop function bug_13627_f;
CREATE FUNCTION bug_13627_f() returns int BEGIN drop function bug_13627_f;

-- error ER_SP_NO_RECURSIVE_CREATE
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN create function f2 () returns int return 1;
CREATE FUNCTION bug_13627_f() returns int BEGIN create function f2 () returns int return 1;

CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW
  BEGIN
    CREATE TEMPORARY TABLE t2 (a int);
    DROP TEMPORARY TABLE t2;
  END |
CREATE FUNCTION bug_13627_f() returns int
  BEGIN
    CREATE TEMPORARY TABLE t2 (a int);
    DROP TEMPORARY TABLE t2;
    return 1;
  END |

drop table t1|
drop function bug_13627_f|

delimiter ;

-- BUG#12329: "Bogus error msg when executing PS with stored procedure after
-- SP was re-created". See also test for related bug#13399 in trigger.test
drop function if exists bug12329;
create table t1 as select 1 a;
create table t2 as select 1 a;
create function bug12329() returns int return (select a from t1);
drop function bug12329;
create function bug12329() returns int return (select a+100 from t2);
select bug12329();
drop function bug12329;
drop table t1, t2;

--
-- Bug#13514 "server crash when create a stored procedure before choose a
-- database" and
-- Bug#13587 "Server crash when SP is created without database
-- selected"
--
create database mysqltest1;
use mysqltest1;
drop database mysqltest1;
create function f1() returns int return 1;
create procedure p1(out param1 int)
begin
  select count(*) into param1 from t3;
use test;


--
-- BUG#13037: undefined variable in IF cause erroneous error-message
--

--disable_warnings
DROP PROCEDURE IF EXISTS bug13037_p1;
DROP PROCEDURE IF EXISTS bug13037_p2;
DROP PROCEDURE IF EXISTS bug13037_p3;

CREATE PROCEDURE bug13037_p1()
BEGIN
  IF bug13037_foo THEN
    SELECT 1;
  END IF;

CREATE PROCEDURE bug13037_p2()
BEGIN
  SET @bug13037_foo = bug13037_bar;

CREATE PROCEDURE bug13037_p3()
BEGIN
  SELECT bug13037_foo;

DROP PROCEDURE bug13037_p1;
DROP PROCEDURE bug13037_p2;
DROP PROCEDURE bug13037_p3;

--
-- Bug#14569 "editing a stored procedure kills mysqld-nt"
--
create database mysqltest1;
create database mysqltest2;
use mysqltest1;
drop database mysqltest1;
create procedure mysqltest2.p1() select version();
create procedure p2() select version();
use mysqltest2;
drop database mysqltest2;
use test;

--
-- Bug#13012 "SP: REPAIR/BACKUP/RESTORE TABLE crashes the server"
--
delimiter |;
CREATE FUNCTION bug13012() RETURNS INT
BEGIN
  REPAIR TABLE t1;
create table t1 (a int)|
CREATE PROCEDURE bug13012_1() REPAIR TABLE t1|
CREATE FUNCTION bug13012_2() RETURNS INT
BEGIN
  CALL bug13012_1();
SELECT bug13012_2()|
drop table t1|
drop procedure bug13012_1|
drop function bug13012_2|
delimiter ;

--
-- BUG#11555 "Stored procedures: current SP tables locking make 
-- impossible view security". We should not expose names of tables
-- which are implicitly used by view (via stored routines/triggers).
--
-- Note that SQL standard assumes that you simply won't be able drop table
-- and leave some objects (routines/views/triggers) which were depending on
-- it. Such objects should be dropped in advance (by default) or will be
-- dropped simultaneously with table (DROP TABLE with CASCADE clause).
-- So these tests probably should go away once we will implement standard
-- behavior.
--disable_warnings
drop function if exists bug11555_1;
drop function if exists bug11555_2;
drop view if exists v1, v2, v3, v4;
create function bug11555_1() returns int return (select max(i) from t1);
create function bug11555_2() returns int return bug11555_1();
create view v1 as select bug11555_1();
drop view v1;
create view v2 as select bug11555_2();
drop view v2;
create table t1 (i int);
create view v1 as select bug11555_1();
create view v2 as select bug11555_2();
create view v3 as select * from v1;
drop table t1;
select * from v1;
select * from v2;
select * from v3;
create view v4 as select * from v1;
drop view v1, v2, v3, v4;
drop function bug11555_1;
drop function bug11555_2;
create table t1 (i int);
create table t2 (i int);
create trigger t1_ai after insert on t1 for each row insert into t2 values (new.i);
create view v1 as select * from t1;
drop table t2;
insert into v1 values (1);
drop trigger t1_ai;
create function bug11555_1() returns int return (select max(i) from t2);
create trigger t1_ai after insert on t1 for each row set @a:=bug11555_1();
insert into v1 values (2);
drop function bug11555_1;
drop table t1;
drop view v1;

--
-- BUG#15658: Server crashes after creating function as empty string
--

--error ER_SP_WRONG_NAME
create procedure ``() select 1;
create procedure ` `() select 1;
create procedure `bug15658 `() select 1;
create procedure ``.bug15658() select 1;
create procedure `x `.bug15658() select 1;

-- This should work
create procedure ` bug15658`() select 1;
drop procedure ` bug15658`;


--
-- BUG#14270: Stored procedures: crash if load index
--
--disable_warnings
drop function if exists bug14270;
drop table if exists t1;

create table t1 (s1 int primary key);
create function bug14270() returns int
begin
  load index into cache t1;
create function bug14270() returns int
begin
  cache index t1 key (`primary`) in keycache1;

drop table t1;


--
-- BUG#15091: Sp Returns Unknown error in order clause....and 
--            there is no order by clause
--

delimiter |;
create procedure bug15091()
begin
  declare selectstr varchar(6000) default ' ';

  set selectstr = concat(selectstr,
                         ' and ',
                         c.operatorid,
                         'in (',conditionstr, ')');

-- The error message used to be:
--   ERROR 1109 (42S02): Unknown table 'c' in order clause
-- but is now rephrased to something less misleading:
--   ERROR 1109 (42S02): Unknown table 'c' in field list
--error ER_UNKNOWN_TABLE
call bug15091();

drop procedure bug15091;


--
-- BUG#16896: Stored function: unused AGGREGATE-clause in CREATE FUNCTION
--

--error ER_PARSE_ERROR
create aggregate function bug16896() returns int return 1;

--
--
-- BUG#14702: misleading error message when syntax error in CREATE
-- PROCEDURE
--
-- Misleading error message was given when IF NOT EXISTS was used in
-- CREATE PROCEDURE.
--

--error ER_PARSE_ERROR
CREATE IF NOT EXISTS PROCEDURE bug14702()
BEGIN
END;

--
-- BUG#20953: create proc with a create view that uses local
-- vars/params should fail to create
--
-- See test case for what syntax is forbidden in a view.
--

CREATE TABLE t1 (i INT);

-- We do not have to drop this procedure and view because they won't be
-- created.
--error ER_VIEW_SELECT_CLAUSE
CREATE PROCEDURE bug20953() CREATE VIEW v AS SELECT 1 INTO @a;
CREATE PROCEDURE bug20953() CREATE VIEW v AS SELECT 1 INTO DUMPFILE "file";
CREATE PROCEDURE bug20953() CREATE VIEW v AS SELECT 1 INTO OUTFILE "file";
CREATE PROCEDURE bug20953() CREATE VIEW v AS SELECT 1 FROM (SELECT 1) AS d1;
DROP PROCEDURE bug20953;
CREATE PROCEDURE bug20953(i INT) CREATE VIEW v AS SELECT i;
CREATE PROCEDURE bug20953()
BEGIN
  DECLARE i INT;
  CREATE VIEW v AS SELECT i;
END |
delimiter ;

DROP TABLE t1;


--
-- BUG#24491 "using alias from source table in insert ... on duplicate key"
--
--disable_warnings
drop tables if exists t1;
drop procedure if exists bug24491;
create table t1 (id int primary key auto_increment, value varchar(10));
insert into t1 (id, value) values (1, 'FIRST'), (2, 'SECOND'), (3, 'THIRD');
create procedure bug24491()
  insert into t1 (id, value) select * from (select 4 as i, 'FOURTH' as v) as y on duplicate key update v = 'DUP';
drop procedure bug24491;
create procedure bug24491()
  insert into t1 (id, value) select * from (select 4 as id, 'FOURTH' as value) as y on duplicate key update y.value = 'DUP';
drop procedure bug24491;
drop tables t1;

--
-- BUG#18914: Calling certain SPs from triggers fail
--
-- Failing to call a procedure that does implicit commit from a trigger
-- is a correct behaviour, however the error message was misleading.
--
-- DROP TABLE IF EXISTS is also fixed to give correct error instead of
-- "Table doesn't exist". 
--
--disable_warnings
DROP FUNCTION IF EXISTS bug18914_f1;
DROP FUNCTION IF EXISTS bug18914_f2;
DROP PROCEDURE IF EXISTS bug18914_p1;
DROP PROCEDURE IF EXISTS bug18914_p2;
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (i INT);

CREATE PROCEDURE bug18914_p1() CREATE TABLE t2 (i INT);
CREATE PROCEDURE bug18914_p2() DROP TABLE IF EXISTS no_such_table;
CREATE FUNCTION bug18914_f1() RETURNS INT
BEGIN
  CALL bug18914_p1();
END |

CREATE FUNCTION bug18914_f2() RETURNS INT
BEGIN
  CALL bug18914_p2();
END |
delimiter ;

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL bug18914_p1();
INSERT INTO t1 VALUES (1);
SELECT bug18914_f1();
SELECT bug18914_f2();
SELECT * FROM t2;

DROP FUNCTION bug18914_f1;
DROP FUNCTION bug18914_f2;
DROP PROCEDURE bug18914_p1;
DROP PROCEDURE bug18914_p2;
DROP TABLE t1;

--
-- Bug#20713 (Functions will not not continue for SQLSTATE VALUE '42S02')
--

--disable_warnings
drop table if exists bogus_table_20713;
drop function if exists func_20713_a;
drop function if exists func_20713_b;

create table bogus_table_20713( id int(10) not null primary key);
insert into bogus_table_20713 values (1), (2), (3);

create function func_20713_a() returns int(11)
begin
  declare id int;

  set @in_func := 1;
  set id = (select id from bogus_table_20713 where id = 3);
  set @in_func := 2;

create function func_20713_b() returns int(11)
begin
  declare id int;

  set @in_func := 1;
  set id = (select id from bogus_table_20713 where id = 3);
  set @in_func := 2;

set @in_func := 0;
select func_20713_a();
select @in_func;

set @in_func := 0;
select func_20713_b();
select @in_func;

drop table bogus_table_20713;

set @in_func := 0;
select func_20713_a();
select @in_func;

set @in_func := 0;
select func_20713_b();
select @in_func;

drop function if exists func_20713_a;
drop function if exists func_20713_b;

--
-- Bug#25345 (Cursors from Functions)
--

--disable_warnings
drop table if exists table_25345_a;
drop table if exists table_25345_b;
drop procedure if exists proc_25345;
drop function if exists func_25345;
drop function if exists func_25345_b;

create table table_25345_a (a int);
create table table_25345_b (b int);

create procedure proc_25345()
begin
  declare c1 cursor for select a from table_25345_a;

  select 1 as result;
end ||

create function func_25345() returns int(11)
begin
  call proc_25345();
end ||

create function func_25345_b() returns int(11)
begin
  declare c1 cursor for select a from table_25345_a;
end ||

delimiter ;
select func_25345();
select func_25345_b();

drop table table_25345_a;
select func_25345();
select func_25345_b();

drop table table_25345_b;
drop procedure proc_25345;
drop function func_25345;
drop function func_25345_b;

--
-- End of 5.0 tests
--
--echo End of 5.0 tests

--
-- BUG#20701: BINARY keyword should be forbidden in stored routines
--
--
-- This was disabled in 5.1.12. See bug #20701
-- When collation support in SP is implemented, then this test should
-- be removed.
--
--error ER_NOT_SUPPORTED_YET
create function bug20701() returns varchar(25) binary return "test";
create function bug20701() returns varchar(25) return "test";
drop function bug20701;

--
-- Bug#26503 (Illegal SQL exception handler code causes the server to crash)
--

delimiter //;
create procedure proc_26503_error_1()
begin
retry:
  repeat
    begin
      declare continue handler for sqlexception
      begin
        iterate retry;
      end

      select "do something";
    end
  until true end repeat retry;
create procedure proc_26503_error_2()
begin
retry:
  repeat
    begin
      declare continue handler for sqlexception
        iterate retry;

      select "do something";
    end
  until true end repeat retry;
create procedure proc_26503_error_3()
begin
retry:
  repeat
    begin
      declare continue handler for sqlexception
      begin
        leave retry;
      end

      select "do something";
    end
  until true end repeat retry;
create procedure proc_26503_error_4()
begin
retry:
  repeat
    begin
      declare continue handler for sqlexception
        leave retry;

      select "do something";
    end
  until true end repeat retry;


--
-- Bug#29223 declare cursor c for SHOW .....
--

--delimiter |
--error ER_PARSE_ERROR
CREATE PROCEDURE p1()
BEGIN
  DECLARE c char(100);
  select c;

--
-- Bug#29816 Syntactically wrong query fails with misleading error message
--

CREATE DATABASE mysqltest;
USE mysqltest;
DROP DATABASE mysqltest;
SELECT inexistent(), 1 + ,;
SELECT inexistent();
SELECT .inexistent();
SELECT ..inexistent();
USE test;

--
-- Bug#30904 SET PASSWORD statement is non-transactional
--

delimiter |;
create function f1() returns int
begin
 set password = 'foo';
create trigger t1
  before insert on t2 for each row set password = 'foo';

--
-- Bug#30882 Dropping a temporary table inside a stored function may cause a server crash
--

--disable_warnings
drop function if exists f1;
drop function if exists f2;
drop table if exists t1, t2;
create function f1() returns int
begin
 drop temporary table t1;
create temporary table t1 as select f1();
create function f2() returns int
begin
 create temporary table t2 as select f1();
create temporary table t1 as select f2();

drop function f1;
drop function f2;
create function f1() returns int
begin
 drop temporary table t2,t1;
create function f2() returns int
begin
 create temporary table t2 as select f1();
create temporary table t1 as select f2();

drop function f1;
drop function f2;

create temporary table t2(a int);
select * from t2;
create function f2() returns int
begin
 drop temporary table t2;
select f2();

drop function f2;
drop table t2;

--
-- Bug#33983 (Stored Procedures: wrong end <label> syntax is accepted)
--

--disable_warnings
drop procedure if exists proc_33983_a;
drop procedure if exists proc_33983_b;
drop procedure if exists proc_33983_c;
drop procedure if exists proc_33983_d;
create procedure proc_33983_a()
begin
  label1:
    begin
      label2:
      begin
        select 1;
      end label1;
    end;
create procedure proc_33983_b()
begin
  label1:
    repeat
      label2:
      repeat
        select 1;
      until FALSE end repeat label1;
    until FALSE end repeat;
create procedure proc_33983_c()
begin
  label1:
    while TRUE do
      label2:
      while TRUE do
        select 1;
      end while label1;
    end while;
create procedure proc_33983_d()
begin
  label1:
    loop
      label2:
      loop
        select 1;
      end loop label1;
    end loop;

CREATE TABLE t1 (a INT)|
INSERT INTO t1 VALUES (1),(2)|
CREATE PROCEDURE p1(a INT) BEGIN END|
--error ER_SUBQUERY_NO_1_ROW
CALL p1((SELECT * FROM t1))|
DROP PROCEDURE IF EXISTS p1|
DROP TABLE t1|

delimiter ;

--
-- Bug#21801: SQL exception handlers and warnings
--

delimiter |;
create procedure p1()
begin
  create table t1 (a int);
  drop table t1;
drop procedure p1;

--
-- Bug#8759 (Stored Procedures: SQLSTATE '00000' should be illegal)
--

delimiter $$;
create procedure proc_8759()
begin
  declare should_be_illegal condition for sqlstate '00000';
create procedure proc_8759()
begin
  declare continue handler for sqlstate '00000' set @x=0;

--
-- Bug#36510 (Stored Procedures: mysql_error_code 0 should be illegal)
--

delimiter $$;
create procedure proc_36510()
begin
  declare should_be_illegal condition for sqlstate '00123';
create procedure proc_36510()
begin
  declare continue handler for sqlstate '00123' set @x=0;
create procedure proc_36510()
begin
  declare should_be_illegal condition for 0;
create procedure proc_36510()
begin
  declare continue handler for 0 set @x=0;

--
-- Bug#15192: "fatal errors" are caught by handlers in stored procedures
--

set @old_recursion_depth = @@max_sp_recursion_depth;
set @@max_sp_recursion_depth = 255;
create procedure p1(a int)
begin
  declare continue handler for 1436 -- ER_STACK_OVERRUN_NEED_MORE
    select 'exception';
set @@max_sp_recursion_depth = @old_recursion_depth;
drop procedure p1;

--
-- BUG#NNNN: New bug synopsis
--
----disable_warnings
--drop procedure if exists bugNNNN;


--
-- Bug #38159: Function parsing problem generates misleading error message
--

CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1), (2,2);
SELECT MAX (a) FROM t1 WHERE b = 999999;
SELECT AVG (a) FROM t1 WHERE b = 999999;
SELECT non_existent (a) FROM t1 WHERE b = 999999;
DROP TABLE t1;


--
-- Bug #46374 crash, INSERT INTO t1 uses function, function modifies t1
--
CREATE TABLE t1 ( f2 INTEGER, f3 INTEGER );
INSERT INTO t1 VALUES  ( 1, 1 );

CREATE FUNCTION func_1 () RETURNS INTEGER
BEGIN
  INSERT INTO t1 SELECT * FROM t1 ;

-- The bug caused the following INSERT statement to trigger
-- an assertion.   Error 1442 is the correct response
--
--error 1442
INSERT INTO t1 SELECT * FROM (SELECT 2 AS f1, 2 AS f2) AS A WHERE func_1() = 5;

-- Cleanup
DROP FUNCTION func_1;
DROP TABLE t1;

CREATE TABLE t1 (pk INT, b INT, KEY (b));
CREATE ALGORITHM = TEMPTABLE VIEW v1 AS SELECT * FROM t1;

CREATE PROCEDURE p1 (a int) UPDATE IGNORE v1 SET b = a;

ALTER TABLE t1 CHANGE COLUMN b b2 INT;

DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;
SELECT very_long_fn_name_1111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222225555555555555555555555555577777777777777777777777777777777777777777777777777777777777777777777777788888888999999999999999999999();
SELECT very_long_db_name_1111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222225555555555555555555555555577777777777777777777777777777777777777777777777777777777777777777777777788888888999999999999999999999.simple_func();
SELECT db_name.very_long_fn_name_111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222999999999999999999999();
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
DROP PROCEDURE IF EXISTS p4;
DROP PROCEDURE IF EXISTS p5;
DROP PROCEDURE IF EXISTS p6;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

CREATE PROCEDURE p1()
  BEGIN
    SELECT CAST('10x' as unsigned integer);
    SELECT 1;
    CALL p2();

CREATE PROCEDURE p2()
  BEGIN
    SELECT CAST('10x' as unsigned integer);

DROP PROCEDURE p1;
DROP PROCEDURE p2;

CREATE TABLE t1(a INT);

CREATE PROCEDURE p1()
  BEGIN
    DECLARE c INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
    BEGIN
      SET c = c + 1;
      SELECT 'Warning caught!' AS Msg;
    END;
    CALL p2();
    CALL p3();
    CALL p4();
    CALL p5();
    SELECT c;
    SELECT @@warning_count;
    SHOW WARNINGS;

CREATE PROCEDURE p2()
  BEGIN
    SELECT CAST('2x' as unsigned integer);

CREATE PROCEDURE p3()
  BEGIN
    SELECT CAST('3x' as unsigned integer);
    GET DIAGNOSTICS @n = NUMBER;

CREATE PROCEDURE p4()
  BEGIN
    SELECT CAST('4x' as unsigned integer);
    INSERT INTO t1 VALUES(1);

CREATE PROCEDURE p5()
  BEGIN
    SELECT CAST('5x' as unsigned integer);
    CALL p2();

CREATE PROCEDURE p6()
  BEGIN
    SELECT CAST('6x' as unsigned integer);
    SHOW WARNINGS;

CREATE PROCEDURE p7()
  BEGIN
    DECLARE c INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
    BEGIN
      SET c = c + 1;
      SELECT 'Warning caught!' AS Msg;
    END;
    CALL p6();
    SELECT c;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
DROP PROCEDURE p7;

DROP TABLE t1;
SET sql_mode = default;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3);

CREATE PROCEDURE p1()
BEGIN
  DECLARE c CURSOR FOR SELECT a FROM t1;
  
  BEGIN
    DECLARE v1 INT;
    DECLARE v2 INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      SELECT "Error caught (expected)";

    DECLARE EXIT HANDLER FOR NOT FOUND
      SELECT "End of Result Set found!";

    WHILE TRUE DO
      FETCH c INTO v1, v2;
    END WHILE;

  SELECT a INTO @foo FROM t1 LIMIT 1;

DROP PROCEDURE p1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1 (a INT, b INT NOT NULL);

CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING SELECT 'warning';
  INSERT INTO t1 VALUES (CAST('10 ' AS SIGNED), NULL);

DROP TABLE t1;
DROP PROCEDURE p1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (1, 2);

CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
BEGIN
  DECLARE EXIT HANDLER FOR SQLWARNING
    SET NEW.a = 10;

  SET NEW.a = 99999999999;

UPDATE t1 SET b = 20;

SELECT * FROM t1;

DROP TRIGGER t1_bu;
DROP TABLE t1;
SET sql_mode = default;

CREATE TABLE t1(a INT PRIMARY KEY);
INSERT INTO t1 VALUES(1);
SET @sql_mode_saved = @@sql_mode;
SET sql_mode = traditional;

CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
    SELECT 'warning caught (expected)';
  
  INSERT IGNORE INTO t1 VALUES (1);

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'error caught (unexpected)';
  
  INSERT IGNORE INTO t1 VALUES (1);

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP TABLE t1;
SET sql_mode = @sql_mode_saved;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1(x SMALLINT, y SMALLINT, z SMALLINT);
CREATE TABLE t2(a SMALLINT, b SMALLINT, c SMALLINT,
                d SMALLINT, e SMALLINT, f SMALLINT);

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  INSERT INTO t2(a, b, c) VALUES(99999, 99999, 99999);

CREATE TRIGGER t1_ai AFTER INSERT ON t1 FOR EACH ROW
  INSERT INTO t2(d, e, f) VALUES(99999, 99999, 99999);

CREATE PROCEDURE p1()
  INSERT INTO t1 VALUES(99999, 99999, 99999);

-- What happened before the patch was:
--  - INSERT INTO t1 added 3 warnings about overflow in 'x', 'y' and 'z' columns;
--  - t1_bi run and added 3 warnings about overflow in 'a', 'b' and 'c' columns;
--  - t1_ai run and added 3 warnings about overflow in 'd', 'e' and 'f' columns;
--  - INSERT INTO t1 adds 3 warnings about overflow in 'x', 'y' and 'z' columns;
--  - t1_bi adds 3 warnings about overflow in 'a', 'b' and 'c' columns;
--  - The warnings added by triggers are cleared;
--  - t1_ai run and added 3 warnings about overflow in 'd', 'e' and 'f' columns;
--  - The warnings added by triggers are cleared;
DROP TABLE t1;
DROP TABLE t2;
DROP PROCEDURE p1;

CREATE TABLE t1(x SMALLINT, y SMALLINT, z SMALLINT);
CREATE TABLE t2(a SMALLINT, b SMALLINT, c SMALLINT NOT NULL);

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  INSERT INTO t2 VALUES(
    CAST('111111X' AS SIGNED),
    CAST('222222X' AS SIGNED),
    NULL);

CREATE PROCEDURE p1()
  INSERT INTO t1 VALUES(99999, 99999, 99999);
DROP TABLE t1;
DROP TABLE t2;
DROP PROCEDURE p1;
SET sql_mode = default;

--
-- Structure of SQL-block:
-- BEGIN
--   <Handler declaration block>
--   <Statement block>
-- END
--
-- Scope of Handler-decl-block is Statement-block.
-- I.e. SQL-conditions thrown in the Handler-decl-block can not be handled by
-- the same block, only by outer SQL-blocks.
--
-- This rule is recursive, i.e. if a Handler-decl-block has nested SQL-blocks,
-- the SQL-conditions from those nested blocks can not be handled by the this
-- Handler-decl-block, only by outer SQL-blocks.
--

delimiter |;

CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;

    SELECT 'B1' AS BlockId;
    BEGIN

      SELECT 'B2' AS BlockId;
      BEGIN
        SELECT 'B3' AS BlockId;
        SIGNAL SQLSTATE '01000';
      END;

    END;

CREATE PROCEDURE p3()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    SELECT 'H3' AS HandlerId;

CREATE PROCEDURE p4()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    SELECT 'H3' AS HandlerId;

CREATE PROCEDURE p5()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    DECLARE CONTINUE HANDLER FOR SQLWARNING
      SELECT 'H3' AS HandlerId;

    SIGNAL SQLSTATE '01000';

CREATE PROCEDURE p6()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SELECT 'H1' AS HandlerId;
    SIGNAL SQLSTATE 'HY000';

  SELECT 'S1' AS SignalId;

CREATE PROCEDURE p7()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    SELECT 'H1' AS HandlerId;
    SIGNAL SQLSTATE '01000';

  SELECT 'S1' AS SignalId;

CREATE PROCEDURE p8()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    SIGNAL SQLSTATE '01000';

  SELECT 'S1' AS SignalId;

CREATE PROCEDURE p9()
BEGIN

  DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
    SELECT 'Wrong:H1:1' AS HandlerId;
    SELECT 'Wrong:H1:2' AS HandlerId;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
      SELECT 'Wrong:H2:1' AS HandlerId;

    DECLARE CONTINUE HANDLER FOR SQLWARNING
      SELECT 'Wrong:H2:2' AS HandlerId;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN

      DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
        SELECT 'Wrong:H3:1' AS HandlerId;

      DECLARE CONTINUE HANDLER FOR SQLWARNING
        SELECT 'Wrong:H3:2' AS HandlerId;

      DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN

        DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
          SELECT 'Wrong:H4:1' AS HandlerId;

        DECLARE CONTINUE HANDLER FOR SQLWARNING
          SELECT 'Wrong:H4:2' AS HandlerId;

        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN

          DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
            SELECT 'Wrong:H5:1' AS HandlerId;

          DECLARE CONTINUE HANDLER FOR SQLWARNING
            SELECT 'Wrong:H5:2' AS HandlerId;

          DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
          BEGIN

            DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
              SELECT 'Wrong:H6:1' AS HandlerId;

            DECLARE CONTINUE HANDLER FOR SQLWARNING
              SELECT 'Wrong:H6:2' AS HandlerId;

            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
              SELECT 'H2' AS HandlerId;
              SIGNAL SQLSTATE '01000';
            END;

            SELECT 'S6' AS SignalId;
            SIGNAL SQLSTATE 'HY000';
          END;

          SELECT 'S5' AS SignalId;
          SIGNAL SQLSTATE 'HY000';

        END;

        SELECT 'S4' AS SignalId;
        SIGNAL SQLSTATE 'HY000';

      END;

      SELECT 'S3' AS SignalId;
      SIGNAL SQLSTATE 'HY000';

    END;

    SELECT 'S2' AS SignalId;
    SIGNAL SQLSTATE 'HY000';

  SELECT 'S1' AS SignalId;

CREATE PROCEDURE p10()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    BEGIN
      BEGIN

        DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
          SELECT 'Wrong:H1:1' AS HandlerId;

        DECLARE CONTINUE HANDLER FOR SQLWARNING
          SELECT 'Wrong:H1:2' AS HandlerId;

        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN

          DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
            SELECT 'Wrong:H2:1' AS HandlerId;

          DECLARE CONTINUE HANDLER FOR SQLWARNING
            SELECT 'Wrong:H2:2' AS HandlerId;

          DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
          BEGIN

            DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
              SELECT 'Wrong:H3:1' AS HandlerId;

            DECLARE CONTINUE HANDLER FOR SQLWARNING
              SELECT 'Wrong:H3:2' AS HandlerId;

            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN

              DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
                SELECT 'Wrong:H4:1' AS HandlerId;

              DECLARE CONTINUE HANDLER FOR SQLWARNING
                SELECT 'Wrong:H4:2' AS HandlerId;

              DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
              BEGIN

                DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
                  SELECT 'Wrong:H5:1' AS HandlerId;

                DECLARE CONTINUE HANDLER FOR SQLWARNING
                  SELECT 'Wrong:H5:2' AS HandlerId;

                DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
                BEGIN

                  DECLARE CONTINUE HANDLER FOR SQLSTATE '01000'
                    SELECT 'Wrong:H6:1' AS HandlerId;

                  DECLARE CONTINUE HANDLER FOR SQLWARNING
                    SELECT 'Wrong:H6:2' AS HandlerId;

                  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
                  BEGIN
                    SELECT 'H2' AS HandlerId;
                    SIGNAL SQLSTATE '01000';
                  END;

                  SELECT 'S6' AS SignalId;
                  SIGNAL SQLSTATE 'HY000';
                END;

                SELECT 'S5' AS SignalId;
                SIGNAL SQLSTATE 'HY000';

              END;

              SELECT 'S4' AS SignalId;
              SIGNAL SQLSTATE 'HY000';

            END;

            SELECT 'S3' AS SignalId;
            SIGNAL SQLSTATE 'HY000';

          END;

          SELECT 'S2' AS SignalId;
          SIGNAL SQLSTATE 'HY000';

        END;

        SELECT 'S1' AS SignalId;
        SIGNAL SQLSTATE 'HY000';

      END;
    END;

CREATE PROCEDURE p11()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SELECT 'H1' AS HandlerId;
    SELECT 'H2' AS HandlerId;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '01000', 1249
    BEGIN
      DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SELECT 'H3' AS HandlerId;

      DECLARE CONTINUE HANDLER FOR SQLWARNING
        SELECT 'H4' AS HandlerId;

      BEGIN
        SELECT 'H5' AS HandlerId;

        SELECT 'S3' AS SignalId;
        SIGNAL SQLSTATE 'HY000';

        SELECT 'S4' AS SignalId;
        SIGNAL SQLSTATE '22003';

        SELECT 'S5' AS SignalId;
        SIGNAL SQLSTATE '01000' SET MYSQL_ERRNO = 1249;
      END;
    END;

    SELECT 'S6' AS SignalId;
    SIGNAL SQLSTATE 'HY000';

    SELECT 'S7' AS SignalId;
    SIGNAL SQLSTATE '22003';

    SELECT 'S8' AS SignalId;
    SIGNAL SQLSTATE '01000' SET MYSQL_ERRNO = 1249;

  SELECT 'S1' AS SignalId;

  SELECT 'S2' AS SignalId;

CREATE PROCEDURE p12()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '01001'
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '01001'
    BEGIN
      DECLARE CONTINUE HANDLER FOR SQLSTATE '01001'
      BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '01001'
        BEGIN
          DECLARE CONTINUE HANDLER FOR SQLSTATE '01001'
          BEGIN
            SELECT 'H1:5' AS HandlerId;
            SIGNAL SQLSTATE '01002';
          END;
          SELECT 'H1:4' AS HandlerId;
          SIGNAL SQLSTATE '01001';
        END;
        SELECT 'H1:3' AS HandlerId;
        SIGNAL SQLSTATE '01001';
      END;
      SELECT 'H1:2' AS HandlerId;
      SIGNAL SQLSTATE '01001';
    END;
    SELECT 'H1:1' AS HandlerId;
    SIGNAL SQLSTATE '01001';
    SELECT 'OK' AS Msg;

    DECLARE CONTINUE HANDLER FOR SQLWARNING
    BEGIN
      DECLARE CONTINUE HANDLER FOR SQLWARNING
      BEGIN
        DECLARE CONTINUE HANDLER FOR SQLWARNING
        BEGIN
          DECLARE CONTINUE HANDLER FOR SQLWARNING
          BEGIN
            DECLARE CONTINUE HANDLER FOR SQLWARNING
            BEGIN
              SELECT 'H2:5' AS HandlerId;
              SIGNAL SQLSTATE '01001';
            END;
            SELECT 'H2:4' AS HandlerId;
            SIGNAL SQLSTATE '01000';
          END;
          SELECT 'H2:3' AS HandlerId;
          SIGNAL SQLSTATE '01000';
        END;
        SELECT 'H2:2' AS HandlerId;
        SIGNAL SQLSTATE '01000';
      END;
      SELECT 'H2:1' AS HandlerId;
      SIGNAL SQLSTATE '01000';
    END;

    --######################################################

    SELECT 'Throw 01000' AS Msg;
    SIGNAL SQLSTATE '01000';

CREATE PROCEDURE p13()
BEGIN
  
  DECLARE CONTINUE HANDLER FOR SQLWARNING
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLWARNING
    BEGIN
      DECLARE EXIT HANDLER FOR SQLWARNING
      BEGIN
        SELECT 'EXIT handler 3' AS Msg;
      END;

      SELECT 'CONTINUE handler 2: 1' AS Msg;
      SIGNAL SQLSTATE '01000';
      SELECT 'CONTINUE handler 2: 2' AS Msg;
    END;

    SELECT 'CONTINUE handler 1: 1' AS Msg;
    SIGNAL SQLSTATE '01000';
    SELECT 'CONTINUE handler 1: 2' AS Msg;

  SELECT 'Throw 01000' AS Msg;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
DROP PROCEDURE p7;
DROP PROCEDURE p8;
DROP PROCEDURE p9;
DROP PROCEDURE p10;
DROP PROCEDURE p11;
DROP PROCEDURE p12;
DROP PROCEDURE p13;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(msg VARCHAR(255));
CREATE FUNCTION f1() RETURNS INT
BEGIN

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION               -- handler 1
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION             -- handler 2
    BEGIN
      INSERT INTO t1 VALUE('WRONG: Inside H2');
      RETURN 2;
    END;

    INSERT INTO t1 VALUE('CORRECT: Inside H1');
    RETURN 1;
    DECLARE CONTINUE HANDLER FOR SQLWARNING               -- handler 3
    BEGIN
      INSERT INTO t1 VALUE('WRONG: Inside H3');
      RETURN 3;
    END;

    INSERT INTO t1 VALUE('CORRECT: Calling f1()');
    RETURN f1();

  INSERT INTO t1 VALUE('WRONG: Returning 10');
SELECT f1();
SELECT * FROM t1;

DROP FUNCTION f1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
DROP PROCEDURE IF EXISTS p4;
DROP PROCEDURE IF EXISTS p5;

CREATE TABLE t1(a CHAR, b CHAR, c CHAR);
CREATE TABLE t2(a SMALLINT, b SMALLINT, c SMALLINT);

CREATE PROCEDURE p1()
BEGIN
  DECLARE EXIT HANDLER FOR SQLWARNING
    SELECT 'Warning caught' AS msg;

  -- The INSERT below raises 3 SQL-conditions (warnings). The EXIT HANDLER
  -- above must be invoked once (for one condition), but all three conditions
  -- must be cleared from the Diagnostics Area.

  INSERT INTO t1 VALUES('qqqq', 'ww', 'eee');

  -- The following INSERT will not be executed, because of the EXIT HANDLER.

  INSERT INTO t1 VALUES('zzz', 'xx', 'yyyy');
SELECT * FROM t1|

--echo
--echo -- Check that SQL-conditions for which SQL-handler has *not* been
--echo -- invoked, are *still* cleared from the Diagnostics Area.
--echo

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1292
    SELECT 'Warning 1292 caught' AS msg;

  -- The following INSERT raises 6 SQL-warnings with code 1292,
  -- and 3 SQL-warnings with code 1264. The CONTINUE HANDLER above must be
  -- invoked once, and all nine SQL-warnings must be cleared from
  -- the Diagnostics Area.

  INSERT INTO t2
  SELECT
    CAST(CONCAT(CAST('1X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('2X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('3X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER);

CREATE PROCEDURE p3()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1292
    SELECT 'Warning 1292 caught' AS msg;
    SELECT 'Warning 1264 caught' AS msg;

  -- The following INSERT raises 6 SQL-warnings with code 1292,
  -- and 3 SQL-warnings with code 1264. Only one of the CONTINUE HANDLERs above
  -- must be called, and only once. The SQL Standard does not define, which one
  -- should be invoked.

  INSERT INTO t2
  SELECT
    CAST(CONCAT(CAST('1X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('2X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('3X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER);

CREATE PROCEDURE p4()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1292
    SELECT 'Warning 1292 caught' AS msg;
    SELECT 'Warning 1264 caught' AS msg;

  -- The following INSERT raises 4 SQL-warnings with code 1292,
  -- and 3 SQL-warnings with code 1264. Only one of the CONTINUE HANDLERs above
  -- must be called, and only once. The SQL Standard does not define, which one
  -- should be invoked.

  INSERT INTO t2
  SELECT
    CAST(999999 AS SIGNED INTEGER),
    CAST(CONCAT(CAST('2X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('3X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER);

CREATE PROCEDURE p5()
BEGIN
  DECLARE EXIT HANDLER FOR 1292
  BEGIN
    SELECT 'Handler for 1292' AS Msg;
    SIGNAL SQLSTATE '01000' SET MYSQL_ERRNO = 1234;
    SHOW WARNINGS;

  INSERT INTO t2
  SELECT
    CAST(999999 AS SIGNED INTEGER),
    CAST(CONCAT(CAST('2X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('3X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER);

CREATE PROCEDURE p6()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1292
  BEGIN
    SHOW WARNINGS;
    SELECT 'Handler for 1292' Msg;

  INSERT INTO t2
  SELECT
    CAST(CONCAT(CAST('1X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('2X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER),
    CAST(CONCAT(CAST('3X' AS UNSIGNED INTEGER), '999999XX') AS SIGNED INTEGER);
DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;
DROP TABLE t1;
DROP TABLE t2;
SET sql_mode = default;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

CREATE PROCEDURE p1()
BEGIN
  DECLARE var1 INTEGER DEFAULT 'string';

CREATE PROCEDURE p2()
BEGIN
  DECLARE EXIT HANDLER FOR SQLWARNING SELECT 'H2';
DROP PROCEDURE p1;
DROP PROCEDURE p2;
SET sql_mode = default;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
CREATE PROCEDURE p1()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'triggered p1';
  -- This will trigger an error.
  SIGNAL SQLSTATE 'HY000';

CREATE PROCEDURE p2()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLWARNING SELECT 'triggered p2';
  -- This will trigger a warning.
  SIGNAL SQLSTATE '01000';

SET @old_max_error_count=  @@session.max_error_count;
SET SESSION max_error_count= 0;
SET SESSION max_error_count= @old_max_error_count;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1, 2);

CREATE FUNCTION f1() RETURNS INTEGER
BEGIN
  DECLARE v VARCHAR(5) DEFAULT -1;
  SELECT b FROM t1 WHERE a = 2 INTO v;

CREATE FUNCTION f2() RETURNS INTEGER
BEGIN
  DECLARE v INTEGER;
    SET @msg = 'Handler activated.';

  SELECT f1() INTO v;

SET @msg = '';
SELECT f2();
SELECT @msg;

DROP FUNCTION f1;
DROP FUNCTION f2;
DROP TABLE t1;
drop function f111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjjkk;
drop function test.f111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjjkk;
drop function mysqltest111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjj.test;

SET @orig_character_set_client = @@character_set_client;
SET character_set_client = utf8mb3;
let $object_name_64= oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo;
let $object_name_65= ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo;
CREATE PROCEDURE test𝌆() SELECT 1;
CREATE FUNCTION test𝌆() RETURNS INT RETURN 1;
DROP PROCEDURE p;
DROP FUNCTION f;
CREATE PROCEDURE p(IN test𝌆 INT) SELECT 1;
CREATE FUNCTION f(test𝌆 INT) RETURNS INT RETURN 1;
let $string_65535= `SELECT REPEAT('n', 65535)`;
let $string_65536= `SELECT REPEAT('n', 65536)`;
DROP PROCEDURE p1;
DROP FUNCTION f1;

CREATE PROCEDURE p1() SELECT 1;
DROP PROCEDURE p1;
CREATE FUNCTION f1() RETURNS INT RETURN 1;
DROP FUNCTION f1;
CREATE PROCEDURE p2() COMMENT 'test𝌆' SELECT 1;
CREATE FUNCTION f2() RETURNS INT COMMENT 'test𝌆' RETURN 1;


CREATE PROCEDURE p2() SELECT 1;
ALTER PROCEDURE p2 COMMENT 'test𝌆';
DROP PROCEDURE p2;
CREATE FUNCTION f2() RETURNS INT RETURN 1;
ALTER FUNCTION f2 COMMENT 'test𝌆';
DROP FUNCTION f2;
SET character_set_client = @orig_character_set_client;

CREATE DATABASE mysqltest;
USE mysqltest;
DROP DATABASE mysqltest;

-- Should return NULL
SELECT DATABASE();

CREATE DATABASE mysqltest;
CREATE FUNCTION mysqltest.f1() RETURNS INT RETURN 0;
CREATE FUNCTION mysqltest.f2() RETURNS INT RETURN f1();

USE mysqltest;
SELECT f1();
SELECT f2();

DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f1;
DROP DATABASE mysqltest;
