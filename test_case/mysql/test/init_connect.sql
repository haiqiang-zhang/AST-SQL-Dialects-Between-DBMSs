
--
-- Test of init_connect variable
--
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--source include/add_anonymous_users.inc

connect (con0,localhost,root,,);
select hex(@a);
select hex(@a);
set global init_connect="set @a=2;
select @a, @b;
set GLOBAL init_connect=DEFAULT;
select @a;
set global init_connect="drop table if exists t1;
insert into t1 values ('\0');
select hex(a) from t1;
set GLOBAL init_connect="adsfsdfsdfs";
select @a;
select @a;
drop table t1;
--

create table t1 (x int);
insert into t1 values (3), (5), (7);
create table t2 (y int);

create user mysqltest1@localhost;
set global init_connect="create procedure p1() select * from t1";
drop procedure p1;
set global init_connect="create procedure p1(x int)\
begin\
  select count(*) from t1;
  select * from t1;
  set @x = x;
select @x;
set global init_connect="call p1(4711)";
select @x;
set global init_connect="drop procedure if exists p1";
create procedure p1(out sum int)
begin
  declare n int default 0;
    begin
      close c;
      set sum = n;
    end;
    begin
      declare x int;

      fetch c into x;
      if x > 3 then
        set n = n + x;
      end if;
    end;
  end loop;
set global init_connect="call p1(@sum)";
select @sum;
drop procedure p1;
create procedure p1(tbl char(10), v int)
begin
  set @s = concat('insert into ', tbl, ' values (?)');
  set @v = v;
set global init_connect="call p1('t1', 11)";
select * from t1;
drop procedure p1;
create function f1() returns int
begin
  declare n int;

  select count(*) into n from t1;
set global init_connect="set @x = f1()";
select @x;
set global init_connect="create view v1 as select f1()";
select * from v1;
set global init_connect="drop view v1";
select * from v1;
drop function f1;

-- We can't test "create trigger", since this requires super privileges
-- in 5.0, but with super privileges, init_connect is not executed.
-- (However, this can be tested in 5.1)
--
--set global init_connect="create trigger trg1\
--  after insert on t2\
--  for each row\
--  insert into t1 values (new.y)";

create trigger trg1
  after insert on t2
  for each row
  insert into t1 values (new.y);

-- Invoke trigger
set global init_connect="insert into t2 values (13), (17), (19)";
select * from t1;

drop trigger trg1;
drop user mysqltest1@localhost;
drop table t1, t2;

CREATE USER user1@localhost PASSWORD EXPIRE;
CREATE USER ''@localhost;
UPDATE mysql.user SET password_expired='Y' WHERE user='' AND host='localhost';
SELECT user, password_expired FROM mysql.user WHERE user='' AND host='localhost';

SET GLOBAL init_connect="set @a=2;

let SEARCH_FILE=$MYSQLTEST_VARDIR/log/mysqld.1.err;
let SEARCH_PATTERN=\[Warning\] \[.*\] init_connect variable is ignored for user: user1 host: localhost due to expired password.;
SELECT @a;
SET PASSWORD = 'abc';
SELECT @a;

let SEARCH_FILE=$MYSQLTEST_VARDIR/log/mysqld.1.err;
let SEARCH_PATTERN=\[Warning\] \[.*\] init_connect variable is ignored for user:  host: localhost due to expired password.;
SELECT @a;

DROP USER user1@localhost;
DROP USER ''@localhost;

-- Set init connect back to the value provided in init_connect-master.opt
-- doesn't matter as server will be restarted
set global init_connect="set @a='a\\0c'";
