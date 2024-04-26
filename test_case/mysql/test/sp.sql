--   go to sp-thread.
-- Tests that uses 'goto' to into sp-goto.test (currently disabled)
-- Tests that require --with-geometry go into sp_gis.test
-- Tests that require multibyte character sets, which are not always available,
--   go into separate files (e.g. sp-ucs2.test)

use test;

-- Test tables
--
-- t1 and t2 are reused throughout the file, and dropped at the end.
-- t3 and up are created and dropped when needed.
--

-- Test needs MyISAM for disable warnings subtest which use engines other than innodb
--source include/have_myisam.inc

--disable_warnings
drop table if exists t1,t2,t3,t4;
drop view if exists v1;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
create table t1 (
	id   char(16) not null default '',
        data int not null
) engine=myisam;
create table t2 (
	s   char(16),
        i   int,
	d   double
) engine=myisam;


-- Single statement, no params.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists foo42;
create procedure foo42()
  insert into test.t1 values ("foo", 42);
select * from t1;
delete from t1;
drop procedure foo42;


-- Single statement, two IN params.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bar;
create procedure bar(x char(16), y int)
  insert into test.t1 values (x, y);
select * from t1;
delete from t1;


-- Now for multiple statements...
delimiter |;

-- Empty statement
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists `empty`|
create procedure `empty`()
begin
end|

call `empty`()|
drop procedure `empty`|

-- Scope test. This is legal (warnings might be possible in the future,
-- but for the time being, we just accept it).
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists scope|
create procedure scope(a int, b float)
begin
  declare b int;
    declare c int;

drop procedure scope|

-- Two statements.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists two|
create procedure two(x1 char(16), x2 char(16), y int)
begin
  insert into test.t1 values (x1, y);
  insert into test.t1 values (x2, y);
select * from t1|
delete from t1|
drop procedure two|


-- Simple test of local variables and SET.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists locset|
create procedure locset(x char(16), y int)
begin
  declare z1, z2 int;
  set z1 = y;
  set z2 = z1+2;
  insert into test.t1 values (x, z2);
select * from t1|
delete from t1|
drop procedure locset|


-- In some contexts local variables are not recognized
-- (and in some, you have to qualify the identifier).
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists setcontext|
create procedure setcontext()
begin
  declare data int default 2;

  insert into t1 (id, data) values ("foo", 1);
  update t1 set id = "kaka", data = 3 where t1.data = data;
select * from t1 order by data|
delete from t1|
drop procedure setcontext|


-- Set things to null
create table t3 ( d date, i int, f double, s varchar(32) )|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists nullset|
create procedure nullset()
begin
  declare ld date;

  set ld = null, li = null, lf = null, ls = null;
  insert into t3 values (ld, li, lf, ls);

  insert into t3 (i, f, s) values ((ld is null), 1,    "ld is null"),
                                  ((li is null), 1,    "li is null"),
				  ((li = 0),     null, "li = 0"),
				  ((lf is null), 1,    "lf is null"),
				  ((lf = 0),     null, "lf = 0"),
				  ((ls is null), 1,    "ls is null");
select * from t3|
drop table t3|
drop procedure nullset|


-- The peculiar (non-standard) mixture of variables types in SET.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists mixset|
create procedure mixset(x char(16), y int)
begin
  declare z int;

  set @z = y, z = 666;
  insert into test.t1 values (x, z);
select id,data,@z from t1|
delete from t1|
drop procedure mixset|


-- Multiple CALL statements, one with OUT parameter.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists zip|
create procedure zip(x char(16), y int)
begin
  declare z int;

-- SET local variables and OUT parameter.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists zap|
create procedure zap(x int, out y int)
begin
  declare z int;
  set z = x+1, y = z;
select * from t1|
delete from t1|
drop procedure zip|
drop procedure bar|

-- Top-level OUT parameter
call zap(7, @zap)|
select @zap|

drop procedure zap|


-- "Deep" calls...
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists c1|
create procedure c1(x int)
  call c2("c", x)|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists c2|
create procedure c2(s char(16), x int)
  call c3(x, s)|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists c3|
create procedure c3(x int, s char(16))
  call c4("level", x, s)|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists c4|
create procedure c4(l char(8), x int, s char(16))
  insert into t1 values (concat(l,s), x)|

call c1(42)|
select * from t1|
delete from t1|
drop procedure c1|
drop procedure c2|
drop procedure c3|
drop procedure c4|

-- INOUT test
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists iotest|
create procedure iotest(x1 char(16), x2 char(16), y int)
begin
  call inc2(x2, y);
  insert into test.t1 values (x1, y);
drop procedure if exists inc2|
create procedure inc2(x char(16), y int)
begin
  call inc(y);
  insert into test.t1 values (x, y);
drop procedure if exists inc|
create procedure inc(inout io int)
  set io = io + 1|

call iotest("io1", "io2", 1)|
select * from t1 order by data desc|
delete from t1|
drop procedure iotest|
drop procedure inc2|

-- Propagating top-level @-vars
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists incr|
create procedure incr(inout x int)
  call inc(x)|

-- Before
select @zap|
call incr(@zap)|
-- After
select @zap|

drop procedure inc|
drop procedure incr|

-- Call-by-value test
--  The expected result is:
--    ("cbv2", 4)
--    ("cbv1", 4711)
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists cbv1|
create procedure cbv1()
begin
  declare y int default 3;
  insert into test.t1 values ("cbv1", y);
drop procedure if exists cbv2|
create procedure cbv2(y1 int, inout y2 int)
begin
  set y2 = 4711;
  insert into test.t1 values ("cbv2", y1);
select * from t1 order by data|
delete from t1|
drop procedure cbv1|
drop procedure cbv2|


-- Subselect arguments

insert into t2 values ("a", 1, 1.1), ("b", 2, 1.2), ("c", 3, 1.3)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists sub1|
create procedure sub1(id char(16), x int)
  insert into test.t1 values (id, x)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists sub2|
create procedure sub2(id char(16))
begin
  declare x int;
  set x = (select sum(t.i) from test.t2 t);
  insert into test.t1 values (id, x);
drop procedure if exists sub3|
create function sub3(i int) returns int deterministic
  return i+1|

call sub1("sub1a", (select 7))|
call sub1("sub1b", (select max(i) from t2))|
--error ER_OPERAND_COLUMNS
call sub1("sub1c", (select i,d from t2 limit 1))|
call sub1("sub1d", (select 1 from (select 1) a))|
call sub2("sub2")|
select * from t1 order by id|
select sub3((select max(i) from t2))|
drop procedure sub1|
drop procedure sub2|
drop function sub3|
delete from t1|
delete from t2|

-- Basic tests of the flow control constructs

-- Just test on 'x'...
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists a0|
create procedure a0(x int)
while x do
  set x = x-1;
  insert into test.t1 values ("a0", x);
end while|

call a0(3)|
select * from t1 order by data desc|
delete from t1|
drop procedure a0|


-- The same, but with a more traditional test.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists a|
create procedure a(x int)
while x > 0 do
  set x = x-1;
  insert into test.t1 values ("a", x);
end while|

call a(3)|
select * from t1 order by data desc|
delete from t1|
drop procedure a|


-- REPEAT
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists b|
create procedure b(x int)
repeat
  insert into test.t1 values (repeat("b",3), x);
  set x = x-1;
select * from t1 order by data desc|
delete from t1|
drop procedure b|


-- Check that repeat isn't parsed the wrong way
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists b2|
create procedure b2(x int)
repeat
  select 1 into outfile 'b2';
  insert into test.t1 values (repeat("b2",3), x);
  set x = x-1;

-- We don't actually want to call it.
drop procedure b2|


-- Labelled WHILE with ITERATE (pointless really)
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists c|
create procedure c(x int)
hmm: while x > 0 do
  insert into test.t1 values ("c", x);
  set x = x-1;
  insert into test.t1 values ("x", x);
end while hmm|

call c(3)|
select * from t1 order by data desc|
delete from t1|
drop procedure c|


-- Labelled WHILE with LEAVE
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists d|
create procedure d(x int)
hmm: while x > 0 do
  insert into test.t1 values ("d", x);
  set x = x-1;
  insert into test.t1 values ("x", x);
end while|

call d(3)|
select * from t1|
delete from t1|
drop procedure d|


-- LOOP, with simple IF statement
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists e|
create procedure e(x int)
foo: loop
  if x = 0 then
    leave foo;
  end if;
  insert into test.t1 values ("e", x);
  set x = x-1;
end loop foo|

call e(3)|
select * from t1 order by data desc|
delete from t1|
drop procedure e|


-- A full IF statement
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists f|
create procedure f(x int)
if x < 0 then
  insert into test.t1 values ("f", 0);
  insert into test.t1 values ("f", 1);
  insert into test.t1 values ("f", 2);
end if|

call f(-2)|
call f(0)|
call f(4)|
select * from t1 order by data|
delete from t1|
drop procedure f|


-- This form of CASE is really just syntactic sugar for IF-ELSEIF-...
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists g|
create procedure g(x int)
case
when x < 0 then
  insert into test.t1 values ("g", 0);
  insert into test.t1 values ("g", 1);
  insert into test.t1 values ("g", 2);
end case|

call g(-42)|
call g(0)|
call g(1)|
select * from t1 order by data|
delete from t1|
drop procedure g|


-- The "simple CASE"
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists h|
create procedure h(x int)
case x
when 0 then
  insert into test.t1 values ("h0", x);
  insert into test.t1 values ("h1", x);
  insert into test.t1 values ("h?", x);
end case|

call h(0)|
call h(1)|
call h(17)|
select * from t1 order by data|
delete from t1|
drop procedure h|


-- It's actually possible to LEAVE a BEGIN-END block
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists i|
create procedure i(x int)
foo:
begin
  if x = 0 then
    leave foo;
  end if;
  insert into test.t1 values ("i", x);
end foo|

call i(0)|
call i(3)|
select * from t1|
delete from t1|
drop procedure i|


-- SELECT with one of more result set sent back to the clinet
insert into t1 values ("foo", 3), ("bar", 19)|
insert into t2 values ("x", 9, 4.1), ("y", -1, 19.2), ("z", 3, 2.2)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists sel1|
create procedure sel1()
begin
  select * from t1 order by data;
drop procedure sel1|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists sel2|
create procedure sel2()
begin
  select * from t1 order by data;
  select * from t2 order by s;
drop procedure sel2|
delete from t1|
delete from t2|

-- SELECT INTO local variables
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_test|
create procedure into_test(x char(16), y int)
begin
  insert into test.t1 values (x, y);
  select id,data into x,y from test.t1 limit 1;
  insert into test.t1 values (concat(x, "2"), y+2);
select * from t1 order by data|
delete from t1|
drop procedure into_test|


-- SELECT INTO with a mix of local and global variables
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_tes2|
create procedure into_test2(x char(16), y int)
begin
  insert into test.t1 values (x, y);
  select id,data into x,@z from test.t1 limit 1;
  insert into test.t1 values (concat(x, "2"), y+2);
select id,data,@z from t1 order by data|
delete from t1|
drop procedure into_test2|


-- SELECT * INTO ... (bug test)
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_test3|
create procedure into_test3()
begin
  declare x char(16);

  select * into x,y from test.t1 limit 1;
  insert into test.t2 values (x, y, 0.0);

insert into t1 values ("into3", 19)|
-- Two call needed for bug test
call into_test3()|
call into_test3()|
select * from t2|
delete from t1|
delete from t2|
drop procedure into_test3|


-- SELECT INTO with no data is a warning ("no data", which we will
-- not see normally). When not caught, execution proceeds.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_test4|
create procedure into_test4()
begin
  declare x int;

  select data into x from test.t1 limit 1;
  insert into test.t3 values ("into4", x);

delete from t1|
create table t3 ( s char(16), d int)|
call into_test4()|
select * from t3|
insert into t1 values ("i4", 77)|
call into_test4()|
select * from t3|
delete from t1|
drop table t3|
drop procedure into_test4|


-- These two (and the two procedures above) caused an assert() to fail in
-- sql_base.cc:lock_tables() at some point.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_outfile|
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
eval create procedure into_outfile(x char(16), y int)
begin
  insert into test.t1 values (x, y);
  select * into outfile "$MYSQLTEST_VARDIR/tmp/spout" from test.t1;
  insert into test.t1 values (concat(x, "2"), y+2);

-- Check that file does not exists
--error 1
--file_exists $MYSQLTEST_VARDIR/tmp/spout
call into_outfile("ofile", 1)|
--remove_file $MYSQLTEST_VARDIR/tmp/spout
delete from t1|
drop procedure into_outfile|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists into_dumpfile|
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
eval create procedure into_dumpfile(x char(16), y int)
begin
  insert into test.t1 values (x, y);
  select * into dumpfile "$MYSQLTEST_VARDIR/tmp/spdump" from test.t1 limit 1;
  insert into test.t1 values (concat(x, "2"), y+2);

-- Check that file does not exists
--error 1
--file_exists $MYSQLTEST_VARDIR/tmp/spdump
call into_dumpfile("dfile", 1)|
--remove_file $MYSQLTEST_VARDIR/tmp/spdump
delete from t1|
drop procedure into_dumpfile|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists create_select|
create procedure create_select(x char(16), y int)
begin
  insert into test.t1 values (x, y);
  create temporary table test.t3 select * from test.t1;
  insert into test.t3 values (concat(x, "2"), y+2);
select * from t1, t3|
drop table t3|
delete from t1|
drop procedure create_select|


-- A minimal, constant FUNCTION.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists e|
create function e() returns double
  return 2.7182818284590452354|

set @e = e()|
select e(), @e|

-- A minimal function with one argument
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists inc|
create function inc(i int) returns int
  return i+1|

select inc(1), inc(99), inc(-71)|

-- A minimal function with two arguments
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists mul|
create function mul(x int, y int) returns int
  return x*y|

select mul(1,1), mul(3,5), mul(4711, 666)|

-- A minimal string function
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists append|
create function append(s1 char(8), s2 char(8)) returns char(16)
  return concat(s1, s2)|

select append("foo", "bar")|

-- A function with flow control
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists fac|
create function fac(n int unsigned) returns bigint unsigned
begin
  declare f bigint unsigned default 1;
    set f = f * n;
    set n = n - 1;
  end while;

select fac(1), fac(2), fac(5), fac(10)|

-- Nested calls
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists fun|
create function fun(d double, i int, u int unsigned) returns double
  return mul(inc(i), fac(u)) / e()|

select fun(2.3, 3, 5)|


-- Various function calls in differen statements

insert into t2 values (append("xxx", "yyy"), mul(4,3), e())|
insert into t2 values (append("a", "b"), mul(2,mul(3,4)), fun(1.7, 4, 6))|

select * from t2 where s = append("a", "b")|
select * from t2 where i = mul(4,3) or i = mul(mul(3,4),2) order by i|
select * from t2 where d = e()|
select * from t2 order by i|
delete from t2|

drop function e|
drop function inc|
drop function mul|
drop function append|
drop function fun|


--
-- CONDITIONs and HANDLERs
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists hndlr1|
create procedure hndlr1(val int)
begin
  declare x int default 0;

  insert into test.t1 values ("hndlr1", val, 2);
  if (x) then
    insert into test.t1 values ("hndlr1", val);
  end if;
select * from t1|
delete from t1|
drop procedure hndlr1|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists hndlr2|
create procedure hndlr2(val int)
begin
  declare x int default 0;
    declare exit handler for sqlstate '21S01' set x = 1;

    insert into test.t1 values ("hndlr2", val, 2);

  insert into test.t1 values ("hndlr2", x);
select * from t1|
delete from t1|
drop procedure hndlr2|


--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists hndlr3|
create procedure hndlr3(val int)
begin
  declare x int default 0;
    declare z int;

    set z = 2 * val;
    set x = 1;

  if val < 10 then
    begin
      declare y int;

      set y = val + 10;
      insert into test.t1 values ("hndlr3", y, 2);
      if x then
        insert into test.t1 values ("hndlr3", y);
      end if;
    end;
  end if;
select * from t1|
delete from t1|
drop procedure hndlr3|


-- Variables might be uninitialized when using handlers
-- (Otherwise the compiler can detect if a variable is not set, but
--  not in this case.)
create table t3 ( id   char(16), data int )|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists hndlr4|
create procedure hndlr4()
begin
  declare x int default 0;

  select data into val from test.t3 where id='z' limit 1;

  insert into test.t3 values ('z', val);
select * from t3|
drop table t3|
drop procedure hndlr4|


--
-- Cursors
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists cur1|
create procedure cur1()
begin
  declare a char(16);
    fetch c into a, b, c;
    if not done then
       insert into test.t1 values (a, b+c);
    end if;

insert into t2 values ("foo", 42, -1.9), ("bar", 3, 12.1), ("zap", 666, -3.14)|
call cur1()|
select * from t1|
drop procedure cur1|

create table t3 ( s char(16), i int )|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists cur2|
create procedure cur2()
begin
  declare done int default 0;
    declare a char(16);
    declare b,c int;

    fetch from c1 into a, b;
    fetch next from c2 into c;
    if not done then
      if b < c then
        insert into test.t3 values (a, b);
      else
        insert into test.t3 values (a, c);
      end if;
    end if;
select * from t3 order by i,s|
delete from t1|
delete from t2|
drop table t3|
drop procedure cur2|


-- The few characteristics we parse
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists chistics|
create procedure chistics()
    language sql
    modifies sql data
    not deterministic
    sql security definer
    comment 'Characteristics procedure test'
  insert into t1 values ("chistics", 1)|

show create procedure chistics|
-- Call it, just to make sure.
call chistics()|
select * from t1|
delete from t1|
alter procedure chistics sql security invoker|
show create procedure chistics|
drop procedure chistics|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists chistics|
create function chistics() returns int
    language sql
    deterministic
    sql security invoker
    comment 'Characteristics procedure test'
  return 42|

show create function chistics|
-- Call it, just to make sure.
select chistics()|
alter function chistics
   no sql
   comment 'Characteristics function test'|
show create function chistics|
drop function chistics|


-- Check mode settings
insert into t1 values ("foo", 1), ("bar", 2), ("zip", 3)|

set @@sql_mode = 'ANSI'|
delimiter $|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists modes$
create procedure modes(out c1 int, out c2 int)
begin
  declare done int default 0;

  select 1 || 2 into c1;
  set c2 = 0;
    fetch c into x;
    if not done then
      set c2 = c2 + 1;
    end if;
set @@sql_mode = ''|

set sql_select_limit = 1|
call modes(@c1, @c2)|
set sql_select_limit = default|

select @c1, @c2|
delete from t1|
drop procedure modes|


-- Check that dropping a database without routines works.
-- (Dropping with routines is tested in sp-security.test)
-- First an empty db.
create database sp_db1|
drop database sp_db1|

-- Again, with a table.
create database sp_db2|
use sp_db2|
-- Just put something in here...
create table t3 ( s char(4), t int )|
insert into t3 values ("abcd", 42), ("dcba", 666)|
use test|
drop database sp_db2|

-- And yet again, with just a procedure.
create database sp_db3|
use sp_db3|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists dummy|
create procedure dummy(out x int)
  set x = 42|
use test|
drop database sp_db3|
-- Check that it's gone
select routine_type, routine_schema, routine_name from information_schema.routines where routine_schema = 'sp_db3'|

-- ROW_COUNT() function after a CALL
-- We test the other cases here too, although it's not strictly SP specific
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists rc|
create procedure rc()
begin
  delete from t1;
  insert into t1 values ("a", 1), ("b", 2), ("c", 3);
select row_count()|
update t1 set data=42 where id = "b";
select row_count()|
delete from t1|
select row_count()|
delete from t1|
select row_count()|
select * from t1|
select row_count()|
drop procedure rc|


--
-- Let us test how well new locking scheme works.
--

-- Let us prepare playground
--disable_warnings
drop function if exists f0|
drop function if exists f1|
drop function if exists f2|
drop function if exists f3|
drop function if exists f4|
drop function if exists f5|
drop function if exists f6|
drop function if exists f7|
drop function if exists f8|
drop function if exists f9|
drop function if exists f10|
drop function if exists f11|
drop function if exists f12_1|
drop function if exists f12_2|
drop view if exists v0|
drop view if exists v1|
drop view if exists v2|
--enable_warnings
delete from t1|
delete from t2|
insert into t1 values ("a", 1), ("b", 2) |
insert into t2 values ("a", 1, 1.0), ("b", 2, 2.0), ("c", 3, 3.0) |

-- Test the simplest function using tables
create function f1() returns int
  return (select sum(data) from t1)|
select f1()|
-- This should work too (and give 2 rows as result)
select id, f1() from t1 order by id|

-- Function which uses two instances of table simultaneously
create function f2() returns int
  return (select data from t1 where data <= (select sum(data) from t1) order by data limit 1)|
select f2()|
select id, f2() from t1 order by id|

-- Function which uses the same table twice in different queries
create function f3() returns int
begin
  declare n int;
  set n:= (select min(data) from t1);
  set m:= (select max(data) from t1);
select f3()|
select id, f3() from t1 order by id|

-- Calling two functions using same table
select f1(), f3()|
select id, f1(), f3() from t1 order by id|

-- Function which uses two different tables
create function f4() returns double 
  return (select d from t1, t2 where t1.data = t2.i and t1.id= "b")|
select f4()|
select s, f4() from t2 order by s|

-- Recursive functions which due to this recursion require simultaneous
-- access to several instance of the same table won't work
create function f5(i int) returns int
begin
  if i <= 0 then
    return 0;
    return (select count(*) from t1 where data = i);
    return (select count(*) + f5( i - 1) from t1 where data = i);
  end if;
select f5(1)|
-- Since currently recursive functions are disallowed ER_SP_NO_RECURSION
-- error will be returned, once we will allow them error about
-- insufficient number of locked tables will be returned instead.
--error ER_SP_NO_RECURSION
select f5(2)|
--error ER_SP_NO_RECURSION
select f5(3)|

-- OTOH this should work 
create function f6() returns int
begin
  declare n int;
  set n:= f1();
create function f7() returns int
  return (select sum(data) from t1 where data <= f1())|
select f6()|
select id, f6() from t1 order by id|

--
-- Let us test how new locking work with views
--
-- The most trivial view
create view v1 (a) as select f1()|
select * from v1|
select id, a from t1, v1 order by id|
select * from v1, v1 as v|
-- A bit more complex construction
create view v2 (a) as select a*10 from v1|
select * from v2|
select id, a from t1, v2 order by id|
select * from v1, v2|

-- Nice example where the same view is used on
-- on different expression levels
create function f8 () returns int
  return (select count(*) from v2)|

select *, f8() from v1|

-- Let us test what will happen if function is missing
drop function f1|
--error ER_VIEW_INVALID
select * from v1|

-- And what will happen if we have recursion which involves
-- views and functions ?
create function f1() returns int
  return (select sum(data) from t1) + (select sum(a) from v1)|
--error ER_SP_NO_RECURSION
select f1()|
--error ER_SP_NO_RECURSION
select * from v1|
--error ER_SP_NO_RECURSION
select * from v2|
-- Back to the normal cases
drop function f1|
create function f1() returns int
  return (select sum(data) from t1)|

-- Let us also test some weird cases where no real tables is used
create function f0() returns int
  return (select * from (select 100) as r)|
select f0()|
select *, f0() from (select 1) as t|
create view v0 as select f0()|
select * from v0|
select *, f0() from v0|

--
-- Let us test how well prelocking works with explicit LOCK TABLES.
--
lock tables t1 read, t1 as t11 read|
-- These should work well
select f3()|
select id, f3() from t1 as t11 order by id|
-- Degenerate cases work too :)
select f0()|
-- But these should not (particularly views should be locked explicitly).
--error ER_TABLE_NOT_LOCKED
select * from v0|
--error ER_TABLE_NOT_LOCKED
select *, f0() from v0, (select 123) as d1|
--error ER_TABLE_NOT_LOCKED
select id, f3() from t1|
--error ER_TABLE_NOT_LOCKED
select f4()|
unlock tables|

-- Tests for handling of temporary tables in functions.
--
-- Unlike for permanent tables we should be able to create, use
-- and drop such tables in functions.
-- 
-- Simplest function using temporary table. It is also test case for bug 
-- #12198 "Temporary table aliasing does not work inside stored functions"
create function f9() returns int
begin
  declare a, b int;
  drop temporary table if exists t3;
  create temporary table t3 (id int);
  insert into t3 values (1), (2), (3);
  set a:= (select count(*) from t3);
  set b:= (select count(*) from t3 t3_alias);
select f9()|
select f9() from t1 limit 1|

-- Function which uses both temporary and permanent tables.
create function f10() returns int
begin
  drop temporary table if exists t3;
  create temporary table t3 (id int);
  insert into t3 select id from t4;
select f10()|
create table t4 as select 1 as id|
select f10()|

-- Practical cases which we don't handle well (yet)
--
-- Function which does not work because of well-known and documented
-- limitation of MySQL. We can't use the several instances of the
-- same temporary table in statement.
create function f11() returns int
begin
  drop temporary table if exists t3;
  create temporary table t3 (id int);
  insert into t3 values (1), (2), (3);
select f11()|
--error ER_CANT_REOPEN_TABLE
select f11() from t1|
-- Test that using a single table instance at a time works
create function f12_1() returns int
begin
  drop temporary table if exists t3;
  create temporary table t3 (id int);
  insert into t3 values (1), (2), (3);
create function f12_2() returns int
  return (select count(*) from t3)|

drop temporary table t3|
select f12_1()|
select f12_1() from t1 limit 1|

-- Cleanup
drop function f0|
drop function f1|
drop function f2|
drop function f3|
drop function f4|
drop function f5|
drop function f6|
drop function f7|
drop function f8|
drop function f9|
drop function f10|
drop function f11|
drop function f12_1|
drop function f12_2|
drop view v0|
drop view v1|
drop view v2|
truncate table t1 |
truncate table t2 |
drop table t4|

-- End of non-bug tests


--
-- Some "real" examples
--

-- fac

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop table if exists t3|
create table t3 (n int unsigned not null primary key, f bigint unsigned)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists ifac|
create procedure ifac(n int unsigned)
begin
  declare i int unsigned default 1;

  if n > 20 then
    set n = 20;
  end if;
    begin
      insert into test.t3 values (i, fac(i));
      set i = i + 1;
    end;
  end while;
select * from t3|
drop table t3|
--replace_column 5 'root@localhost' 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show function status like '%fac'|
drop procedure ifac|
drop function fac|
--replace_column 5 'root@localhost' 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show function status like '%fac'|


-- primes

--disable_warnings ER_BAD_TABLE_ERROR ONCE
drop table if exists t3|

create table t3 (
  i int unsigned not null primary key,
  p bigint unsigned not null
)|

insert into t3 values
 ( 0,   3), ( 1,   5), ( 2,   7), ( 3,  11), ( 4,  13),
 ( 5,  17), ( 6,  19), ( 7,  23), ( 8,  29), ( 9,  31),
 (10,  37), (11,  41), (12,  43), (13,  47), (14,  53),
 (15,  59), (16,  61), (17,  67), (18,  71), (19,  73),
 (20,  79), (21,  83), (22,  89), (23,  97), (24, 101),
 (25, 103), (26, 107), (27, 109), (28, 113), (29, 127),
 (30, 131), (31, 137), (32, 139), (33, 149), (34, 151),
 (35, 157), (36, 163), (37, 167), (38, 173), (39, 179),
 (40, 181), (41, 191), (42, 193), (43, 197), (44, 199)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists opp|
create procedure opp(n bigint unsigned, out pp bool)
begin
  declare r double;

  set r = sqrt(n);
    if s = 45 then
      set b = b+200, s = 0;
    else
      begin
        declare p bigint unsigned;

        select t.p into p from test.t3 t where t.i = s;
        if b+p > r then
          set pp = 1;
          leave again;
        end if;
        if mod(n, b+p) = 0 then
          set pp = 0;
          leave again;
        end if;
        set s = s+1;
      end;
    end if;
  end loop;
drop procedure if exists ip|
create procedure ip(m int unsigned)
begin
  declare p bigint unsigned;

  set i=45, p=201;
    begin
      declare pp bool default 0;

      call opp(p, pp);
      if pp then
        insert into test.t3 values (i, p);
        set i = i+1;
      end if;
      set p = p+2;
    end;
  end while;

-- This isn't the fastest way in the world to compute prime numbers, so
-- don't be too ambitious. ;
--    i      p
--   ---   ----
--    45    211
--   100    557
--   199   1229
select * from t3 where i=45 or i=100 or i=199|
drop table t3|
drop procedure opp|
drop procedure ip|
--replace_column 5 'root@localhost' 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show procedure status where name like '%p%' and db='test'|


--
-- Comment & suid
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bar|
create procedure bar(x char(16), y int)
 comment "111111111111" sql security invoker
 insert into test.t1 values (x, y)|
--replace_column 5 'root@localhost' 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show procedure status like 'bar'|
alter procedure bar comment "2222222222" sql security definer|
alter procedure bar comment "3333333333"|
alter procedure bar|
show create procedure bar|
--replace_column 5 'root@localhost' 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
show procedure status like 'bar'|
drop procedure bar|

--
-- rexecution
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists p1|
create procedure p1 ()
  select (select s1 from t3) from t3|

create table t3 (s1 int)|

call p1()|
insert into t3 values (1)|
call p1()|
drop procedure p1|
drop table t3|

--
-- backticks
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists foo|
create function `foo` () returns int
  return 5|
select `foo` ()|
drop function `foo`|

--
-- Implicit LOCK/UNLOCK TABLES for table access in functions
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists t1max|
create function t1max() returns int
begin
  declare x int;
  select max(data) into x from t1;

insert into t1 values ("foo", 3), ("bar", 2), ("zip", 5), ("zap", 1)|
select t1max()|
drop function t1max|

create table t3 (
  v char(16) not null primary key,
  c int unsigned not null
)|

create function getcount(s char(16)) returns int
begin
  declare x int;

  select count(*) into x from t3 where v = s;
  if x = 0 then
    insert into t3 values (s, 1);
    update t3 set c = c+1 where v = s;
  end if;
select * from t1 where data = getcount("bar")|
select * from t3|
select getcount("zip")|
select getcount("zip")|
select * from t3|
select getcount(id) from t1 where data = 3|
select getcount(id) from t1 where data = 5|
select * from t3|
drop table t3|
drop function getcount|


-- Test cases for different combinations of condition handlers in nested
-- begin-end blocks in stored procedures.
--
-- The SQL standard document says:
-- "8) If there is a general <handler declaration> and a specific
-- <handler declaration> for the same <condition value> in the same scope, then
-- only the specific <handler declaration> is associated with that
-- <condition value>."

-- A general handler declaration has SQLWARNING + SQLEXCEPTION + NOT FOUND.
-- A specific handler declaration has SQLSTATE, condition name, or (for MySQL)
-- an errno.
--
-- So when there are multiple handlers in the same scope, they're all
-- applicable, but the most specific handler should be activated. Notice the
-- standard's exact words: "in the same scope". A specific handler declaration
-- in an outer scope must not be activated instead of a general handler
-- declaration in the inner scope. Previously that was not the case in MySQL.
--
-- Note also that '02000' is more specific than NOT FOUND;
drop table if exists t3|
drop procedure if exists h_ee|
drop procedure if exists h_es|
drop procedure if exists h_en|
drop procedure if exists h_ew|
drop procedure if exists h_ex|
drop procedure if exists h_se|
drop procedure if exists h_ss|
drop procedure if exists h_sn|
drop procedure if exists h_sw|
drop procedure if exists h_sx|
drop procedure if exists h_ne|
drop procedure if exists h_ns|
drop procedure if exists h_nn|
drop procedure if exists h_we|
drop procedure if exists h_ws|
drop procedure if exists h_ww|
drop procedure if exists h_xe|
drop procedure if exists h_xs|
drop procedure if exists h_xx|
--enable_warnings

-- smallint    - to get out of range warnings
-- primary key - to get constraint errors
create table t3 (a smallint primary key)|

insert into t3 (a) values (1)|

create procedure h_ee()
    deterministic
begin
  declare continue handler for 1062 -- ER_DUP_ENTRY
    select 'Outer (bad)' as 'h_ee';
    declare continue handler for 1062 -- ER_DUP_ENTRY
        select 'Inner (good)' as 'h_ee';

    insert into t3 values (1);

create procedure h_es()
    deterministic
begin
  declare continue handler for 1062 -- ER_DUP_ENTRY
    select 'Outer (bad)' as 'h_es';
    -- integrity constraint violation
    declare continue handler for sqlstate '23000'
      select 'Inner (good)' as 'h_es';

    insert into t3 values (1);

create procedure h_en()
    deterministic
begin
  declare continue handler for 1329 -- ER_SP_FETCH_NO_DATA
    select 'Outer (bad)' as 'h_en';
    declare x int;
    declare continue handler for sqlstate '02000' -- no data
      select 'Inner (good)' as 'h_en';

    select a into x from t3 where a = 42;

create procedure h_ew()
    deterministic
begin
  declare continue handler for 1264 -- ER_WARN_DATA_OUT_OF_RANGE
    select 'Outer (bad)' as 'h_ew';
    declare continue handler for sqlwarning
      select 'Inner (good)' as 'h_ew';

    insert into t3 values (123456789012);
  delete from t3;
  insert into t3 values (1);

create procedure h_ex()
    deterministic
begin
  declare continue handler for 1062 -- ER_DUP_ENTRY
    select 'Outer (bad)' as 'h_ex';
    declare continue handler for sqlexception
      select 'Inner (good)' as 'h_ex';

    insert into t3 values (1);

create procedure h_se()
    deterministic
begin
  -- integrity constraint violation
  declare continue handler for sqlstate '23000' 
    select 'Outer (bad)' as 'h_se';
    declare continue handler for 1062 -- ER_DUP_ENTRY
      select 'Inner (good)' as 'h_se';

    insert into t3 values (1);

create procedure h_ss()
    deterministic
begin
  -- integrity constraint violation
  declare continue handler for sqlstate '23000' 
    select 'Outer (bad)' as 'h_ss';
    -- integrity constraint violation
    declare continue handler for sqlstate '23000' 
      select 'Inner (good)' as 'h_ss';

    insert into t3 values (1);

create procedure h_sn()
    deterministic
begin
  -- Note: '02000' is more specific than NOT FOUND ;
  --       there might be other not found states 
  declare continue handler for sqlstate '02000' -- no data
    select 'Outer (bad)' as 'h_sn';
    declare x int;
    declare continue handler for not found
      select 'Inner (good)' as 'h_sn';

    select a into x from t3 where a = 42;

create procedure h_sw()
    deterministic
begin
  -- data exception - numeric value out of range
  declare continue handler for sqlstate '22003'
    select 'Outer (bad)' as 'h_sw';
    declare continue handler for sqlwarning
      select 'Inner (good)' as 'h_sw';

    insert into t3 values (123456789012);
  delete from t3;
  insert into t3 values (1);

create procedure h_sx()
    deterministic
begin
  -- integrity constraint violation
  declare continue handler for sqlstate '23000' 
    select 'Outer (bad)' as 'h_sx';
    declare continue handler for sqlexception
      select 'Inner (good)' as 'h_sx';

    insert into t3 values (1);

create procedure h_ne()
    deterministic
begin
  declare continue handler for not found
    select 'Outer (bad)' as 'h_ne';
    declare x int;
    declare continue handler for 1329 -- ER_SP_FETCH_NO_DATA
      select 'Inner (good)' as 'h_ne';

    select a into x from t3 where a = 42;

create procedure h_ns()
    deterministic
begin
  declare continue handler for not found
    select 'Outer (bad)' as 'h_ns';
    declare x int;
    declare continue handler for sqlstate '02000' -- no data
      select 'Inner (good)' as 'h_ns';

    select a into x from t3 where a = 42;

create procedure h_nn()
    deterministic
begin
  declare continue handler for not found
    select 'Outer (bad)' as 'h_nn';
    declare x int;
    declare continue handler for not found
      select 'Inner (good)' as 'h_nn';

    select a into x from t3 where a = 42;

create procedure h_we()
    deterministic
begin
  declare continue handler for sqlwarning
    select 'Outer (bad)' as 'h_we';
    declare continue handler for 1264 -- ER_WARN_DATA_OUT_OF_RANGE
      select 'Inner (good)' as 'h_we';

    insert into t3 values (123456789012);
  delete from t3;
  insert into t3 values (1);

create procedure h_ws()
    deterministic
begin
  declare continue handler for sqlwarning
    select 'Outer (bad)' as 'h_ws';
    -- data exception - numeric value out of range
    declare continue handler for sqlstate '22003'
      select 'Inner (good)' as 'h_ws';

    insert into t3 values (123456789012);
  delete from t3;
  insert into t3 values (1);

create procedure h_ww()
    deterministic
begin
  declare continue handler for sqlwarning
    select 'Outer (bad)' as 'h_ww';
    declare continue handler for sqlwarning
      select 'Inner (good)' as 'h_ww';

    insert into t3 values (123456789012);
  delete from t3;
  insert into t3 values (1);

create procedure h_xe()
    deterministic
begin
  declare continue handler for sqlexception
    select 'Outer (bad)' as 'h_xe';
    declare continue handler for 1062 -- ER_DUP_ENTRY
      select 'Inner (good)' as 'h_xe';

    insert into t3 values (1);

create procedure h_xs()
    deterministic
begin
  declare continue handler for sqlexception
    select 'Outer (bad)' as 'h_xs';
    -- integrity constraint violation
    declare continue handler for sqlstate '23000'
      select 'Inner (good)' as 'h_xs';

    insert into t3 values (1);

create procedure h_xx()
    deterministic
begin
  declare continue handler for sqlexception
    select 'Outer (bad)' as 'h_xx';
    declare continue handler for sqlexception
      select 'Inner (good)' as 'h_xx';

    insert into t3 values (1);

drop table t3|
drop procedure h_ee|
drop procedure h_es|
drop procedure h_en|
drop procedure h_ew|
drop procedure h_ex|
drop procedure h_se|
drop procedure h_ss|
drop procedure h_sn|
drop procedure h_sw|
drop procedure h_sx|
drop procedure h_ne|
drop procedure h_ns|
drop procedure h_nn|
drop procedure h_we|
drop procedure h_ws|
drop procedure h_ww|
drop procedure h_xe|
drop procedure h_xs|
drop procedure h_xx|


--
-- Test cases for old bugs
--

--
-- BUG#822
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug822|
create procedure bug822(a_id char(16), a_data int)
begin
  declare n int;
  select count(*) into n from t1 where id = a_id and data = a_data;
  if n = 0 then
    insert into t1 (id, data) values (a_id, a_data);
  end if;

delete from t1|
call bug822('foo', 42)|
call bug822('foo', 42)|
call bug822('bar', 666)|
select * from t1 order by data|
delete from t1|
drop procedure bug822|

--
-- BUG#1495
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1495|
create procedure bug1495()
begin
  declare x int;

  select data into x from t1 order by id limit 1;
  if x > 10 then
    insert into t1 values ("less", x-10);
    insert into t1 values ("more", x+10);
  end if;

insert into t1 values ('foo', 12)|
call bug1495()|
delete from t1 where id='foo'|
insert into t1 values ('bar', 7)|
call bug1495()|
delete from t1 where id='bar'|
select * from t1 order by data|
delete from t1|
drop procedure bug1495|

--
-- BUG#1547
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1547|
create procedure bug1547(s char(16))
begin
  declare x int;

  select data into x from t1 where s = id limit 1;
  if x > 10 then
    insert into t1 values ("less", x-10);
    insert into t1 values ("more", x+10);
  end if;

insert into t1 values ("foo", 12), ("bar", 7)|
call bug1547("foo")|
call bug1547("bar")|
select * from t1 order by id|
delete from t1|
drop procedure bug1547|

--
-- BUG#1656
--
--disable_warnings ER_BAD_TABLE_ERROR ONCE
drop table if exists t70|
create table t70 (s1 int,s2 int)|
insert into t70 values (1,2)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1656|
create procedure bug1656(out p1 int, out p2 int)
  select * into p1, p1 from t70|

call bug1656(@1, @2)|
select @1, @2|
drop table t70|
drop procedure bug1656|

--
-- BUG#1862
--
create table t3(a int)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1862|
create procedure bug1862()
begin
  insert into t3 values(2);
select * from t3|
drop table t3|
drop procedure bug1862|

--
-- BUG#1874
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1874|
create procedure bug1874()
begin
  declare x int;
  select max(data) into x from t1;
  insert into t2 values ("max", x, 0);
  select min(data) into x from t1;
  insert into t2 values ("min", x, 0);
  select sum(data) into x from t1;
  insert into t2 values ("sum", x, 0);
  select avg(data) into y from t1;
  insert into t2 values ("avg", 0, y);

insert into t1 (data) values (3), (1), (5), (9), (4)|
call bug1874()|
select * from t2 order by i|
delete from t1|
delete from t2|
drop procedure bug1874|

--
-- BUG#2260
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2260|
create procedure bug2260()
begin
  declare v1 int;
  set @x2 = 2;
select @x2|
drop procedure bug2260|

--
-- BUG#2267 "Lost connect if stored procedure has SHOW FUNCTION STATUS"
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2267_1|
create procedure bug2267_1()
begin
  show procedure status where db='test';
drop procedure if exists bug2267_2|
create procedure bug2267_2()
begin
  show function status where db='test';
drop procedure if exists bug2267_3|
create procedure bug2267_3()
begin
  show create procedure bug2267_1;
drop procedure if exists bug2267_4|
drop function if exists bug2267_4|
--enable_warnings
create procedure bug2267_4()
begin
  show create function bug2267_4;
create function bug2267_4() returns int return 100|

--replace_column 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
call bug2267_1()|
--replace_column 6 '0000-00-00 00:00:00' 7 '0000-00-00 00:00:00'
call bug2267_2()|
call bug2267_3()|
call bug2267_4()|

drop procedure bug2267_1|
drop procedure bug2267_2|
drop procedure bug2267_3|
drop procedure bug2267_4|
drop function bug2267_4|

--
-- BUG#2227
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2227|
create procedure bug2227(x int)
begin
  declare y float default 2.6;

  select 1.3, x, y, 42, z;
drop procedure bug2227|

--
-- BUG#2614 "Stored procedure with INSERT ... SELECT that does not
--           contain any tables crashes server"
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2614|
create procedure bug2614()
begin
  drop table if exists t3;
  create table t3 (id int default '0' not null);
  insert into t3 select 12;
  insert into t3 select * from t3;
drop table t3|
drop procedure bug2614|

--
-- BUG#2674
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug2674|
create function bug2674() returns int
  return @@sort_buffer_size|

set @osbs = @@sort_buffer_size|
set @@sort_buffer_size = 262000|
select bug2674()|
drop function bug2674|
set @@sort_buffer_size = @osbs|

--
-- BUG#3259
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3259_1 |
create procedure bug3259_1 () begin end|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists BUG3259_2 |
create procedure BUG3259_2 () begin end|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists Bug3259_3 |
create procedure Bug3259_3 () begin end|

call BUG3259_1()|
call BUG3259_1()|
call bug3259_2()|
call Bug3259_2()|
call bug3259_3()|
call bUG3259_3()|

drop procedure bUg3259_1|
drop procedure BuG3259_2|
drop procedure BUG3259_3|

--
-- BUG#2772
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug2772|
create function bug2772() returns char(10) character set latin2
  return 'a'|

select bug2772()|
drop function bug2772|

--
-- BUG#2780
--
create table t3 (s1 smallint)|

insert into t3 values (123456789012)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2780|
create procedure bug2780()
begin
  declare exit handler for sqlwarning set @x = 1;

  set @x = 0;
  insert into t3 values (123456789012);
  insert into t3 values (0);
select @x|
select * from t3|

drop procedure bug2780|
drop table t3|

--
-- BUG#1863
--
create table t3 (content varchar(10) )|
insert into t3 values ("test1")|
insert into t3 values ("test2")|
create table t4 (f1 int, rc int, t3 int)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug1863|
create procedure bug1863(in1 int)
begin 

  declare ind int default 0;

  drop temporary table if exists temp_t1;
  create temporary table temp_t1 (
    f1 int auto_increment, f2 varchar(20), primary key (f1)
  );

  insert into temp_t1 (f2) select content from t3;

  select f2 into t3 from temp_t1 where f1 = 10;

  if (rc) then
       insert into t4 values (1, rc, t3);
  end if;

  insert into t4 values (2, rc, t3);
select * from t4|

drop procedure bug1863|
drop temporary table temp_t1;
drop table t3, t4|

--
-- BUG#2656
--

create table t3 ( 
  OrderID  int not null,
  MarketID int,
  primary key (OrderID)
)|

create table t4 ( 
  MarketID int not null,
  Market varchar(60),
  Status char(1),
  primary key (MarketID)
)|

insert t3 (OrderID,MarketID) values (1,1)|
insert t3 (OrderID,MarketID) values (2,2)|
insert t4 (MarketID,Market,Status) values (1,"MarketID One","A")|
insert t4 (MarketID,Market,Status) values (2,"MarketID Two","A")|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2656_1|
create procedure bug2656_1()
begin 
  select
    m.Market
  from  t4 m JOIN t3 o 
        ON o.MarketID != 1 and o.MarketID = m.MarketID;
end |

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2656_2|
create procedure bug2656_2()
begin 
  select
    m.Market
  from  
    t4 m, t3 o
  where       
    m.MarketID != 1 and m.MarketID = o.MarketID;
        
end |

call bug2656_1()|
call bug2656_1()|
call bug2656_2()|
call bug2656_2()|
drop procedure bug2656_1|
drop procedure bug2656_2|
drop table t3, t4|


--
-- BUG#3426
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3426|
create procedure bug3426(in_time int unsigned, out x int)
begin
  if in_time is null then
    set @stamped_time=10;
    set x=1;
    set @stamped_time=in_time;
    set x=2;
  end if;

-- so that from_unixtime() has a deterministic result
set time_zone='+03:00';
select @i, from_unixtime(@stamped_time, '%d-%m-%Y %h:%i:%s') as time|
call bug3426(NULL, @i)|
select @i, from_unixtime(@stamped_time, '%d-%m-%Y %h:%i:%s') as time|
-- Clear SP cache
alter procedure bug3426 sql security invoker|
call bug3426(NULL, @i)|
select @i, from_unixtime(@stamped_time, '%d-%m-%Y %h:%i:%s') as time|
call bug3426(1000, @i)|
select @i, from_unixtime(@stamped_time, '%d-%m-%Y %h:%i:%s') as time|

drop procedure bug3426|

--
-- BUG#3734
--
create table t3 (
  id int unsigned auto_increment not null primary key,
  title VARCHAR(200),
  body text,
  fulltext (title,body)
)|

insert into t3 (title,body) values
  ('MySQL Tutorial','DBMS stands for DataBase ...'),
  ('How To Use MySQL Well','After you went through a ...'),
  ('Optimizing MySQL','In this tutorial we will show ...'),
  ('1001 MySQL Tricks','1. Never run mysqld as root. 2. ...'),
  ('MySQL vs. YourSQL','In the following database comparison ...'),
  ('MySQL Security','When configured properly, MySQL ...')|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3734 |
create procedure bug3734 (param1 varchar(100))
  select * from t3 where match (title,body) against (param1)|

call bug3734('database')|
call bug3734('Security')|

drop procedure bug3734|
drop table t3|

--
-- BUG#3863
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3863|
create procedure bug3863()
begin
  set @a = 0;
    set @a = @a + 1;
  end while;
select @a|
call bug3863()|
select @a|

drop procedure bug3863|

--
-- BUG#2460
--

create table t3 (
  id int(10) unsigned not null default 0,
  rid int(10) unsigned not null default 0,
  msg text not null,
  primary key (id),
  unique key rid (rid, id)
)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2460_1|
create procedure bug2460_1(in v int)
begin
    ( select n0.id from t3 as n0 where n0.id = v )
  union
    ( select n0.id from t3 as n0, t3 as n1
        where n0.id = n1.rid and n1.id = v )
  union
    ( select n0.id from t3 as n0, t3 as n1, t3 as n2
        where n0.id = n1.rid and n1.id = n2.rid and n2.id = v );
insert into t3 values (1, 1, 'foo'), (2, 1, 'bar'), (3, 1, 'zip zap')|
call bug2460_1(2)|
call bug2460_1(2)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2460_2|
create procedure bug2460_2()
begin
  drop table if exists t3;
  create temporary table t3 (s1 int);
  insert into t3 select 1 union select 1;
select * from t3|

drop procedure bug2460_1|
drop procedure bug2460_2|
drop table t3|


--
-- BUG#2564
--
set @@sql_mode = ''|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2564_1|
create procedure bug2564_1()
    comment 'Joe''s procedure'
  insert into `t1` values ("foo", 1)|

set @@sql_mode = 'ANSI_QUOTES'|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2564_2|
create procedure bug2564_2()
  insert into "t1" values ('foo', 1)|

delimiter $|
set @@sql_mode = ''$
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug2564_3$
create function bug2564_3(x int, y int) returns int
  return x || y$

set @@sql_mode = 'ANSI'$
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug2564_4$
create function bug2564_4(x int, y int) returns int
  return x || y$
delimiter |$

set @@sql_mode = ''|
show create procedure bug2564_1|
show create procedure bug2564_2|
show create function bug2564_3|
show create function bug2564_4|

drop procedure bug2564_1|
drop procedure bug2564_2|
drop function bug2564_3|
drop function bug2564_4|

--
-- BUG#3132
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug3132|
create function bug3132(s char(20)) returns char(50)
  return concat('Hello, ', s, '!')|

select bug3132('Bob') union all select bug3132('Judy')|
drop function bug3132|

--
-- BUG#3843
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3843|
create procedure bug3843()
  analyze table t1|

-- Testing for packets out of order
call bug3843()|
call bug3843()|
select 1+2|

drop procedure bug3843|

--
-- BUG#3368
--
create table t3 ( s1 char(10) )|
insert into t3 values ('a'), ('b')|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3368|
create procedure bug3368(v char(10))
begin
  select group_concat(v) from t3;
drop procedure bug3368|
drop table t3|

--
-- BUG#4579
--
create table t3 (f1 int, f2 int)|
insert into t3 values (1,1)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4579_1|
create procedure bug4579_1 ()
begin
  declare sf1 int;

  select f1 into sf1 from t3 where f1=1 and f2=1;
  update t3 set f2 = f2 + 1 where f1=1 and f2=1;
drop procedure if exists bug4579_2|
create procedure bug4579_2 ()
begin
end|

call bug4579_1()|
call bug4579_1()|
call bug4579_1()|

drop procedure bug4579_1|
drop procedure bug4579_2|
drop table t3|

--
-- BUG#2773: Function's data type ignored in stored procedures
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug2773|

create function bug2773() returns int return null|
create table t3 as select bug2773()|
show create table t3|
drop table t3|
drop function bug2773|

--
-- BUG#3788: Stored procedure packet error
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3788|

create function bug3788() returns date return cast("2005-03-04" as date)|
select bug3788()|
drop function bug3788|

create function bug3788() returns binary(1) return 5|
select bug3788()|
drop function bug3788|
 

--
-- BUG#4726
--
create table t3 (f1 int, f2 int, f3 int)|
insert into t3 values (1,1,1)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4726|
create procedure bug4726()
begin
   declare tmp_o_id INT;

   while tmp_d_id <= 2 do
   begin
     select f1 into tmp_o_id from t3 where f2=1 and f3=1;
     set tmp_d_id = tmp_d_id + 1;
   end while;

drop procedure bug4726|
drop table t3|

--
-- BUG#4318
--

-- Don't know if HANDLER commands can work with SPs, or at all.
--disable_testcase BUG--0000
create table t3 (s1 int)|
insert into t3 values (3), (4)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4318|
create procedure bug4318()
  handler t3 read next|

handler t3 open|
-- Expect no results, as tables are closed, but there shouldn't be any errors
call bug4318()|
call bug4318()|
handler t3 close|

drop procedure bug4318|
drop table t3|
--enable_testcase

--
-- BUG#4902: Stored procedure with SHOW WARNINGS leads to packet error
--
-- Added tests for most other show commands we could find too.
-- (Skipping those already tested, and the ones depending on optional handlers.)
--
-- Note: This will return a large number of results of different formats,
--       which makes it impossible to filter with --replace_column.
--       It's possible that some of these are not deterministic across
--       platforms. If so, just remove the offending command.
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4902|
-- The below flag is set in order to allow larger results
-- from SELECT's from SHOW statements in procedure bug4902.
set SQL_BIG_SELECTS=1|
create procedure bug4902()
begin
  show charset like 'foo';

drop procedure bug4902|

--
-- BUG#4904
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4904|
create procedure bug4904()
begin
  declare continue handler for sqlstate 'HY000' begin end;

  create table t2 as select * from t3;

-- error 1146
call bug4904()|

drop procedure bug4904|

create table t3 (s1 char character set latin1, s2 char character set latin2)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4904|
create procedure bug4904 ()
begin
  declare continue handler for sqlstate 'HY000' begin end;

  select s1 from t3 union select s2 from t3;

drop procedure bug4904|
drop table t3|

--
-- BUG#336
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug336|
create procedure bug336(out y int)
begin
  declare x int;
  set x = (select sum(t.data) from test.t1 t);
  set y = x;

insert into t1 values ("a", 2), ("b", 3)|
call bug336(@y)|
select @y|
delete from t1|
drop procedure bug336|

--
-- BUG#3157
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug3157|
create procedure bug3157()
begin
  if exists(select * from t1) then
    set @n= @n + 1;
  end if;
  if (select count(*) from t1) then
    set @n= @n + 1;
  end if;

set @n = 0|
insert into t1 values ("a", 1)|
call bug3157()|
select @n|
delete from t1|
drop procedure bug3157|

--
-- BUG#5251: mysql changes creation time of a procedure/function when altering
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5251|
create procedure bug5251()
begin
end|

select created into @c1 from information_schema.routines
  where routine_schema='test' and routine_name='bug5251'|
--sleep 2
alter procedure bug5251 comment 'foobar'|
select count(*) from information_schema.routines
  where routine_schema='test' and routine_name='bug5251' and created = @c1|

drop procedure bug5251|

--
-- BUG#5279: Stored procedure packets out of order if CHECKSUM TABLE
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5251|
create procedure bug5251()
  checksum table t1|

call bug5251()|
call bug5251()|
drop procedure bug5251|

--
-- BUG#5287: Stored procedure crash if leave outside loop
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5287|
create procedure bug5287(param1 int)
label1:
  begin
    declare c cursor for select 5;

    loop
      if param1 >= 0 then
        leave label1;
      end if;
    end loop;
drop procedure bug5287|


--
-- BUG#5307: Stored procedure allows statement after BEGIN ... END
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5307|
create procedure bug5307()
begin
end;
select @x|
drop procedure bug5307|

--
-- BUG#5258: Stored procedure modified date is 0000-00-00
-- (This was a design flaw)
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5258|
create procedure bug5258()
begin
end|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5258_aux|
create procedure bug5258_aux()
begin
  declare c, m char(19);

  select created,last_altered into c,m from information_schema.routines where routine_name = 'bug5258';
  if c = m then
    select 'Ok';
    select c, m;
  end if;

drop procedure bug5258|
drop procedure bug5258_aux|

--
-- BUG#4487: Stored procedure connection aborted if uninitialized char
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug4487|
create function bug4487() returns char
begin
  declare v char;

select bug4487()|
drop function bug4487|


--
-- BUG#4941: Stored procedure crash fetching null value into variable.
--
--disable_warnings
drop procedure if exists bug4941|
drop procedure if exists bug4941|
--enable_warnings
create procedure bug4941(out x int)
begin
  declare c cursor for select i from t2 limit 1;

insert into t2 values (null, null, null)|
set @x = 42|
call bug4941(@x)|
select @x|
delete from t1|
drop procedure bug4941|

--
-- BUG#4905: Stored procedure doesn't clear for "Rows affected"
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4905|

create table t3 (s1 int,primary key (s1))|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug4905|
create procedure bug4905()
begin
  declare v int;

  insert into t3 values (1);
select row_count()|
call bug4905()|
select row_count()|
call bug4905()|
select row_count()|
select * from t3|

drop procedure bug4905|
drop table t3|

--
-- BUG#6022: Stored procedure shutdown problem with self-calling function.
--

-- Until we implement support for recursive stored functions.
--disable_testcase BUG--0000
create function bug6022(x int) returns int
begin
  if x < 0 then
    return 0;
    return bug6022(x-1);
  end if;

select bug6022(5)|
drop function bug6022|
--enable_testcase

--
-- BUG#6029: Stored procedure specific handlers should have priority
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug6029|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug6029|
create procedure bug6029()
begin
  declare exit handler for 1136  select '1136';

  insert into t3 values (1);
  insert into t3 values (1,2);
 
create table t3 (s1 int, primary key (s1))|
insert into t3 values (1)|
call bug6029()|
delete from t3|
call bug6029()|

drop procedure bug6029|
drop table t3|

--
-- BUG#8540: Local variable overrides an alias
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8540|

create procedure bug8540()
begin
  declare x int default 1;
  select x as y, x+0 as z;
drop procedure bug8540|

--
-- BUG#6642: Stored procedure crash if expression with set function
--
create table t3 (s1 int)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug6642|

create procedure bug6642()
  select abs(count(s1)) from t3|

call bug6642()|
call bug6642()|
drop procedure bug6642|

--
-- BUG#7013: Stored procedure crash if group by ... with rollup
--
insert into t3 values (0),(1)|
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug7013|
create procedure bug7013()
  select s1,count(s1) from t3 group by s1 with rollup|
call bug7013()|
call bug7013()|
drop procedure bug7013|

--
-- BUG#7743: 'Lost connection to MySQL server during query' on Stored Procedure
--
--disable_warnings ER_BAD_TABLE_ERROR ONCE
drop table if exists t4|
create table t4 (
  a mediumint(8) unsigned not null auto_increment,
  b smallint(5) unsigned not null,
  c char(32) not null,
  primary key  (a)
) engine=myisam default charset=latin1|
insert into t4 values (1, 2, 'oneword')|
insert into t4 values (2, 2, 'anotherword')|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug7743|
create procedure bug7743 ( searchstring char(28) )
begin
  declare var mediumint(8) unsigned;
  select a into var from t4 where b = 2 and c = binary searchstring limit 1;
  select var;
drop procedure bug7743|
drop table t4|

--
-- BUG#7992: SELECT .. INTO variable .. within Stored Procedure crashes
--           the server
--
delete from t3|
insert into t3 values(1)|
drop procedure if exists bug7992_1|
drop procedure if exists bug7992_2|
create procedure bug7992_1()
begin
  declare i int;
  select max(s1)+1 into i from t3;
create procedure bug7992_2()
  insert into t3 (s1) select max(t4.s1)+1 from t3 as t4|

call bug7992_1()|
call bug7992_1()|
call bug7992_2()|
call bug7992_2()|

drop procedure bug7992_1|
drop procedure bug7992_2|
drop table t3|

--
-- BUG#8116: calling simple stored procedure twice in a row results
--           in server crash
--
create table t3 (  userid bigint(20) not null default 0 )|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8116|
create procedure bug8116(in _userid int)
   select * from t3 where userid = _userid|

call bug8116(42)|
call bug8116(42)|
drop procedure bug8116|
drop table t3|

--
-- BUG#6857: current_time() in STORED PROCEDURES
--
--disable_warnings 
drop procedure if exists bug6857|
--enable_warnings
create procedure bug6857()
begin
  declare t0, t1 int;
  set t0 = unix_timestamp();
  select sleep(1.1);
  set t1 = unix_timestamp();
  if t1 > t0 then
    set plus = 1;
  end if;
  select plus;

drop procedure bug6857|

--
-- BUG#8757: Stored Procedures: Scope of Begin and End Statements do not
--           work properly.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8757|
create procedure bug8757()
begin
  declare x int;
    declare y int;
    declare c2 cursor for select i from t2 limit 1;

    open c2;
    fetch c2 into y;
    close c2;
    select 2,y;
  select 1,x;

delete from t1|
delete from t2|
insert into t1 values ("x", 1)|
insert into t2 values ("y", 2, 0.0)|

call bug8757()|

delete from t1|
delete from t2|
drop procedure bug8757|


--
-- BUG#8762: Stored Procedures: Inconsistent behavior
--           of DROP PROCEDURE IF EXISTS statement.
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8762|
-- Doesn't exist
drop procedure if exists bug8762;
drop procedure if exists bug8762;
drop procedure bug8762|


--
-- BUG#5240: Stored procedure crash if function has cursor declaration
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug5240|
create function bug5240 () returns int
begin
  declare x int;

delete from t1|
insert into t1 values ("answer", 42)|
select id, bug5240() from t1|
drop function bug5240|

--
-- BUG#7992: rolling back temporary Item tree changes in SP
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists p1|
create table t3(id int)|
insert into t3 values(1)|
create procedure bug7992()
begin
  declare i int;
  select max(id)+1 into i from t3;
drop procedure bug7992|
drop table t3|
delimiter ;

--
-- BUG#8849: problem with insert statement with table alias's
--
-- Rolling back changes to AND/OR structure of ON and WHERE clauses  in SP
-- 

delimiter |;
create table t3 (
  lpitnumber int(11) default null,
  lrecordtype int(11) default null
)|

create table t4 (
  lbsiid int(11) not null default '0',
  ltradingmodeid int(11) not null default '0',
  ltradingareaid int(11) not null default '0',
  csellingprice decimal(19,4) default null,
  primary key  (lbsiid,ltradingmodeid,ltradingareaid)
)|

create table t5 (
  lbsiid int(11) not null default '0',
  ltradingareaid int(11) not null default '0',
  primary key  (lbsiid,ltradingareaid)
)|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8849|
create procedure bug8849()
begin
  insert into t5
  (
   t5.lbsiid,
   t5.ltradingareaid
  )
  select distinct t3.lpitnumber, t4.ltradingareaid
  from
    t4 join t3 on
      t3.lpitnumber = t4.lbsiid
      and t3.lrecordtype = 1
    left join t4 as price01 on
      price01.lbsiid = t4.lbsiid and
      price01.ltradingmodeid = 1 and
      t4.ltradingareaid = price01.ltradingareaid;
drop procedure bug8849|
drop tables t3,t4,t5|

--
-- BUG#8937: Stored Procedure: AVG() works as SUM() in SELECT ... INTO statement
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8937|
create procedure bug8937()
begin
  declare s,x,y,z int;

  select sum(data),avg(data),min(data),max(data) into s,x,y,z from t1;
  select s,x,y,z;
  select avg(data) into a from t1;
  select a;

delete from t1|
insert into t1 (data) values (1), (2), (3), (4), (6)|
call bug8937()|

drop procedure bug8937|
delete from t1|


--
-- BUG#6900: Stored procedure inner handler ignored
-- BUG#9074: STORED PROC: The scope of every handler declared is not
--                        properly applied
--
--disable_warnings
drop procedure if exists bug6900|
drop procedure if exists bug9074|
drop procedure if exists bug6900_9074|
--enable_warnings

create table t3 (w char unique, x char)|
insert into t3 values ('a', 'b')|

create procedure bug6900()
begin
  declare exit handler for sqlexception select '1';
    declare exit handler for sqlexception select '2';

    insert into t3 values ('x', 'y', 'z');

create procedure bug9074()
begin
  declare x1, x2, x3, x4, x5, x6 int default 0;
    declare continue handler for sqlstate '23000' set x5 = 1;

    insert into t3 values ('a', 'b');
    set x6 = 1;
    declare continue handler for sqlstate '23000' set x1 = 1;

    insert into t3 values ('a', 'b');
    set x2 = 1;
				
   begin2_label:
    begin  
      declare exit handler for sqlstate '23000' set x3 = 1;

      set x4= 1;
      insert into t3 values ('a','b');
      set x4= 0;
    end begin2_label;
  end begin1_label;

  select x1, x2, x3, x4, x5, x6;

create procedure bug6900_9074(z int)
begin
  declare exit handler for sqlstate '23000' select '23000';
    declare exit handler for sqlexception select 'sqlexception';

    if z = 1 then
      insert into t3 values ('a', 'b');
    else
      insert into t3 values ('x', 'y', 'z');
    end if;

drop procedure bug6900|
drop procedure bug9074|
drop procedure bug6900_9074|
drop table t3|


--
-- BUG#7185: Stored procedure crash if identifier is AVG
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists avg|
create procedure avg ()
begin
end|

call avg ()|
drop procedure avg|


--
-- BUG#6129: Stored procedure won't display @@sql_mode value
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug6129|
set @old_mode= @@sql_mode;
set @@sql_mode= "ERROR_FOR_DIVISION_BY_ZERO";
create procedure bug6129()
  select @@sql_mode|
call bug6129()|
set @@sql_mode= "STRICT_ALL_TABLES,NO_ZERO_DATE"|
call bug6129()|
set @@sql_mode= "NO_ZERO_IN_DATE"|
call bug6129()|
set @@sql_mode=@old_mode;

drop procedure bug6129|


--
-- BUG#9856: Stored procedures: crash if handler for sqlexception, not found
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug9856|
create procedure bug9856()
begin
  declare v int;
  select v;

delete from t1|
call bug9856()|
call bug9856()|
drop procedure bug9856|


--
-- BUG##9674: Stored Procs: Using declared vars in algebric operation causes
--            system crash.
--
--disable_warnings
drop procedure if exists bug9674_1|
drop procedure if exists bug9674_2|
--enable_warnings
create procedure bug9674_1(out arg int)
begin
  declare temp_in1 int default 0;

  set temp_in1 = 100;
  set temp_fl1 = temp_in1/10;
  set arg = temp_fl1;

create procedure bug9674_2()
begin
  declare v int default 100;

  select v/10;
select @sptmp|
call bug9674_2()|
call bug9674_2()|
drop procedure bug9674_1|
drop procedure bug9674_2|


--
-- BUG#9598: stored procedure call within stored procedure overwrites IN variable
--
--disable_warnings
drop procedure if exists bug9598_1|
drop procedure if exists bug9598_2|
--enable_warnings
create procedure bug9598_1(in var_1 char(16),
                           out var_2 integer, out var_3 integer)
begin
  set var_2 = 50;
  set var_3 = 60;

create procedure bug9598_2(in v1 char(16),
                           in v2 integer,
                           in v3 integer,
                           in v4 integer,
                           in v5 integer)
begin
  select v1,v2,v3,v4,v5;
  select v1,v2,v3,v4,v5;
select @tmp1, @tmp2|

drop procedure bug9598_1|
drop procedure bug9598_2|


--
-- BUG#9102: Stored proccedures: function which returns blob causes crash
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug9102|
create function bug9102() returns blob return 'a'|
select bug9102()|
drop function bug9102|


--
-- BUG#7648: Stored procedure crash when invoking a function that returns a bit
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug7648|
create function bug7648() returns bit(8) return 'a'|
select bug7648()|
drop function bug7648|


--
-- BUG#9775: crash if create function that returns enum or set
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug9775|
create function bug9775(v1 char(1)) returns enum('a','b') return v1|
select bug9775('a'),bug9775('b'),bug9775('c')|
drop function bug9775|
create function bug9775(v1 int) returns enum('a','b') return v1|
select bug9775(1),bug9775(2),bug9775(3)|
drop function bug9775|

create function bug9775(v1 char(1)) returns set('a','b') return v1|
select bug9775('a'),bug9775('b'),bug9775('a,b'),bug9775('c')|
drop function bug9775|
create function bug9775(v1 int) returns set('a','b') return v1|
select bug9775(1),bug9775(2),bug9775(3),bug9775(4)|
drop function bug9775|


--
-- BUG#8861: If Return is a YEAR data type, value is not shown in year format
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug8861|
create function bug8861(v1 int) returns year return v1|
select bug8861(05)|
set @x = bug8861(05)|
select @x|
drop function bug8861|


--
-- BUG#9004: Inconsistent behaviour of SP re. warnings
--
--disable_warnings
drop procedure if exists bug9004_1|
drop procedure if exists bug9004_2|
--enable_warnings
create procedure bug9004_1(x char(16))
begin
  insert into t1 values (x, 42);
  insert into t1 values (x, 17);
create procedure bug9004_2(x char(16))
  call bug9004_1(x)|

-- Truncation warnings expected...
call bug9004_1('12345678901234567')|
call bug9004_2('12345678901234567890')|

delete from t1|
drop procedure bug9004_1|
drop procedure bug9004_2|

--
-- BUG#7293: Stored procedure crash with soundex
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug7293|
insert into t1 values ('secret', 0)| 
create procedure bug7293(p1 varchar(100))
begin
  if exists (select id from t1 where soundex(p1)=soundex(id)) then
    select 'yes';
  end if;
drop procedure bug7293|
delete from t1|


--
-- BUG#9841: Unexpected read lock when trying to update a view in a
--           stored procedure
--
--disable_warnings
drop procedure if exists bug9841|
drop view if exists v1|
--enable_warnings

create view v1 as select * from t1, t2 where id = s|
create procedure bug9841 ()
  update v1 set data = 10| 
call bug9841()|

drop view v1|
drop procedure bug9841|


--
-- BUG#5963 subqueries in SET/IF
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug5963|

create procedure bug5963_1 () begin declare v int;
create table t3 (s1 int)|
insert into t3 values (5)|
call bug5963_1()|
call bug5963_1()|
drop procedure bug5963_1|
drop table t3|

create procedure bug5963_2 (cfk_value int) 
begin 
  if cfk_value in (select cpk from t3) then 
    set @x = 5;
  end if;
create table t3 (cpk int)| 
insert into t3 values (1)| 
call bug5963_2(1)|
call bug5963_2(1)|
drop procedure bug5963_2|
drop table t3|


--
-- BUG#9559: Functions: Numeric Operations using -ve value gives incorrect
--           results.
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug9559|
create function bug9559()
  returns int
begin
  set @y = -6/2;

select bug9559()|

drop function bug9559|


--
-- BUG#10961: Stored procedures: crash if select * from dual
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug10961|
-- "select * from dual" results in an error, so the cursor will not open
create procedure bug10961()
begin
  declare v char;

  set x = 1;
  set x = 2;
  set x = 3;

drop procedure bug10961|

--
-- BUG #6866: Second call of a stored procedure using a view with on expressions
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS bug6866|

DROP VIEW IF EXISTS tv|
DROP TABLE IF EXISTS tt1,tt2,tt3|

CREATE TABLE tt1 (a1 int, a2 int, a3 int, data varchar(10))|
CREATE TABLE tt2 (a2 int, data2 varchar(10))|
CREATE TABLE tt3 (a3 int, data3 varchar(10))|

INSERT INTO tt1 VALUES (1, 1, 4, 'xx')|

INSERT INTO tt2 VALUES (1, 'a')|
INSERT INTO tt2 VALUES (2, 'b')|
INSERT INTO tt2 VALUES (3, 'c')|

INSERT INTO tt3 VALUES (4, 'd')|
INSERT INTO tt3 VALUES (5, 'e')|
INSERT INTO tt3 VALUES (6, 'f')|

CREATE VIEW tv AS
SELECT tt1.*, tt2.data2, tt3.data3
  FROM tt1 INNER JOIN tt2 ON tt1.a2 = tt2.a2
         LEFT JOIN tt3 ON tt1.a3 = tt3.a3
    ORDER BY tt1.a1, tt2.a2, tt3.a3|

CREATE PROCEDURE bug6866 (_a1 int)
BEGIN
SELECT * FROM tv WHERE a1 = _a1;

DROP PROCEDURE bug6866;

DROP VIEW tv|
DROP TABLE tt1, tt2, tt3|

--
-- BUG#10136: items cleunup
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS bug10136|
create table t3 ( name char(5) not null primary key, val float not null)|
insert into t3 values ('aaaaa', 1), ('bbbbb', 2), ('ccccc', 3)|
create procedure bug10136()
begin
  declare done int default 3;
    select * from t3;
    set done = done - 1;
drop procedure bug10136|
drop table t3|

--
-- BUG#11529: crash server after use stored procedure
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug11529|
create procedure bug11529()
begin
  declare c cursor for select id, data from t1 where data in (10,13);
    declare vid char(16);
    declare vdata int;
    declare exit handler for not found begin end;

    while true do
      fetch c into vid, vdata;
    end while;

insert into t1 values
  ('Name1', 10),
  ('Name2', 11),
  ('Name3', 12),
  ('Name4', 13),
  ('Name5', 14)|

call bug11529()|
call bug11529()|
delete from t1|
drop procedure bug11529|


--
-- BUG#6063: Stored procedure labels are subject to restrictions (partial)
-- BUG#7088: Stored procedures: labels won't work if character set is utf8mb3
--

set character set utf8mb3|

--disable_warnings
drop procedure if exists bug6063|
drop procedure if exists bug7088_1|
drop procedure if exists bug7088_2|
--enable_warnings

create procedure bug6063()
begin
  lâbel: begin end;

create procedure bug7088_1()
  label1: begin end label1|

create procedure bug7088_2()
  läbel1: begin end|

call bug6063()|
call bug7088_1()|
call bug7088_2()|

set character set default|

show create procedure bug6063|
show create procedure bug7088_1|
show create procedure bug7088_2|

drop procedure bug6063|
drop procedure bug7088_1|
drop procedure bug7088_2|

--
-- BUG#9565: "Wrong locking in stored procedure if a sub-sequent procedure
--           is called".
--
--disable_warnings
drop procedure if exists bug9565_sub|
drop procedure if exists bug9565|
--enable_warnings
create procedure bug9565_sub()
begin
  select * from t1;
create procedure bug9565()
begin
  insert into t1 values ("one", 1);
delete from t1|
drop procedure bug9565_sub|
drop procedure bug9565|


--
-- BUG#9538: SProc: Creation fails if we try to SET system variable
--           using @@var_name in proc
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug9538|
create procedure bug9538()
  set @@sort_buffer_size = 1000000|

set @x = @@sort_buffer_size|
set @@sort_buffer_size = 2000000|
select @@sort_buffer_size|
call bug9538()|
select @@sort_buffer_size|
set @@sort_buffer_size = @x|

drop procedure bug9538|


--
-- BUG#8692: Cursor fetch of empty string
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug8692|
create table t3 (c1 varchar(5), c2 char(5), c3 enum('one','two'), c4 text, c5 blob, c6 char(5), c7 varchar(5))|
insert into t3 values ('', '', '', '', '', '', NULL)|

create procedure bug8692()
begin 
    declare v1 VARCHAR(10);
    declare v2 VARCHAR(10);
    declare v3 VARCHAR(10);
    declare v4 VARCHAR(10);
    declare v5 VARCHAR(10);
    declare v6 VARCHAR(10);
    declare v7 VARCHAR(10);
    declare c8692 cursor for select c1,c2,c3,c4,c5,c6,c7 from t3;
    open c8692;
    fetch c8692 into v1,v2,v3,v4,v5,v6,v7;
    select v1, v2, v3, v4, v5, v6, v7;
drop procedure bug8692|
drop table t3|

--
-- Bug#10055 "Using stored function with information_schema causes empty
--            result set"
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug10055|
create function bug10055(v char(255)) returns char(255) return lower(v)|
-- This select should not crash server and should return all fields in t1
select t.column_name, bug10055(t.column_name)
from information_schema.columns as t
where t.table_schema = 'test' and t.table_name = 't1'
order by t.column_name|
drop function bug10055|

--
-- Bug #12297 "SP crashes the server if data inserted inside a lon loop"
-- The test for memleak bug, so actually there is no way to test it
-- from the suite. The test below could be used to check SP memory
-- consumption by passing large input parameter.
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug12297|

create procedure bug12297(lim int)
begin
  set @x = 0;
    insert into t1(id,data)
    values('aa', @x);
    set @x = @x + 1;
  end repeat;
drop procedure bug12297|

--
-- Bug #11247 "Stored procedures: Function calls in long loops leak memory"
-- One more memleak bug test. One could use this test to check that the memory
-- isn't leaking by increasing the input value for p_bug11247.
--

--disable_warnings
drop function if exists f_bug11247|
drop procedure if exists p_bug11247|
--enable_warnings

create function f_bug11247(param int)
  returns int
return param + 1|

create procedure p_bug11247(lim int)
begin
  declare v int default 0;
    set v= f_bug11247(v);
  end while;
drop function f_bug11247|
drop procedure p_bug11247|
--
-- BUG#12168: "'DECLARE CONTINUE HANDLER FOR NOT FOUND ...' in conditional
-- handled incorrectly"
--
--disable_warnings
drop procedure if exists bug12168|
drop table if exists t3, t4|
--enable_warnings

create table t3 (a int)|
insert into t3 values (1),(2),(3),(4)|

create table t4 (a int)|

create procedure bug12168(arg1 char(1))
begin
  declare b, c integer;
  if arg1 = 'a' then
    begin
      declare c1 cursor for select a from t3 where a % 2;
      declare continue handler for not found set b = 1;
      set b = 0;
      open c1;
      c1_repeat: repeat
        fetch c1 into c;
        if (b = 1) then
          leave c1_repeat;
        end if;

        insert into t4 values (c);
        until b = 1
      end repeat;
    end;
  end if;
  if arg1 = 'b' then
    begin
      declare c2 cursor for select a from t3 where not a % 2;
      declare continue handler for not found set b = 1;
      set b = 0;
      open c2;
      c2_repeat: repeat
        fetch c2 into c;
        if (b = 1) then
          leave c2_repeat;
        end if;

        insert into t4 values (c);
        until b = 1
      end repeat;
    end;
  end if;
select * from t4|
truncate t4|
call bug12168('b')|
select * from t4|
truncate t4|
call bug12168('a')|
select * from t4|
truncate t4|
call bug12168('b')|
select * from t4|
truncate t4|
drop table t3, t4|
drop procedure if exists bug12168|

--
-- Bug #11333 "Stored Procedure: Memory blow up on repeated SELECT ... INTO
-- query"
-- One more memleak bug. Use the test to check memory consumption.
--

--disable_warnings
drop table if exists t3|
drop procedure if exists bug11333|
--enable_warnings

create table t3 (c1 char(128))|

insert into t3 values 
  ('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')|


create procedure bug11333(i int)
begin
    declare tmp varchar(128);
    set @x = 0;
    repeat
        select c1 into tmp from t3
          where c1 = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
        set @x = @x + 1;
        until @x >= i
    end repeat;

drop procedure bug11333|
drop table t3|

--
-- BUG#9048: Creating a function with char binary IN parameter fails
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug9048|
create function bug9048(f1 char binary) returns char
begin
  set f1= concat( 'hello', f1 );
drop function bug9048|
--
-- This was disabled in 5.1.12. See bug #20701
-- When collation support in SP is implemented, then this test should
-- be removed.
--
--error ER_NOT_SUPPORTED_YET
create function bug9048(f1 char binary) returns char binary
begin
  set f1= concat( 'hello', f1 );

-- Bug #12849 Stored Procedure: Crash on procedure call with CHAR type
-- 'INOUT' parameter
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug12849_1|
create procedure bug12849_1(inout x char) select x into x|
set @var='a'|
call bug12849_1(@var)|
select @var|
drop procedure bug12849_1|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug12849_2|
create procedure bug12849_2(inout foo varchar(15))
begin
select concat(foo, foo) INTO foo;
set @var='abcd'|
call bug12849_2(@var)|
select @var|
drop procedure bug12849_2|

--
-- BUG#13133: Local variables in stored procedures are not initialized correctly.
--
--disable_warnings
drop procedure if exists bug131333|
drop function if exists bug131333|
--enable_warnings
create procedure bug131333()
begin
  begin
    declare a int;

    select a;
    set a = 1;
    select a;
    declare b int;

    select b;

create function bug131333()
  returns int
begin
  begin
    declare a int;

    set a = 1;
    declare b int;

    return b;
select bug131333()|

drop procedure bug131333|
drop function bug131333|

--
-- BUG#12379: PROCEDURE with HANDLER calling FUNCTION with error get
--            strange result
--
--disable_warnings
drop function if exists bug12379|
drop procedure if exists bug12379_1|
drop procedure if exists bug12379_2|
drop procedure if exists bug12379_3|
drop table if exists t3|
--enable_warnings

create table t3 (c1 char(1) primary key not null)|

create function bug12379()
  returns integer
begin
   insert into t3 values('X');
   insert into t3 values('X');

create procedure bug12379_1()
begin
   declare exit handler for sqlexception select 42;

   select bug12379();
create procedure bug12379_2()
begin
   declare exit handler for sqlexception begin end;

   select bug12379();
create procedure bug12379_3()
begin
   select bug12379();
select bug12379()|
select 1|
-- statement-based binlogging will show warning which row-based won't;
select 2|
call bug12379_2()|
--enable_warnings
select 3|
--error ER_DUP_ENTRY
call bug12379_3()|
select 4|

drop function bug12379|
drop procedure bug12379_1|
drop procedure bug12379_2|
drop procedure bug12379_3|
drop table t3|

--
-- Bug #13124    Stored Procedure using SELECT INTO crashes server
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug13124|
create procedure bug13124()
begin
  declare y integer;
  set @x=y;
drop procedure  bug13124|

--
-- Bug #12979  Stored procedures: crash if inout decimal parameter
--

-- check NULL inout parameters processing

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug12979_1|
create procedure bug12979_1(inout d decimal(5)) set d = d / 2|
set @bug12979_user_var = NULL|
call bug12979_1(@bug12979_user_var)|
drop procedure bug12979_1|

-- check NULL local variables processing

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug12979_2|
create procedure bug12979_2()
begin
declare internal_var decimal(5);
set internal_var= internal_var / 2;
select internal_var;
drop procedure bug12979_2|


--
-- BUG#6127: Stored procedure handlers within handlers don't work
--
--disable_warnings
drop table if exists t3|
drop procedure if exists bug6127|
--enable_warnings
create table t3 (s1 int unique)|

set @sm=@@sql_mode|
set sql_mode='traditional'|

create procedure bug6127()
begin
  declare continue handler for sqlstate '23000'
    begin
      declare continue handler for sqlstate '22003'
        insert into t3 values (0);

      insert into t3 values (1000000000000000);
    end;

  insert into t3 values (1);
  insert into t3 values (1);
select * from t3|
--error ER_DUP_ENTRY
call bug6127()|
--sorted_result
select * from t3|
set sql_mode=@sm|
drop table t3|
drop procedure bug6127|


--
-- BUG#12589: Assert when creating temp. table from decimal stored procedure
--            variable
--
--disable_warnings
drop procedure if exists bug12589_1|
drop procedure if exists bug12589_2|
drop procedure if exists bug12589_3|
--enable_warnings
create procedure bug12589_1()
begin
  declare spv1 decimal(3,3);
  set spv1= 123.456;

  set spv1 = 'test';
  create temporary table tm1 as select spv1;
  drop temporary table tm1;

create procedure bug12589_2()
begin
  declare spv1 decimal(6,3);
  set spv1= 123.456;

  create temporary table tm1 as select spv1;
  drop temporary table tm1;

create procedure bug12589_3()
begin
  declare spv1 decimal(6,3);
  set spv1= -123.456;

  create temporary table tm1 as select spv1;
  drop temporary table tm1;

-- Note: The type of the field will match the value, not the declared
--       type of the variable. (This is a type checking issue which
--       might be changed later.)

-- Warning expected from "set spv1 = 'test'", the value is set to decimal "0".
call bug12589_1()|
-- No warnings here
call bug12589_2()|
call bug12589_3()|
drop procedure bug12589_1|
drop procedure bug12589_2|
drop procedure bug12589_3|

--
-- BUG#7049: Stored procedure CALL errors are ignored
--
--disable_warnings
drop table if exists t3|
drop procedure if exists bug7049_1|
drop procedure if exists bug7049_2|
drop procedure if exists bug7049_3|
drop procedure if exists bug7049_4|
drop function if exists bug7049_1|
drop function if exists bug7049_2|
--enable_warnings

create table t3 ( x int unique )|

create procedure bug7049_1()
begin
  insert into t3 values (42);
  insert into t3 values (42);

create procedure bug7049_2()
begin
  declare exit handler for sqlexception
    select 'Caught it' as 'Result';
  select 'Missed it' as 'Result';

create procedure bug7049_3()
  call bug7049_1()|

create procedure bug7049_4()
begin
  declare exit handler for sqlexception
    select 'Caught it' as 'Result';
  select 'Missed it' as 'Result';

create function bug7049_1()
  returns int
begin
  insert into t3 values (42);
  insert into t3 values (42);

create function bug7049_2()
  returns int
begin
  declare x int default 0;
    set x = 1;

  set x = bug7049_1();
select * from t3|
delete from t3|
call bug7049_4()|
select * from t3|
select bug7049_2()|

drop table t3|
drop procedure bug7049_1|
drop procedure bug7049_2|
drop procedure bug7049_3|
drop procedure bug7049_4|
drop function bug7049_1|
drop function bug7049_2|


--
-- BUG#13941: replace() string fuction behaves badly inside stored procedure
-- (BUG#13914: IFNULL is returning garbage in stored procedure)
--
--disable_warnings
drop function if exists bug13941|
drop procedure if exists bug13941|
--enable_warnings

create function bug13941(p_input_str text)
  returns text
begin
  declare p_output_str text;

  set p_output_str = p_input_str;

  set p_output_str = replace(p_output_str, 'xyzzy', 'plugh');
  set p_output_str = replace(p_output_str, 'test', 'prova');
  set p_output_str = replace(p_output_str, 'this', 'questo');
  set p_output_str = replace(p_output_str, ' a ', 'una ');
  set p_output_str = replace(p_output_str, 'is', '');

create procedure bug13941(out sout varchar(128))
begin
  set sout = 'Local';
  set sout = ifnull(sout, 'DEF');

-- Note: The bug showed different behaviour in different types of builds,
--  giving garbage results in some, and seemingly working in others.
--  Running with valgrind (or purify) is the safe way to check that it's
--  really working correctly.
select bug13941('this is a test')|
call bug13941(@a)|
select @a|

drop function bug13941|
drop procedure bug13941|


--
-- BUG#13095: Cannot create VIEWs in prepared statements
--

delimiter ;
DROP PROCEDURE IF EXISTS bug13095;
DROP TABLE IF EXISTS bug13095_t1;
DROP VIEW IF EXISTS bug13095_v1;

CREATE PROCEDURE bug13095(tbl_name varchar(32))
BEGIN
  SET @str =
    CONCAT("CREATE TABLE ", tbl_name, "(stuff char(15))");
  SELECT @str;

  SET @str =
    CONCAT("INSERT INTO ", tbl_name, " VALUES('row1'),('row2'),('row3')" );
  SELECT @str;

  SET @str =
    CONCAT("CREATE VIEW bug13095_v1(c1) AS SELECT stuff FROM ", tbl_name);
  SELECT @str;

  SELECT * FROM bug13095_v1;

  SET @str =
    "DROP VIEW bug13095_v1";
  SELECT @str;
DROP PROCEDURE IF EXISTS bug13095;
DROP VIEW IF EXISTS bug13095_v1;
DROP TABLE IF EXISTS bug13095_t1;

--
-- BUG#1473: Dumping of stored functions seems to cause corruption in
--           the function body
--
--disable_warnings
drop function if exists bug14723|
drop procedure if exists bug14723|
--enable_warnings

delimiter ;
end */;
select bug14723();
  select 42;
end */;

drop function bug14723|
drop procedure bug14723|

--
-- Bug#14845 "mysql_stmt_fetch returns MYSQL_NO_DATA when COUNT(*) is 0"
-- Check that when fetching from a cursor, COUNT(*) works properly.
--
create procedure bug14845()
begin
  declare a char(255);
    fetch c into a;
    if not done then
      select a;
    end if;
drop procedure bug14845|

--
-- BUG#13549 "Server crash with nested stored procedures".
-- Server should not crash when during execution of stored procedure
-- we have to parse trigger/function definition and this new trigger/
-- function has more local variables declared than invoking stored
-- procedure and last of these variables is used in argument of NOT
-- operator.
--
--disable_warnings
drop procedure if exists bug13549_1|
drop procedure if exists bug13549_2|
--enable_warnings
CREATE PROCEDURE `bug13549_2`()
begin
  call bug13549_1();
CREATE PROCEDURE `bug13549_1`()
begin
  declare done int default 0;
  set done= not done;
drop procedure bug13549_2|
drop procedure bug13549_1|

--
-- BUG#10100: function (and stored procedure?) recursivity problem
--
--disable_warnings
drop function if exists bug10100f|
drop procedure if exists bug10100p|
drop procedure if exists bug10100t|
drop procedure if exists bug10100pt|
drop procedure if exists bug10100pv|
drop procedure if exists bug10100pd|
drop procedure if exists bug10100pc|
--enable_warnings
-- routines with simple recursion
create function bug10100f(prm int) returns int
begin
  if prm > 1 then
    return prm * bug10100f(prm - 1);
  end if;
create procedure bug10100p(prm int, inout res int)
begin
  set res = res * prm;
  if prm > 1 then
    call bug10100p(prm - 1, res);
  end if;
create procedure bug10100t(prm int)
begin
  declare res int;
  set res = 1;
  select res;

-- a procedure which use tables and recursion
create table t3 (a int)|
insert into t3 values (0)|
create view v1 as select a from t3|
create procedure bug10100pt(level int, lim int)
begin
  if level < lim then
    update t3 set a=level;
    FLUSH TABLES;
    call bug10100pt(level+1, lim);
    select * from t3;
  end if;
create procedure bug10100pv(level int, lim int)
begin
  if level < lim then
    update v1 set a=level;
    FLUSH TABLES;
    call bug10100pv(level+1, lim);
    select * from v1;
  end if;
create procedure bug10100pd(level int, lim int)
begin
  if level < lim then
    select level;
    prepare stmt1 from "update t3 set a=a+2";
    execute stmt1;
    FLUSH TABLES;
    execute stmt1;
    FLUSH TABLES;
    execute stmt1;
    FLUSH TABLES;
    deallocate prepare stmt1;
    execute stmt2;
    select * from t3;
    call bug10100pd(level+1, lim);
    execute stmt2;
  end if;
create procedure bug10100pc(level int, lim int)
begin
  declare lv int;
  if level < lim then
    select level;
    fetch c into lv;
    select lv;
    update t3 set a=level+lv;
    FLUSH TABLES;
    call bug10100pc(level+1, lim);
    select * from t3;
  end if;

set @@max_sp_recursion_depth=4|
select @@max_sp_recursion_depth|
-- error ER_SP_NO_RECURSION
select bug10100f(3)|
-- error ER_SP_NO_RECURSION
select bug10100f(6)|
call bug10100t(5)|
call bug10100pt(1,5)|
call bug10100pv(1,5)|
update t3 set a=1|
call bug10100pd(1,5)|
select * from t3|
update t3 set a=1|
call bug10100pc(1,5)|
select * from t3|
set @@max_sp_recursion_depth=0|
select @@max_sp_recursion_depth|
-- error ER_SP_NO_RECURSION
select bug10100f(5)|
-- error ER_SP_RECURSION_LIMIT
call bug10100t(5)|

--end of the stack checking
deallocate prepare stmt2|

drop function bug10100f|
drop procedure bug10100p|
drop procedure bug10100t|
drop procedure bug10100pt|
drop procedure bug10100pv|
drop procedure bug10100pd|
drop procedure bug10100pc|
drop view v1|

--
-- BUG#13729: Stored procedures: packet error after exception handled
--
--disable_warnings
drop procedure if exists bug13729|
drop table if exists t3|
--enable_warnings

create table t3 (s1 int, primary key (s1))|

insert into t3 values (1),(2)|

create procedure bug13729()
begin
  declare continue handler for sqlexception select 55;

  update t3 set s1 = 1;
select * from t3|

drop procedure bug13729|
drop table t3|

--
-- BUG#14643: Stored Procedure: Continuing after failed var. initialization
--            crashes server.
--
--disable_warnings
drop procedure if exists bug14643_1|
drop procedure if exists bug14643_2|
--enable_warnings

create procedure bug14643_1()
begin
  declare continue handler for sqlexception select 'boo' as 'Handler';
    declare v int default undefined_var;

    if v = 1 then
      select 1;
    else
      select v, isnull(v);
    end if;

create procedure bug14643_2()
begin
  declare continue handler for sqlexception select 'boo' as 'Handler';
    select 1;
    select 2;
  end case;

  select undefined_var;

drop procedure bug14643_1|
drop procedure bug14643_2|

--
-- BUG#14304: auto_increment field incorrect set in SP
--
--disable_warnings
drop procedure if exists bug14304|
drop table if exists t3, t4|
--enable_warnings

create table t3(a int primary key auto_increment)|
create table t4(a int primary key auto_increment)|

create procedure bug14304()
begin
  insert into t3 set a=null;
  insert into t4 set a=null;
  insert into t4 set a=null;
  insert into t4 set a=null;
  insert into t4 set a=null;
  insert into t4 set a=null;
  insert into t4 select null as a;
  
  insert into t3 set a=null;
  insert into t3 set a=null;
  
  select * from t3;

drop procedure bug14304|
drop table t3, t4|

--
-- BUG#14376: MySQL crash on scoped variable (re)initialization
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug14376|

create procedure bug14376()
begin
  declare x int default x;

-- Not the error we want, but that's what we got for now...
--error ER_BAD_FIELD_ERROR
call bug14376()|
drop procedure bug14376|

create procedure bug14376()
begin
  declare x int default 42;
    declare x int default x;

    select x;

drop procedure bug14376|

create procedure bug14376(x int)
begin
  declare x int default x;

  select x;

drop procedure bug14376|

--
-- Bug#5967 "Stored procedure declared variable used instead of column"
-- The bug should be fixed later.
-- Test precedence of names of parameters, variable declarations, 
-- variable declarations in nested compound statements, table columns,
-- table columns in cursor declarations.
-- According to the standard, table columns take precedence over
-- variable declarations. In MySQL 5.0 it's vice versa.
--

--disable_warnings
drop procedure if exists bug5967|
drop table if exists t3|
--enable_warnings
create table t3 (a varchar(255)) engine=myisam|
insert into t3 (a) values ("a - table column")|
create procedure bug5967(a varchar(255))
begin
  declare i varchar(255);
  select a;
  select a from t3 into i;
  select i as 'Parameter takes precedence over table column';
  select i as 'Parameter takes precedence over table column in cursors';
    declare a varchar(255) default 'a - local variable';
    declare c1 cursor for select a from t3;
    select a as 'A local variable takes precedence over parameter';
    open c1;
    fetch c1 into i;
    close c1;
    select i as 'A local variable takes precedence over parameter in cursors';
    begin
      declare a varchar(255) default 'a - local variable in a nested compound statement';
      declare c2 cursor for select a from t3;
      select a as 'A local variable in a nested compound statement takes precedence over a local variable in the outer statement';
      select a from t3 into i;
      select i as  'A local variable in a nested compound statement takes precedence over table column';
      open c2;
      fetch c2 into i;
      close c2;
      select i as  'A local variable in a nested compound statement takes precedence over table column in cursors';
    end;
drop procedure bug5967|

--
-- Bug#13012 "SP: REPAIR/BACKUP/RESTORE TABLE crashes the server"
--
--let $backupdir = $MYSQLTEST_VARDIR/tmp/
--error 0,1
--remove_file $backupdir/t1.MYD

--disable_warnings
drop procedure if exists bug13012|
-- Disable warnings also for BACKUP/RESTORE: they are deprecated.
eval create procedure bug13012()
    BEGIN
       REPAIR TABLE t1;
    END|
call bug13012()|

--enable_warnings

drop procedure bug13012|

create view v1 as select * from t1|
create procedure bug13012()
BEGIN
  REPAIR TABLE t1,t2,t3,v1;
drop procedure bug13012|
drop view v1|
select * from t1 order by data|

--
-- A test case for Bug#15392 "Server crashes during prepared statement
-- execute": make sure that stored procedure check for error conditions
-- properly and do not continue execution if an error has been set. 
--
-- It's necessary to use several DBs because in the original code
-- the successful return of mysql_change_db overrode the error from
-- execution.
drop schema if exists mysqltest1|
drop schema if exists mysqltest2|
drop schema if exists mysqltest3|
create schema mysqltest1|
create schema mysqltest2|
create schema mysqltest3|
use mysqltest3|

create procedure mysqltest1.p1 (out prequestid varchar(100))
begin
  call mysqltest2.p2('call mysqltest3.p3(1, 2)');

create procedure mysqltest2.p2(in psql text)
begin
  declare lsql text;
  set @lsql= psql;

create procedure mysqltest3.p3(in p1 int)
begin
  select p1;
drop schema if exists mysqltest1|
drop schema if exists mysqltest2|
drop schema if exists mysqltest3|
use test|

--
-- Bug#15441 "Running SP causes Server to Crash": check that an SP variable
-- can not be used in VALUES() function.
--
--disable_warnings
drop table if exists t3|
drop procedure if exists bug15441|
--enable_warnings
create table t3 (id int not null primary key, county varchar(25))|
insert into t3 (id, county) values (1, 'York')|

-- First check that a stored procedure that refers to a parameter in VALUES()
-- function won't parse.

create procedure bug15441(c varchar(25))
begin
  update t3 set id=2, county=values(c);
drop procedure bug15441|

-- Now check the case when there is an ambiguity between column names
-- and stored procedure parameters: the parser shall resolve the argument
-- of VALUES() function to the column name.

-- It's hard to deduce what county refers to in every case (INSERT statement):
-- 1st county refers to the column
-- 2nd county refers to the procedure parameter
-- 3d and 4th county refers to the column, again, but
-- for 4th county it has the value of SP parameter

-- In UPDATE statement, just check that values() function returns NULL for
-- non- INSERT...UPDATE statements, as stated in the manual.

create procedure bug15441(county varchar(25))
begin
  declare c varchar(25) default "hello";

  insert into t3 (id, county) values (1, county)
  on duplicate key update county= values(county);
  select * from t3;

  update t3 set id=2, county=values(id);
  select * from t3;
drop table t3|
drop procedure bug15441|

--
-- BUG#14498: Stored procedures: hang if undefined variable and exception
--
--disable_warnings
drop procedure if exists bug14498_1|
drop procedure if exists bug14498_2|
drop procedure if exists bug14498_3|
drop procedure if exists bug14498_4|
drop procedure if exists bug14498_5|
--enable_warnings

create procedure bug14498_1()
begin
  declare continue handler for sqlexception select 'error' as 'Handler';

  if v then
    select 'yes' as 'v';
    select 'no' as 'v';
  end if;
  select 'done' as 'End';

create procedure bug14498_2()
begin
  declare continue handler for sqlexception select 'error' as 'Handler';
    select 'yes' as 'v';
  end while;
  select 'done' as 'End';

create procedure bug14498_3()
begin
  declare continue handler for sqlexception select 'error' as 'Handler';
    select 'maybe' as 'v';
  select 'done' as 'End';

create procedure bug14498_4()
begin
  declare continue handler for sqlexception select 'error' as 'Handler';
    select '1' as 'v';
    select '2' as 'v';
    select '?' as 'v';
  end case;
  select 'done' as 'End';

create procedure bug14498_5()
begin
  declare continue handler for sqlexception select 'error' as 'Handler';
    select '1' as 'v';
    select '2' as 'v';
    select '?' as 'v';
  end case;
  select 'done' as 'End';

drop procedure bug14498_1|
drop procedure bug14498_2|
drop procedure bug14498_3|
drop procedure bug14498_4|
drop procedure bug14498_5|

--
-- BUG#15231: Stored procedure bug with not found condition handler
--
--disable_warnings
drop table if exists t3|
drop procedure if exists bug15231_1|
drop procedure if exists bug15231_2|
drop procedure if exists bug15231_3|
drop procedure if exists bug15231_4|
drop procedure if exists bug15231_5|
drop procedure if exists bug15231_6|
--enable_warnings

create table t3 (id int not null)|
  
create procedure bug15231_1()
begin
  declare xid integer;

  set xid=null;
  select xid, xdone;

create procedure bug15231_2(inout ioid integer)
begin
  select "Before NOT FOUND condition is triggered" as '1';
  select id into ioid from t3 where id=ioid;
  select "After NOT FOUND condtition is triggered" as '2';

  if ioid is null then
    set ioid=1;
  end if;

create procedure bug15231_3()
begin
  declare exit handler for sqlwarning
    select 'Caught it (correct)' as 'Result';

create procedure bug15231_4()
begin
  declare x decimal(2,1);

  set x = 'zap';
  select 'Missed it (correct)' as 'Result';

create procedure bug15231_5()
begin
  declare exit handler for sqlwarning
    select 'Caught it (wrong)' as 'Result';

create procedure bug15231_6()
begin
  declare x decimal(2,1);

  set x = 'zap';
  select 'Missed it (correct)' as 'Result';
  select id from t3;

drop table t3|
drop procedure bug15231_1|
drop procedure bug15231_2|
drop procedure bug15231_3|
drop procedure bug15231_4|
drop procedure bug15231_5|
drop procedure bug15231_6|


--
-- BUG#15011: error handler in nested block not activated
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug15011|

create table t3 (c1 int primary key)|

insert into t3 values (1)|

create procedure bug15011()
  deterministic
begin
  declare continue handler for 1062
    select 'Outer' as 'Handler';
    declare continue handler for 1062
      select 'Inner' as 'Handler';

    insert into t3 values (1);

drop procedure bug15011|
drop table t3|


--
-- BUG#17476: Stored procedure not returning data when it is called first
--            time per connection
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug17476|

create table t3 ( d date )|
insert into t3 values
  ( '2005-01-01' ), ( '2005-01-02' ), ( '2005-01-03' ),
  ( '2005-01-04' ), ( '2005-02-01' ), ( '2005-02-02' )|

create procedure bug17476(pDateFormat varchar(10))
  select date_format(t3.d, pDateFormat), count(*)
    from t3 
    group by date_format(t3.d, pDateFormat)|

call bug17476('%Y-%m')|
call bug17476('%Y-%m')|

drop table t3|
drop procedure bug17476|


--
-- BUG#16887: Cursor causes server segfault
--
--disable_warnings
drop table if exists t3|
drop procedure if exists bug16887|
--enable_warnings

create table t3 ( c varchar(1) )|

insert into t3 values
  (' '),('.'),(';

create procedure bug16887()
begin
  declare i int default 10;
    declare breakchar varchar(1);
    declare done int default 0;
    declare t3_cursor cursor for select c from t3;
    declare continue handler for not found set done = 1;

    set i = i - 1;
    select i;

    if i = 3 then
      iterate again;
    end if;

    open t3_cursor;

    loop
      fetch t3_cursor into breakchar;

      if done = 1 then
        begin
          close t3_cursor;
          iterate again;
        end;
      end if;
     end loop;
   end while;

drop table t3|
drop procedure bug16887|

--
-- BUG#16474: SP crashed MySQL
-- (when using "order by localvar", where 'localvar' is just that.
--
--disable_warnings
drop procedure if exists bug16474_1|
drop procedure if exists bug16474_2|
--enable_warnings

delete from t1|
insert into t1 values ('c', 2), ('b', 3), ('a', 1)|

create procedure bug16474_1()
begin
  declare x int;

  select id from t1 order by x, id;

-- 
-- BUG#14945: Truncate table doesn't reset the auto_increment counter
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug14945|
create table t3 (id int not null auto_increment primary key)|
create procedure bug14945() deterministic truncate t3|
insert into t3 values (null)|
call bug14945()|
insert into t3 values (null)|
select * from t3|
drop table t3|
drop procedure bug14945|

-- This does NOT order by column index;
create procedure bug16474_2(x int)
  select id from t1 order by x, id|

call bug16474_1()|
call bug16474_2(1)|
call bug16474_2(2)|
drop procedure bug16474_1|
drop procedure bug16474_2|

-- For reference: user variables are expressions too and do not affect ordering.
set @x = 2|
select * from t1 order by @x, data|

delete from t1|


--
-- BUG#15728: LAST_INSERT_ID function inside a stored function returns 0
--
-- The solution is not to reset last_insert_id on enter to sub-statement.
--
--disable_warnings
drop function if exists bug15728|
drop table if exists t3|
--enable_warnings

create table t3 (
  id int not null auto_increment,
  primary key (id)
)|
create function bug15728() returns int(11)
  return last_insert_id()|

insert into t3 values (0)|
select last_insert_id()|
select bug15728()|

drop function bug15728|
drop table t3|


--
-- BUG#18787: Server crashed when calling a stored procedure containing
--            a misnamed function
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug18787|
create procedure bug18787()
begin
  declare continue handler for sqlexception begin end;

  select no_such_function();
drop procedure bug18787|


--
-- BUG#18344: DROP DATABASE does not drop associated routines
-- (... if the database name is longer than 21 characters)
--
--               1234567890123456789012
create database bug18344_012345678901| 
use bug18344_012345678901|
create procedure bug18344() begin end|
create procedure bug18344_2() begin end|

create database bug18344_0123456789012| 
use bug18344_0123456789012|
create procedure bug18344() begin end|
create procedure bug18344_2() begin end|

use test|

--sorted_result
select schema_name from information_schema.schemata where 
  schema_name like 'bug18344%'|
--sorted_result
select routine_name,routine_schema from information_schema.routines where
  routine_schema like 'bug18344%'|

drop database bug18344_012345678901| 
drop database bug18344_0123456789012| 

-- Should be nothing left.
select schema_name from information_schema.schemata where 
  schema_name like 'bug18344%'|
select routine_name,routine_schema from information_schema.routines where
  routine_schema like 'bug18344%'|


--
-- BUG#12472/BUG#15137 'CREATE TABLE ... SELECT ... which explicitly or
-- implicitly uses stored function gives "Table not locked" error'.
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop function if exists bug12472|
create function bug12472() returns int return (select count(*) from t1)|
-- Check case when function is used directly
create table t3 as select bug12472() as i|
show create table t3|
select * from t3|
drop table t3|
-- Check case when function is used indirectly through view
create view v1 as select bug12472() as j|
create table t3 as select * from v1|
show create table t3|
select * from t3|
drop table t3|
drop view v1|
drop function bug12472|


--
-- BUG#18587: Function that accepts and returns TEXT garbles data if longer than
-- 766 chars
--

-- Prepare.

--disable_warnings
DROP FUNCTION IF EXISTS bug18589_f1|
DROP PROCEDURE IF EXISTS bug18589_p1|
DROP PROCEDURE IF EXISTS bug18589_p2|
--enable_warnings

CREATE FUNCTION bug18589_f1(arg TEXT) RETURNS TEXT
BEGIN
  RETURN CONCAT(arg, "");

CREATE PROCEDURE bug18589_p1(arg TEXT, OUT ret TEXT)
BEGIN
  SET ret = CONCAT(arg, "");

CREATE PROCEDURE bug18589_p2(arg TEXT)
BEGIN
  DECLARE v TEXT;
  SELECT v;

-- Test case.

SELECT bug18589_f1(REPEAT("a", 767))|

SET @bug18589_v1 = ""|
CALL bug18589_p1(REPEAT("a", 767), @bug18589_v1)|
SELECT @bug18589_v1|

CALL bug18589_p2(REPEAT("a", 767))|

-- Cleanup.

DROP FUNCTION bug18589_f1|
DROP PROCEDURE bug18589_p1|
DROP PROCEDURE bug18589_p2|


--
-- BUG#18037: Server crash when returning system variable in stored procedures
-- BUG#19633: Stack corruption in fix_fields()/THD::rollback_item_tree_changes()
--

-- Prepare.

--disable_warnings
DROP FUNCTION IF EXISTS bug18037_f1|
DROP PROCEDURE IF EXISTS bug18037_p1|
DROP PROCEDURE IF EXISTS bug18037_p2|
--enable_warnings

-- Test case.

CREATE FUNCTION bug18037_f1() RETURNS INT
BEGIN
  RETURN @@server_id;

CREATE PROCEDURE bug18037_p1()
BEGIN
  DECLARE v INT DEFAULT @@server_id;

CREATE PROCEDURE bug18037_p2()
BEGIN
  CASE @@server_id
  WHEN -1 THEN
    SELECT 0;
    SELECT 1;
  END CASE;

SELECT bug18037_f1()|
CALL bug18037_p1()|
CALL bug18037_p2()|

-- Cleanup.

DROP FUNCTION bug18037_f1|
DROP PROCEDURE bug18037_p1|
DROP PROCEDURE bug18037_p2|

--
-- Bug#17199: "Table not found" error occurs if the query contains a call
--            to a function from another database.
--            See also ps.test for an additional test case for this bug.
--
use test|
create table t3 (i int)|
insert into t3 values (1), (2)|
create database mysqltest1|
use mysqltest1|
create function bug17199() returns varchar(2) deterministic return 'ok'|
use test|
select *, mysqltest1.bug17199() from t3|
--
-- Bug#18444: Fully qualified stored function names don't work correctly
--            in select statements
--
use mysqltest1|
create function bug18444(i int) returns int no sql deterministic return i + 1|
use test|
select mysqltest1.bug18444(i) from t3|
drop database mysqltest1|
--
-- Check that current database has no influence to a stored procedure
--
create database mysqltest1 charset=utf8mb3|
create database mysqltest2 charset=utf8mb3|
create procedure mysqltest1.p1()
begin
-- alters the default collation of database test 
  alter database character set koi8r;
use mysqltest1|
call p1()|
show create database mysqltest1|
show create database mysqltest2|
alter database mysqltest1 character set utf8mb3|
use mysqltest2|
call mysqltest1.p1()|
show create database mysqltest1|
show create database mysqltest2|
drop database mysqltest1|
drop database mysqltest2|
--
-- Restore the old environemnt
use test|
--
-- Bug#15217 "Using a SP cursor on a table created with PREPARE fails with
--           weird error". Check that the code that is supposed to work at
--           the first execution of a stored procedure actually works for
--           sp_instr_copen.

--disable_warnings
drop table if exists t3|
drop procedure if exists bug15217|
--enable_warnings
create table t3 as select 1|
create procedure bug15217()
begin
  declare var1 char(255);
  select concat('data was: /', var1, '/');
end |
-- Returns expected result
call bug15217()|
flush tables |
-- Returns error with garbage as column name
call bug15217()|
drop table t3|
drop procedure bug15217|


--
-- BUG#21013: Performance Degrades when importing data that uses
-- Trigger and Stored Procedure
--
-- This is a performance and memory leak test.  Run with large number
-- passed to bug21013() procedure.
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS bug21013 |

CREATE PROCEDURE bug21013(IN lim INT)
BEGIN
  DECLARE i INT DEFAULT 0;
    SET @b = LOCATE(_latin1'b', @a, 1);
    SET i = i + 1;
  END WHILE;
END |

SET @a = _latin2"aaaaaaaaaa" |
CALL bug21013(10) |

DROP PROCEDURE bug21013 |


--
-- BUG#16211: Stored function return type for strings is ignored
--

-- Prepare: create database with fixed, pre-defined character set.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3|
CREATE DATABASE mysqltest2 DEFAULT CHARACTER SET utf8mb3|

-- Test case:

use mysqltest1|

--   - Create two stored functions -- with and without explicit CHARSET-clause
--     for return value;

CREATE FUNCTION bug16211_f1() RETURNS CHAR(10)
  RETURN ""|

CREATE FUNCTION bug16211_f2() RETURNS CHAR(10) CHARSET koi8r
  RETURN ""|

CREATE FUNCTION mysqltest2.bug16211_f3() RETURNS CHAR(10)
  RETURN ""|

CREATE FUNCTION mysqltest2.bug16211_f4() RETURNS CHAR(10) CHARSET koi8r
  RETURN ""|

--   - Check that CHARSET-clause is specified for the second function;

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest1" AND ROUTINE_NAME = "bug16211_f1"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest1" AND ROUTINE_NAME = "bug16211_f2"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest2" AND ROUTINE_NAME = "bug16211_f3"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest2" AND ROUTINE_NAME = "bug16211_f4"|

SELECT CHARSET(bug16211_f1())|
SELECT CHARSET(bug16211_f2())|

SELECT CHARSET(mysqltest2.bug16211_f3())|
SELECT CHARSET(mysqltest2.bug16211_f4())|

--   - Alter database character set.

ALTER DATABASE mysqltest1 CHARACTER SET cp1251|
ALTER DATABASE mysqltest2 CHARACTER SET cp1251|

--   - Check that CHARSET-clause has not changed.

SHOW CREATE FUNCTION bug16211_f1|
SHOW CREATE FUNCTION bug16211_f2|

SHOW CREATE FUNCTION mysqltest2.bug16211_f3|
SHOW CREATE FUNCTION mysqltest2.bug16211_f4|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest1" AND ROUTINE_NAME = "bug16211_f1"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest1" AND ROUTINE_NAME = "bug16211_f2"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest2" AND ROUTINE_NAME = "bug16211_f3"|

SELECT dtd_identifier
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = "mysqltest2" AND ROUTINE_NAME = "bug16211_f4"|

SELECT CHARSET(bug16211_f1())|
SELECT CHARSET(bug16211_f2())|

SELECT CHARSET(mysqltest2.bug16211_f3())|
SELECT CHARSET(mysqltest2.bug16211_f4())|

-- Cleanup.

use test|

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|


--
-- BUG#16676: Database CHARSET not used for stored procedures
--

-- Prepare: create database with fixed, pre-defined character set.

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3|

-- Test case:

use mysqltest1|

--   - Create two stored procedures -- with and without explicit CHARSET-clause;

CREATE PROCEDURE bug16676_p1(
  IN p1 CHAR(10),
  INOUT p2 CHAR(10),
  OUT p3 CHAR(10))
BEGIN
  SELECT CHARSET(p1), COLLATION(p1);
  SELECT CHARSET(p2), COLLATION(p2);
  SELECT CHARSET(p3), COLLATION(p3);

CREATE PROCEDURE bug16676_p2(
  IN p1 CHAR(10) CHARSET koi8r,
  INOUT p2 CHAR(10) CHARSET cp1251,
  OUT p3 CHAR(10) CHARSET greek)
BEGIN
  SELECT CHARSET(p1), COLLATION(p1);
  SELECT CHARSET(p2), COLLATION(p2);
  SELECT CHARSET(p3), COLLATION(p3);

--   - Call procedures.

SET @v2 = 'b'|
SET @v3 = 'c'|

CALL bug16676_p1('a', @v2, @v3)|
CALL bug16676_p2('a', @v2, @v3)|

-- Cleanup.

use test|

DROP DATABASE mysqltest1|
--
-- BUG#8153: Stored procedure with subquery and continue handler, wrong result
--

--disable_warnings
drop table if exists t3|
drop table if exists t4|
drop procedure if exists bug8153_subselect|
drop procedure if exists bug8153_subselect_a|
drop procedure if exists bug8153_subselect_b|
drop procedure if exists bug8153_proc_a|
drop procedure if exists bug8153_proc_b|
--enable_warnings

create table t3 (a int)|
create table t4 (a int)|
insert into t3 values (1), (1), (2), (3)|
insert into t4 values (1), (1)|

--# Testing the use case reported in Bug#8153

create procedure bug8153_subselect()
begin
  declare continue handler for sqlexception
  begin
    select 'statement failed';
  update t3 set a=a+1 where (select a from t4 where a=1) is null;
  select 'statement after update';
select * from t3|

call bug8153_subselect()|
select * from t3|

drop procedure bug8153_subselect|

--# Testing a subselect with a non local handler

create procedure bug8153_subselect_a()
begin
  declare continue handler for sqlexception
  begin
    select 'in continue handler';

  select 'reachable code a1';
  select 'reachable code a2';

create procedure bug8153_subselect_b()
begin
  select 'reachable code b1';
  update t3 set a=a+1 where (select a from t4 where a=1) is null;
  select 'unreachable code b2';
select * from t3|

call bug8153_subselect_a()|
select * from t3|

drop procedure bug8153_subselect_a|
drop procedure bug8153_subselect_b|

--# Testing extra use cases, found while investigating
--# This is related to BUG#18787, with a non local handler

create procedure bug8153_proc_a()
begin
  declare continue handler for sqlexception
  begin
    select 'in continue handler';

  select 'reachable code a1';
  select 'reachable code a2';

create procedure bug8153_proc_b()
begin
  select 'reachable code b1';
  select no_such_function();
  select 'unreachable code b2';

drop procedure bug8153_proc_a|
drop procedure bug8153_proc_b|
drop table t3|
drop table t4|

--
-- BUG#19862: Sort with filesort by function evaluates function twice
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug19862|
CREATE TABLE t11 (a INT)|
CREATE TABLE t12 (a INT)|
CREATE FUNCTION bug19862(x INT) RETURNS INT
  BEGIN
    INSERT INTO t11 VALUES (x);
    RETURN x+1;
INSERT INTO t12 VALUES (1), (2)|
SELECT bug19862(a) FROM t12 ORDER BY 1|
-- No StreamingIterator before the sort, so does indeed get evaluated twice
-- (but there is no guarantee by the standard it won't).
--skip_if_hypergraph
SELECT * FROM t11|
DROP TABLE t11, t12|
DROP FUNCTION bug19862|


-- Bug#21002 "Derived table not selecting from a "real" table fails in JOINs"
--         
-- A regression caused by the fix for Bug#18444: for derived tables we should
-- set an empty string as the current database. They do not belong to any
-- database and must be usable even if there is no database
-- selected.
--disable_warnings
drop table if exists t3|
drop database if exists mysqltest1|
--enable_warnings
create table t3 (a int)|
insert into t3 (a) values (1), (2)|

create database mysqltest1|
use mysqltest1|
drop database mysqltest1|

-- No current database
select database()|

select * from (select 1 as a) as t1 natural join (select * from test.t3) as t2|
use test|
drop table t3|


-- Test for BUG#16899: Possible buffer overflow in handling of DEFINER-clause.
--
-- Prepare.

--disable_warnings
DROP PROCEDURE IF EXISTS bug16899_p1|
DROP FUNCTION IF EXISTS bug16899_f1|
--enable_warnings

--error ER_WRONG_STRING_LENGTH
CREATE DEFINER=1234567890abcdefGHIKLsdafdsjakfhkshfkshsndvkjsddngjhasdkjghskahfdksjhcnsndkhjkghskjfjsdhfkhskfdhksjdhfkjshfksh@localhost PROCEDURE bug16899_p1()
BEGIN
  SET @a = 1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X
  FUNCTION bug16899_f1() RETURNS INT
BEGIN
  RETURN 1;


--
-- BUG#21416: SP: Recursion level higher than zero needed for non-recursive call
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists bug21416|
create procedure bug21416() show create procedure bug21416|
call bug21416()|
drop procedure bug21416|


--
-- BUG#21414: SP: Procedure undroppable, to some extent
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS bug21414|

CREATE PROCEDURE bug21414() SELECT 1|

FLUSH TABLES WITH READ LOCK|

--error ER_CANT_UPDATE_WITH_READLOCK
DROP PROCEDURE bug21414|

UNLOCK TABLES|

--echo The following should succeed.
DROP PROCEDURE bug21414|

--
-- BUG#21493: Crash on the second call of a procedure containing
--            a select statement that uses an IN aggregating subquery  
--

CREATE TABLE t3 (
  Member_ID varchar(15) NOT NULL,
  PRIMARY KEY (Member_ID)
)|

CREATE TABLE t4 (
  ID int(10) unsigned NOT NULL auto_increment,
  Member_ID varchar(15) NOT NULL default '',
  Action varchar(12) NOT NULL,
  Action_Date datetime NOT NULL,
  Track varchar(15) default NULL,
  User varchar(12) default NULL,
  Date_Updated timestamp NOT NULL default CURRENT_TIMESTAMP on update
    CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  KEY Action (Action),
  KEY Action_Date (Action_Date)
)|


INSERT INTO t3(Member_ID) VALUES
  ('111111'), ('222222'), ('333333'), ('444444'), ('555555'), ('666666')|

INSERT INTO t4(Member_ID, Action, Action_Date, Track) VALUES
  ('111111', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('111111', 'Enrolled', '2006-03-01', 'CAD' ),
  ('111111', 'Disenrolled', '2006-07-03', 'CAD' ),
  ('222222', 'Enrolled', '2006-03-07', 'CAD' ),
  ('222222', 'Enrolled', '2006-03-07', 'CHF' ),
  ('222222', 'Disenrolled', '2006-08-02', 'CHF' ),
  ('333333', 'Enrolled', '2006-03-01', 'CAD' ),
  ('333333', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('444444', 'Enrolled', '2006-03-01', 'CAD' ),
  ('555555', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('555555', 'Enrolled', '2006-07-21', 'CAD' ),
  ('555555', 'Disenrolled', '2006-03-01', 'CHF' ),
  ('666666', 'Enrolled', '2006-02-09', 'CAD' ),
  ('666666', 'Enrolled', '2006-05-12', 'CHF' ),
  ('666666', 'Disenrolled', '2006-06-01', 'CAD' )|

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP FUNCTION IF EXISTS bug21493|

CREATE FUNCTION bug21493(paramMember VARCHAR(15)) RETURNS varchar(45)
BEGIN
DECLARE tracks VARCHAR(45);
SELECT GROUP_CONCAT(Track SEPARATOR ', ') INTO tracks FROM t4
  WHERE Member_ID=paramMember AND Action='Enrolled' AND 
        (Track,Action_Date) IN (SELECT Track, MAX(Action_Date) FROM t4
                                  WHERE Member_ID=paramMember GROUP BY Track);

SELECT bug21493('111111')|
SELECT bug21493('222222')|

SELECT bug21493(Member_ID) FROM t3|

DROP FUNCTION bug21493|
DROP TABLE t3,t4|

--
-- Bug#20028 Function with select return no data
--

--disable_warnings
drop function if exists func_20028_a|
drop function if exists func_20028_b|
drop function if exists func_20028_c|
drop procedure if exists proc_20028_a|
drop procedure if exists proc_20028_b|
drop procedure if exists proc_20028_c|
drop table if exists table_20028|
--enable_warnings

create table table_20028 (i int)|

SET @save_sql_mode=@@sql_mode|

SET sql_mode=''|

create function func_20028_a() returns integer
begin
  declare temp integer;
  select i into temp from table_20028 limit 1;

create function func_20028_b() returns integer
begin
  return func_20028_a();

create function func_20028_c() returns integer
begin
  declare div_zero integer;
  set SQL_MODE='TRADITIONAL';
  select 1/0 into div_zero;

create procedure proc_20028_a()
begin
  declare temp integer;
  select i into temp from table_20028 limit 1;

create procedure proc_20028_b()
begin
  call proc_20028_a();

create procedure proc_20028_c()
begin
  declare div_zero integer;
  set SQL_MODE='TRADITIONAL';
  select 1/0 into div_zero;

select func_20028_a()|
select func_20028_b()|
--error ER_DIVISION_BY_ZERO
select func_20028_c()|
call proc_20028_a()|
call proc_20028_b()|
--error ER_DIVISION_BY_ZERO
call proc_20028_c()|

SET sql_mode='TRADITIONAL'|

drop function func_20028_a|
drop function func_20028_b|
drop function func_20028_c|
drop procedure proc_20028_a|
drop procedure proc_20028_b|
drop procedure proc_20028_c|

create function func_20028_a() returns integer
begin
  declare temp integer;
  select i into temp from table_20028 limit 1;

create function func_20028_b() returns integer
begin
  return func_20028_a();

create function func_20028_c() returns integer
begin
  declare div_zero integer;
  set SQL_MODE='';
  select 1/0 into div_zero;

create procedure proc_20028_a()
begin
  declare temp integer;
  select i into temp from table_20028 limit 1;

create procedure proc_20028_b()
begin
  call proc_20028_a();

create procedure proc_20028_c()
begin
  declare div_zero integer;
  set SQL_MODE='';
  select 1/0 into div_zero;

select func_20028_a()|
select func_20028_b()|
select func_20028_c()|
call proc_20028_a()|
call proc_20028_b()|
call proc_20028_c()|

SET @@sql_mode=@save_sql_mode|

drop function func_20028_a|
drop function func_20028_b|
drop function func_20028_c|
drop procedure proc_20028_a|
drop procedure proc_20028_b|
drop procedure proc_20028_c|
drop table table_20028|

--
-- Bug#21462 Stored procedures with no arguments require parenthesis
--

--disable_warnings
drop procedure if exists proc_21462_a|
drop procedure if exists proc_21462_b|
--enable_warnings

create procedure proc_21462_a()
begin
  select "Called A";

create procedure proc_21462_b(x int)
begin
  select "Called B";

-- error ER_SP_WRONG_NO_OF_ARGS
call proc_21462_b|
-- error ER_SP_WRONG_NO_OF_ARGS
call proc_21462_b()|
call proc_21462_b(1)|

drop procedure proc_21462_a|
drop procedure proc_21462_b|


--
-- Bug#19733 "Repeated alter, or repeated create/drop, fails"
-- Check that CREATE/DROP INDEX is re-execution friendly.
-- 
--disable_warnings
drop table if exists t3|
drop procedure if exists proc_bug19733|
--enable_warnings
create table t3 (s1 int)|

create procedure proc_bug19733()
begin
  declare v int default 0;
    create index i on t3 (s1);
    drop index i on t3;
    set v = v + 1;
  end while;

drop procedure proc_bug19733|
drop table t3|


--
-- BUG#20492: Subsequent calls to stored procedure yeild incorrect
-- result if join is used 
--
-- Optimized ON expression in join wasn't properly saved for reuse.
--
--disable_warnings
DROP PROCEDURE IF EXISTS p1|
DROP VIEW IF EXISTS v1, v2|
DROP TABLE IF EXISTS t3, t4|
--enable_warnings

CREATE TABLE t3 (t3_id INT)|

INSERT INTO t3 VALUES (0)|
INSERT INTO t3 VALUES (1)|

CREATE TABLE t4 (t4_id INT)|

INSERT INTO t4 VALUES (2)|

CREATE VIEW v1 AS
SELECT t3.t3_id, t4.t4_id
FROM t3 JOIN t4 ON t3.t3_id = 0|

CREATE VIEW v2 AS
SELECT t3.t3_id AS t3_id_1, v1.t3_id AS t3_id_2, v1.t4_id
FROM t3 LEFT JOIN v1 ON t3.t3_id = 0|

CREATE PROCEDURE p1() SELECT * FROM v2|

-- Results should not differ.
CALL p1()|
CALL p1()|

DROP PROCEDURE p1|
DROP VIEW v1, v2|
DROP TABLE t3, t4|

--echo End of 5.0 tests

--echo Begin of 5.1 tests

--
-- BUG#18239: Possible to overload internal functions with stored functions
--

delimiter ;
drop function if exists pi;

create function pi() returns varchar(50)
return "pie, my favorite desert.";

SET @save_sql_mode=@@sql_mode;

SET SQL_MODE='IGNORE_SPACE';

select pi(), pi ();

-- Non deterministic warnings from db_load_routine
--disable_warnings ER_NATIVE_FCT_NAME_COLLISION ONCE
select test.pi(), test.pi ();

SET SQL_MODE='';

select pi(), pi ();

-- Non deterministic warnings from db_load_routine
select test.pi(), test.pi ();

SET @@sql_mode=@save_sql_mode;

drop function pi;

--
-- BUG#22619: Spaces considered harmful
--

--disable_warnings
drop function if exists test.database;
drop function if exists test.current_user;
drop function if exists test.sha2;

create database nowhere;
use nowhere;
drop database nowhere;

SET @save_sql_mode=@@sql_mode;

SET SQL_MODE='IGNORE_SPACE';

select database(), database ();
select current_user(), current_user ();
select sha2("aaa", 0), sha2 ("aaa", 0);

SET SQL_MODE='';

select database(), database ();
select current_user(), current_user ();
select sha2("aaa", 0), sha2 ("aaa", 0);

use test;

create function `database`() returns varchar(50)
return "Stored function database";

create function `current_user`() returns varchar(50)
return "Stored function current_user";

create function sha2(x varchar(50), y integer) returns varchar(50)
return "Stored function sha2";

SET SQL_MODE='IGNORE_SPACE';

select database(), database ();
select current_user(), current_user ();
select sha2("aaa", 0), sha2 ("aaa", 0);

-- Non deterministic warnings from db_load_routine
--disable_warnings
select test.database(), test.database ();
select test.current_user(), test.current_user ();
select test.sha2("aaa", 0), test.sha2 ("aaa", 0);

SET SQL_MODE='';

select database(), database ();
select current_user(), current_user ();
select sha2("aaa", 0), sha2 ("aaa", 0);

-- Non deterministic warnings from db_load_routine
--disable_warnings
select test.database(), test.database ();
select test.current_user(), test.current_user ();
select test.sha2("aaa", 0), test.sha2 ("aaa", 0);

SET @@sql_mode=@save_sql_mode;

drop function test.database;
drop function test.current_user;
drop function sha2;

use test;

--
-- BUG#23760: ROW_COUNT() and store procedure not owrking together
--
--disable_warnings
DROP TABLE IF EXISTS bug23760|
DROP TABLE IF EXISTS bug23760_log|
DROP PROCEDURE IF EXISTS bug23760_update_log|
DROP PROCEDURE IF EXISTS bug23760_test_row_count|
DROP FUNCTION IF EXISTS bug23760_rc_test|
--enable_warnings
CREATE TABLE bug23760 (
  id INT NOT NULL AUTO_INCREMENT ,
  num INT NOT NULL ,
  PRIMARY KEY ( id ) 
)|

CREATE TABLE bug23760_log (
 id INT NOT NULL AUTO_INCREMENT ,
 reason VARCHAR(50)NULL ,
 ammount INT NOT NULL ,
  PRIMARY KEY ( id ) 
)|

CREATE PROCEDURE bug23760_update_log(r Varchar(50), a INT)
BEGIN
  INSERT INTO bug23760_log (reason, ammount) VALUES(r, a);

CREATE PROCEDURE bug23760_test_row_count()
BEGIN
  UPDATE bug23760 SET num = num + 1;
  UPDATE bug23760 SET num = num - 1;


CREATE PROCEDURE bug23760_test_row_count2(level INT)
BEGIN
  IF level THEN
    UPDATE bug23760 SET num = num + 1;
    CALL bug23760_update_log('Test2 is working', ROW_COUNT());
    CALL bug23760_test_row_count2(level - 1);
  END IF;

CREATE FUNCTION bug23760_rc_test(in_var INT) RETURNS INT RETURN in_var|

INSERT INTO bug23760 (num) VALUES (0), (1), (1), (2), (3), (5), (8)|
SELECT ROW_COUNT()|

CALL bug23760_test_row_count()|
SELECT * FROM bug23760_log ORDER BY id|

SET @save_max_sp_recursion= @@max_sp_recursion_depth|
SELECT @save_max_sp_recursion|
SET max_sp_recursion_depth= 5|
SELECT @@max_sp_recursion_depth|
CALL bug23760_test_row_count2(2)|
SELECT ROW_COUNT()|
SELECT * FROM bug23760_log ORDER BY id|
SELECT * FROM bug23760 ORDER by ID|
SET max_sp_recursion_depth= @save_max_sp_recursion|

SELECT bug23760_rc_test(123)|
INSERT INTO bug23760 (num) VALUES (13), (21), (34), (55)|
SELECT bug23760_rc_test(ROW_COUNT())|

DROP TABLE bug23760, bug23760_log|
DROP PROCEDURE bug23760_update_log|
DROP PROCEDURE bug23760_test_row_count|
DROP PROCEDURE bug23760_test_row_count2|
DROP FUNCTION bug23760_rc_test|

--
-- BUG#24117: server crash on a FETCH with a cursor on a table which is not in
--            the table cache
--

--disable_warnings
DROP PROCEDURE IF EXISTS bug24117|
DROP TABLE IF EXISTS t3|
--enable_warnings
CREATE TABLE t3(c1 ENUM('abc'))|
INSERT INTO t3 VALUES('abc')|
CREATE PROCEDURE bug24117()
BEGIN
  DECLARE t3c1 ENUM('abc');
DROP PROCEDURE bug24117|
DROP TABLE t3|

--
-- Bug#8407(Stored functions/triggers ignore exception handler)
--

--disable_warnings
drop function if exists func_8407_a|
drop function if exists func_8407_b|
--enable_warnings

create function func_8407_a() returns int
begin
  declare x int;

  select 1 from no_such_view limit 1 into x;

create function func_8407_b() returns int
begin
  declare x int default 0;
    set x:= x+1000;
    when 1 then set x:= x+1;
    when 2 then set x:= x+2;
    else set x:= x+100;
  end case;
  set x:=x + 500;
  
  return x;

select func_8407_a()|
select func_8407_b()|

drop function func_8407_a|
drop function func_8407_b|

--
-- Bug#26503 (Illegal SQL exception handler code causes the server to crash)
--

--disable_warnings
drop table if exists table_26503|
drop procedure if exists proc_26503_ok_1|
drop procedure if exists proc_26503_ok_2|
drop procedure if exists proc_26503_ok_3|
drop procedure if exists proc_26503_ok_4|
--enable_warnings

create table table_26503(a int unique)|

create procedure proc_26503_ok_1(v int)
begin
  declare i int default 5;
    select 'caught something';
    retry:
    while i > 0 do
      begin
        set i = i - 1;
        select 'looping', i;
        iterate retry;
        select 'dead code';
      end;
    end while retry;
    select 'leaving handler';

  select 'do something';
  insert into table_26503 values (v);
  select 'do something again';
  insert into table_26503 values (v);

create procedure proc_26503_ok_2(v int)
begin
  declare i int default 5;
    select 'caught something';
    retry:
    while i > 0 do
      begin
        set i = i - 1;
        select 'looping', i;
        leave retry;
        select 'dead code';
      end;
    end while;
    select 'leaving handler';

  select 'do something';
  insert into table_26503 values (v);
  select 'do something again';
  insert into table_26503 values (v);

--# The outer retry label should not prevent using the inner label.

create procedure proc_26503_ok_3(v int)
begin
  declare i int default 5;
    declare continue handler for sqlexception
    begin
      select 'caught something';
      retry:
      while i > 0 do
        begin
          set i = i - 1;
          select 'looping', i;
          iterate retry;
          select 'dead code';
        end;
      end while retry;
      select 'leaving handler';
    end;

    select 'do something';
    insert into table_26503 values (v);
    select 'do something again';
    insert into table_26503 values (v);

--# The outer retry label should not prevent using the inner label.

create procedure proc_26503_ok_4(v int)
begin
  declare i int default 5;
    declare continue handler for sqlexception
    begin
      select 'caught something';
      retry:
      while i > 0 do
        begin
          set i = i - 1;
          select 'looping', i;
          leave retry;
          select 'dead code';
        end;
      end while;
      select 'leaving handler';
    end;

    select 'do something';
    insert into table_26503 values (v);
    select 'do something again';
    insert into table_26503 values (v);

drop table table_26503|
drop procedure proc_26503_ok_1|
drop procedure proc_26503_ok_2|
drop procedure proc_26503_ok_3|
drop procedure proc_26503_ok_4|

--
-- Bug#25373: Stored functions wasn't compared correctly which leads to a wrong
--            result.
--
--disable_warnings
DROP FUNCTION IF EXISTS bug25373|
CREATE FUNCTION bug25373(p1 INTEGER) RETURNS INTEGER
LANGUAGE SQL DETERMINISTIC
RETURN p1;
CREATE TABLE t3 (f1 INT, f2 FLOAT)|
INSERT INTO t3 VALUES (1, 3.4), (1, 2), (1, 0.9), (2, 8), (2, 7)|
SELECT SUM(f2), bug25373(f1) FROM t3 GROUP BY bug25373(f1) WITH ROLLUP|
DROP FUNCTION bug25373|
DROP TABLE t3|


--
-- BUG#25082: Default database change on trigger execution breaks replication.
--
-- As it turned out, this bug has actually two bugs. So, here we have two test
-- cases -- one in sp.test, the other in sp-security.test.
--

--
-- Test case 1: error on dropping the current database.
--

-- Prepare.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1|
CREATE DATABASE mysqltest2|

-- Test.

CREATE PROCEDURE mysqltest1.p1()
  DROP DATABASE mysqltest2|

use mysqltest2|

CALL mysqltest1.p1()|

SELECT DATABASE()|

-- Cleanup.

DROP DATABASE mysqltest1|

use test|


--
-- Bug#20777: Function w BIGINT UNSIGNED shows diff. behaviour --ps-protocol
--disable_warnings
drop function if exists bug20777|
drop table if exists examplebug20777|
--enable_warnings
create function bug20777(f1 bigint unsigned) returns bigint unsigned
begin
  set f1 = (f1 - 10);
select bug20777(9223372036854775803) as '9223372036854775803   2**63-5';
select bug20777(9223372036854775804) as '9223372036854775804   2**63-4';
select bug20777(9223372036854775805) as '9223372036854775805   2**63-3';
select bug20777(9223372036854775806) as '9223372036854775806   2**63-2';
select bug20777(9223372036854775807) as '9223372036854775807   2**63-1';
select bug20777(9223372036854775808) as '9223372036854775808   2**63+0';
select bug20777(9223372036854775809) as '9223372036854775809   2**63+1';
select bug20777(9223372036854775810) as '9223372036854775810   2**63+2';
select bug20777(-9223372036854775808) as 'lower bounds signed bigint';
select bug20777(9223372036854775807) as 'upper bounds signed bigint';
select bug20777(0) as 'lower bounds unsigned bigint';
select bug20777(18446744073709551615) as 'upper bounds unsigned bigint';
select bug20777(18446744073709551616) as 'upper bounds unsigned bigint + 1';
select bug20777(-1) as 'lower bounds unsigned bigint - 1';

create table examplebug20777 as select 
  0 as 'i',
  bug20777(9223372036854775806) as '2**63-2',
  bug20777(9223372036854775807) as '2**63-1',
  bug20777(9223372036854775808) as '2**63',
  bug20777(9223372036854775809) as '2**63+1',
  bug20777(18446744073709551614) as '2**64-2',
  bug20777(18446744073709551615) as '2**64-1', 
  bug20777(18446744073709551616) as '2**64';
insert into examplebug20777 values (1, 9223372036854775806, 9223372036854775807, 223372036854775808, 9223372036854775809, 18446744073709551614, 18446744073709551615, 8446744073709551616);
select * from examplebug20777 order by i;

drop table examplebug20777;
select bug20777(18446744073709551613)+1;
drop function bug20777;


--
-- BUG#5274: Stored procedure crash if length of CHAR variable too great.
--

-- Prepare.

--disable_warnings
DROP FUNCTION IF EXISTS bug5274_f1|
DROP FUNCTION IF EXISTS bug5274_f2|
--enable_warnings

-- Test.

CREATE FUNCTION bug5274_f1(p1 CHAR) RETURNS CHAR
  RETURN CONCAT(p1, p1)|

CREATE FUNCTION bug5274_f2() RETURNS CHAR
BEGIN
  DECLARE v1 INT DEFAULT 0;
    SET v1 = v1 + 1;
    SET v2 = bug5274_f1(v2);
  END WHILE;
 
SELECT bug5274_f2()|

-- Cleanup.

DROP FUNCTION bug5274_f1|
DROP FUNCTION bug5274_f2|

--
-- Bug#21513 (SP having body starting with quoted label rendered unusable)
--
--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists proc_21513|

create procedure proc_21513()`my_label`:BEGIN END|
show create procedure proc_21513|

drop procedure proc_21513|

--##
--echo End of 5.0 tests.

--
-- BUG#NNNN: New bug synopsis
--
----disable_warnings ER_SP_DOES_NOT_EXIST ONCE
--drop procedure if exists bugNNNN|
--#create procedure bugNNNN...
--
-- Add bugs above this line. Use existing tables t1 and t2 when
-- practical, or create table t3,t4 etc temporarily (and drop them).
-- NOTE: The delimiter is `|`, and not `;
--       at the end of the file!
--

delimiter ;
drop table t1,t2;

-- Disable warnings to allow test run without InnoDB
--disable_warnings
CREATE TABLE t1 (a int auto_increment primary key) engine=MyISAM;
CREATE TABLE t2 (a int auto_increment primary key, b int) engine=innodb;
set @a=0;
CREATE function bug27354() RETURNS int not deterministic
begin
insert into t1 values (null);
set @a=@a+1;
update t2 set b=1 where a=bug27354();
select count(t_1.a),count(t_2.a) from t1 as t_1, t2 as t_2 /* must be 0,0 */;
insert into t2 values (1,1),(2,2),(3,3);
update t2 set b=-b where a=bug27354();
select * from t2 /* must return 1,-1 ... */;
select count(*) from t1 /* must be 3 */;


drop table t1,t2;
drop function   bug27354;

--
-- Bug #28605: SHOW CREATE VIEW with views using stored_procedures no longer
-- showing SP names.
--
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2);

CREATE FUNCTION metered(a INT) RETURNS INT RETURN 12;

CREATE VIEW v1 AS SELECT test.metered(a) as metered FROM t1;

DROP VIEW v1;
DROP FUNCTION metered;
DROP TABLE t1;

--
-- Bug#29834: Accessing a view column by name in SP/PS causes a memory leak.
--
-- This is leak test. Run with large number assigned to $execute_cnt,
-- $p1_cnt, $p2_cnt, @p1_p2_cnt, $f1_normal_cnt or $f1_prep_cnt variables.
--

let $execute_cnt= 2;
let $p1_cnt= 2;
let $p2_cnt= 2;
SET @p1_p2_cnt= 2;
let $f1_normal_cnt= 2;
let $f1_prep_cnt= 2;

CREATE TABLE t1 (c1 INT);
CREATE VIEW v1 AS SELECT * FROM t1;
{
  EXECUTE s1;
  dec $execute_cnt;

CREATE PROCEDURE p1(IN loops BIGINT(19) UNSIGNED)
BEGIN
  WHILE loops > 0 DO
    SELECT c1 FROM v1;
    SET loops = loops - 1;
  END WHILE;

CREATE PROCEDURE p2(IN loops BIGINT(19) UNSIGNED)
BEGIN
  WHILE loops > 0 DO
    SELECT c1 FROM v1;
    CALL p1(@p1_p2_cnt);
    SET loops = loops - 1;
  END WHILE;

CREATE FUNCTION f1(loops INT UNSIGNED)
  RETURNS INT
BEGIN
  DECLARE tmp INT;
    SELECT c1 INTO tmp FROM v1;
    SET loops = loops - 1;
  END WHILE;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP FUNCTION f1;
DROP VIEW v1;
DROP TABLE t1;

--
-- Bug#28551 "The warning 'No database selected' is reported when calling
-- stored procedures"
--
create database mysqltest_db1;
create procedure mysqltest_db1.sp_bug28551() begin end;
drop database mysqltest_db1;
drop database if exists mysqltest_db1;
drop table if exists test.t1;
create database mysqltest_db1;
use mysqltest_db1;
drop database mysqltest_db1;
create table test.t1 (id int);
insert into test.t1 (id) values (1);
create procedure test.sp_bug29050() begin select * from t1;
use test;
drop procedure sp_bug29050;
drop table t1;

--
-- Bug #30120 SP with local variables with non-ASCII names crashes server.
--

SET NAMES latin1;

CREATE PROCEDURE p1()
BEGIN
  DECLARE ��� INT;
  SELECT ���;

SET NAMES default;
DROP PROCEDURE p1;

--
-- Bug#25411 (trigger code truncated)
--

--disable_warnings
drop procedure if exists proc_25411_a;
drop procedure if exists proc_25411_b;
drop procedure if exists proc_25411_c;

create procedure proc_25411_a()
begin
  /* real comment */
  select 1;
  /*! select 2;
  select 3;
end
$$

create procedure proc_25411_b(
/* real comment */
/*! p1 int, */
/*!00000 p2 int */
/*!99999 ,p3 int */
)
begin
  select p1, p2;
end
$$

create procedure proc_25411_c()
begin
  select 1/*!,2*//*!00000,3*//*!99999,4*/;
  select 1/*! ,2*//*!00000 ,3*//*!99999 ,4*/;
  select 1/*!,2 *//*!00000,3 *//*!99999,4 */;
  select 1/*! ,2 *//*!00000 ,3 *//*!99999 ,4 */;
  select 1 /*!,2*/ /*!00000,3*/ /*!99999,4*/ ;
end
$$

delimiter ;
select routine_name, routine_definition from information_schema.routines where routine_name like '%25411%';
select parameter_name from information_schema.parameters where SPECIFIC_NAME= '%25411%';

drop procedure proc_25411_a;
drop procedure proc_25411_b;
drop procedure proc_25411_c;


--
-- Bug#26302 (MySQL server cuts off trailing "*/" from comments in SP/func)
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists proc_26302;

create procedure proc_26302()
select 1 /* testing */;

select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
where ROUTINE_NAME = "proc_26302";

drop procedure proc_26302;


-- Bug #29338: no optimization for stored functions with a trivial body
-- always returning constant.
--

CREATE FUNCTION f1() RETURNS INT DETERMINISTIC RETURN 2;
CREATE FUNCTION f2(I INT) RETURNS INT DETERMINISTIC RETURN 3;

CREATE TABLE t1 (c1 INT, INDEX(c1));

INSERT INTO t1 VALUES (1), (2), (3), (4), (5);

CREATE VIEW v1 AS SELECT c1 FROM t1;


DROP VIEW v1;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP TABLE t1;

--
-- Bug#29408 Cannot find view in columns table if the selection contains a function
--
delimiter |;

create function f1()
    returns int(11)
not deterministic
contains sql
sql security definer
comment ''
begin
  declare x int(11);
  set x=-1;
                          
delimiter ;
                  
create view v1 as select 1 as one, f1() as days;
                          
connect (bug29408, localhost, root,,*NO-ONE*);
select column_name from information_schema.columns
where table_name='v1' and table_schema='test' order by column_name;

drop view v1;
drop function f1;

--
-- Bug#13675: DATETIME/DATE type in store proc param seems to be converted as
-- varbinary
--

--echo
--echo -- Bug#13675.
--echo

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

DROP TABLE IF EXISTS t1;

CREATE PROCEDURE p1(v DATETIME) CREATE TABLE t1 SELECT v;

CREATE PROCEDURE p2(v INT) CREATE TABLE t1 SELECT v;
DROP TABLE t1;
DROP TABLE t1;
DROP TABLE t1;
DROP TABLE t1;
DROP PROCEDURE p1;
DROP PROCEDURE p2;

--
-- Bug#31035: select from function, group by result crasher.
--

--##########################################################################

--echo

--echo --
--echo -- Bug#31035.
--echo --

--echo

--echo --
--echo -- - Prepare.
--echo --

--echo

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;

CREATE TABLE t1(c1 INT);

INSERT INTO t1 VALUES (1), (2), (3);

CREATE FUNCTION f1()
  RETURNS INT
  NOT DETERMINISTIC
    RETURN 1;

CREATE FUNCTION f2(p INT)
  RETURNS INT
  NOT DETERMINISTIC
    RETURN 1;

CREATE FUNCTION f3()
  RETURNS INT
  DETERMINISTIC
    RETURN 1;

CREATE FUNCTION f4(p INT)
  RETURNS INT
  DETERMINISTIC
    RETURN 1;

-- Not deterministic function, no arguments.

SELECT f1() AS a FROM t1 GROUP BY a;

-- Not deterministic function, non-constant argument.

SELECT f2(@a) AS a FROM t1 GROUP BY a;

-- Deterministic function, no arguments.

SELECT f3() AS a FROM t1 GROUP BY a;

-- Deterministic function, constant argument.

SELECT f4(0) AS a FROM t1 GROUP BY a;

-- Deterministic function, non-constant argument.

SELECT f4(@a) AS a FROM t1 GROUP BY a;

DROP TABLE t1;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP FUNCTION f4;

--
-- Bug#31191: JOIN in combination with stored function crashes the server.
--

--##########################################################################

--echo --
--echo -- Bug#31191.
--echo --

--echo

--echo --
--echo -- - Prepare.
--echo --

--echo

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP FUNCTION IF EXISTS f1;

CREATE TABLE t1 (
   id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
   barcode INT(8) UNSIGNED ZEROFILL nOT NULL,
   PRIMARY KEY  (id),
   UNIQUE KEY barcode (barcode)
);

INSERT INTO t1 (id, barcode) VALUES (1, 12345678);
INSERT INTO t1 (id, barcode) VALUES (2, 12345679);

CREATE TABLE test.t2 (
   id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
   barcode BIGINT(11) UNSIGNED ZEROFILL NOT NULL,
   PRIMARY KEY  (id)
);

INSERT INTO test.t2 (id, barcode) VALUES (1, 12345106708);
INSERT INTO test.t2 (id, barcode) VALUES (2, 12345106709);

CREATE FUNCTION f1(p INT(8))
  RETURNS BIGINT(11) UNSIGNED
  READS SQL DATA
    RETURN FLOOR(p/1000)*1000000 + 100000 + FLOOR((p MOD 1000)/10)*100 + (p MOD 10);

SELECT DISTINCT t1.barcode, f1(t1.barcode)
FROM t1
INNER JOIN t2
ON f1(t1.barcode) = t2.barcode
WHERE t1.barcode=12345678;

DROP TABLE t1;
DROP TABLE t2;
DROP FUNCTION f1;

--
-- Bug#31226: Group by function crashes mysql.
--

--##########################################################################

--echo --
--echo -- Bug#31226.
--echo --

--echo

--echo --
--echo -- - Prepare.
--echo --

--echo

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;

CREATE TABLE t1(id INT);

INSERT INTO t1 VALUES (1), (2), (3);

CREATE FUNCTION f1()
  RETURNS DATETIME
  NOT DETERMINISTIC NO SQL
    RETURN NOW();
SELECT f1() FROM t1 GROUP BY 1;

DROP TABLE t1;
DROP FUNCTION f1;

--
-- Bug#28318 (CREATE FUNCTION (UDF) requires a schema)
--

--disable_warnings
DROP PROCEDURE IF EXISTS db28318_a.t1;
DROP PROCEDURE IF EXISTS db28318_b.t2;
DROP DATABASE IF EXISTS db28318_a;
DROP DATABASE IF EXISTS db28318_b;

CREATE DATABASE db28318_a;
CREATE DATABASE db28318_b;

CREATE PROCEDURE db28318_a.t1() SELECT "db28318_a.t1";
CREATE PROCEDURE db28318_b.t2() CALL t1();

use db28318_a;

-- In db28318_b.t2, t1 refers to db28318_b.t1
--error ER_SP_DOES_NOT_EXIST
CALL db28318_b.t2();

DROP PROCEDURE db28318_a.t1;
DROP PROCEDURE db28318_b.t2;
DROP DATABASE db28318_a;
DROP DATABASE db28318_b;
use test;

--
-- Bug#29770 Two handlers are allowed to catch an error in an stored procedure.
--

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS bug29770;

CREATE TABLE t1(a int);
CREATE PROCEDURE bug29770()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '42S22' SET @state:= 'run';
  SELECT x FROM t1;
SELECT @state, @exception;
DROP TABLE t1;
DROP PROCEDURE bug29770;

--
-- Bug#33618 Crash in sp_rcontext
--

use test;
drop table if exists t_33618;
drop procedure if exists proc_33618;

create table t_33618 (`a` int, unique(`a`), `b` varchar(30)) engine=myisam;
insert into t_33618 (`a`,`b`) values (1,'1'),(2,'2');

create procedure proc_33618(num int)
begin
  declare count1 int default '0';
    set num=num-1;
    begin
      declare cur1 cursor for select `a` from t_33618;
      declare continue handler for not found set last_row = 1;
      set last_row:=0;
      open cur1;
      rep1:
      repeat
        begin
          declare exit handler for 1062 begin end;
          fetch cur1 into vb;
          if (last_row = 1) then
            leave rep1;
          end if;
        end;
        until last_row=1
      end repeat;
      close cur1;
    end;
  end while;

drop table t_33618;
drop procedure proc_33618;
use test;
drop function if exists func30787;
create table t1(f1 int);
insert into t1 values(1),(2);
create function func30787(p1 int) returns int
begin
  return p1;
end |
delimiter ;
select (select func30787(f1)) as ttt from t1;
drop function func30787;
drop table t1;

--
-- Bug #33811: Call to stored procedure with SELECT * / RIGHT JOIN fails
-- after the first time
--
CREATE TABLE t1 (id INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);

CREATE PROCEDURE test_sp()
  SELECT t1.* FROM t1 RIGHT JOIN t1 t2 ON t1.id=t2.id;

DROP PROCEDURE test_sp;
DROP TABLE t1;
--

create table t1(c1 INT);
create function f1(p1 int) returns varchar(32)
  return 'aaa';
create view v1 as select f1(c1) as parent_control_name from t1;
create procedure p1()
begin
    select parent_control_name as c1 from v1;
end //
delimiter ;

drop procedure p1;
drop function f1;
drop view v1;
drop table t1;

--
-- Bug#38469 invalid memory read and/or crash with utf8mb3 text field, stored procedure, uservar 
--
delimiter $;
drop procedure if exists `p2` $
create procedure `p2`(in `a` text charset utf8mb3)
begin
        declare `pos` int default 1;
        declare `str` text charset utf8mb3;
        set `str` := `a`;
        select substr(`str`, `pos`+ 1 ) into `str`;
end $
delimiter ;
drop procedure `p2`;

--
-- Bug#38823: Invalid memory access when a SP statement does wildcard expansion
--

--disable_warnings
drop table if exists t1;
drop procedure if exists p1;
create procedure p1() begin select * from t1;
create table t1 (a integer)$
call p1$
alter table t1 add b integer;

drop table t1;
drop procedure p1;

--
-- Bug#20550: Stored function: wrong RETURN type metadata when used in a VIEW.
--

--##########################################################################

--echo

--echo --
--echo -- Bug#20550.
--echo --

--echo

--echo --
--echo -- - Prepare.
--echo --

--echo

--disable_warnings
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;

CREATE FUNCTION f1() RETURNS VARCHAR(65525) RETURN 'Hello';

CREATE FUNCTION f2() RETURNS TINYINT RETURN 1;

CREATE VIEW v1 AS SELECT f1();

CREATE VIEW v2 AS SELECT f2();

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v2';

DROP FUNCTION f1;
DROP FUNCTION f2;
DROP VIEW v1;
DROP VIEW v2;

--
-- Bug#24923: Functions with ENUM issues.
--

--##########################################################################

--echo --
--echo -- - Bug#24923: prepare.
--echo --

--echo

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP FUNCTION IF EXISTS f1;

CREATE FUNCTION f1(p INT)
  RETURNS ENUM ('Very_long_enum_element_identifier',
                'Another_very_long_enum_element_identifier')
  BEGIN
    CASE p
    WHEN 1 THEN
      RETURN 'Very_long_enum_element_identifier';
    ELSE
      RETURN 'Another_very_long_enum_element_identifier';
    END CASE;

SELECT f1(1);

SELECT f1(2);

DROP FUNCTION f1;

--
-- Bug#32633 Can not create any routine if SQL_MODE=no_engine_substitution
--
-- Ensure that when new SQL modes are introduced, they are also added to the
-- mysql.routines table.
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
drop procedure if exists p;
set @old_mode= @@sql_mode;
set @@sql_mode= cast(pow(2,33)-1 as unsigned integer) & ~0x1003ff00;
select @@sql_mode into @full_mode;
create procedure p() begin end;
set @@sql_mode= @old_mode;
select routine_name from information_schema.routines where routine_name = 'p' and sql_mode = @full_mode;
drop procedure p;

--
-- Bug#43962 "Packets out of order" calling a SHOW TABLE STATUS
--
DELIMITER //;
CREATE DEFINER = 'root'@'localhost' PROCEDURE p1()
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
 SHOW TABLE STATUS like 't1';


CREATE TABLE t1 (f1 INT);
let $tab_count= 4;
 dec $tab_count ;
DROP PROCEDURE p1;
DROP TABLE t1;

--
-- Bug#47649 crash during CALL procedure
--
CREATE TABLE t1 ( f1 integer, primary key (f1));
CREATE TABLE t2 LIKE t1;
CREATE TEMPORARY TABLE t3 LIKE t1;
CREATE PROCEDURE p1 () BEGIN SELECT f1 FROM t3 AS A WHERE A.f1 IN ( SELECT f1 FROM t3 ) ;
CREATE VIEW t3 AS SELECT f1 FROM t2 A WHERE A.f1 IN ( SELECT f1 FROM t2 );
DROP TABLE t3;
DROP PROCEDURE p1;
DROP TABLE t1, t2;
DROP VIEW t3;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT, b INT PRIMARY KEY);
CREATE PROCEDURE p1 () 
BEGIN 
  SELECT a FROM t1 A WHERE A.b IN (SELECT b FROM t2 AS B);
DROP PROCEDURE p1;
DROP TABLE t1, t2;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
CREATE PROCEDURE p1()
BEGIN
  DECLARE v INT DEFAULT 0;
  SET @@SESSION.v= 10;

CREATE PROCEDURE p2()
BEGIN
  DECLARE v INT DEFAULT 0;
  SET v= 10;
CREATE PROCEDURE p3()
BEGIN
  DECLARE v INT DEFAULT 0;
  SELECT @@SESSION.v;
CREATE PROCEDURE p4()
BEGIN
  DECLARE v INT DEFAULT 0;
  SET @@GLOBAL.v= 10;

CREATE PROCEDURE p5()
BEGIN
  DECLARE init_connect INT DEFAULT 0;
  SET init_connect= 10;
  SET @@GLOBAL.init_connect= 'SELECT 1';
  SET @@SESSION.IDENTITY= 1;
  SELECT @@SESSION.IDENTITY;
  SELECT @@GLOBAL.init_connect;
  SELECT init_connect;
CREATE PROCEDURE p6()
BEGIN
  DECLARE v INT DEFAULT 0;
  SET @@v= 0;

SET @old_init_connect= @@GLOBAL.init_connect;
SET @@GLOBAL.init_connect= @old_init_connect;

DROP PROCEDURE p2;
DROP PROCEDURE p5;
CREATE DATABASE mixedCaseDbName;
CREATE PROCEDURE mixedCaseDbName.tryMyProc() begin end|
CREATE FUNCTION mixedCaseDbName.tryMyFunc() returns text begin return 'IT WORKS';
select mixedCaseDbName.tryMyFunc();
DROP DATABASE mixedCaseDbName;

CREATE TABLE t1 (a INT, b INT, KEY(b));
CREATE TABLE t2 (c INT, d INT, KEY(c));
INSERT INTO t1 VALUES (1,1),(1,1),(1,2);
INSERT INTO t2 VALUES (1,1),(1,2);

CREATE FUNCTION f1() RETURNS INT DETERMINISTIC
BEGIN
  DECLARE a int;
  -- SQL statement inside
  SELECT 1 INTO a;
END $

DELIMITER ;

SELECT COUNT(DISTINCT d) FROM t1, t2  WHERE a = c AND b = f1();

DROP FUNCTION f1;
DROP TABLE t1, t2;

--
-- Bug#39255: Stored procedures: crash if function references nonexistent table
--

--disable_warnings
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t_non_existing;
DROP TABLE IF EXISTS t1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
   DECLARE v INT;
   SELECT a INTO v FROM t_non_existing;

CREATE TABLE t1 (a INT) ENGINE = myisam;
INSERT INTO t1 VALUES (1);
SELECT * FROM t1 WHERE a = f1();

DROP FUNCTION f1;
DROP TABLE t1;

--
-- Bug#36649: Condition area is not properly cleaned up after stored routine invocation
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1(a INT, b CHAR)
BEGIN
  IF a > 0 THEN
    CALL p1(a-1, 'ab');
    SELECT 1;
  END IF;

SET @save_max_sp_recursion= @@max_sp_recursion_depth;
SET @@max_sp_recursion_depth= 5;
SET @@max_sp_recursion_depth= @save_max_sp_recursion;

DROP PROCEDURE p1;

--
-- Ensure that rules for message list clean up are being respected.
--

--disable_warnings ER_SP_DOES_NOT_EXIST ONCE
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1(a CHAR)
BEGIN
  SELECT 1;
  SELECT CAST('10x' as UNSIGNED INTEGER);

DROP PROCEDURE p1;

--
-- Cascading stored procedure/function calls.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
DROP PROCEDURE IF EXISTS p4;
CREATE PROCEDURE p1()
  CALL p2()|
CREATE PROCEDURE p2()
  CALL p3()|
CREATE PROCEDURE p3()
  CALL p4()|
CREATE PROCEDURE p4()
BEGIN
  SELECT 1;
  SELECT CAST('10x' as UNSIGNED INTEGER);

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP PROCEDURE p4;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a CHAR(2));

INSERT INTO t1 VALUES ('aa');
CREATE FUNCTION f1() RETURNS CHAR
  RETURN (SELECT f2())|
CREATE FUNCTION f2() RETURNS CHAR
  RETURN (SELECT f3())|
CREATE FUNCTION f3() RETURNS CHAR
  RETURN (SELECT f4())|
CREATE FUNCTION f4() RETURNS CHAR
BEGIN
  RETURN (SELECT a FROM t1);

SELECT f1();

DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP FUNCTION f4;
DROP TABLE t1;
DROP PROCEDURE IF EXISTS p1;

CREATE PROCEDURE p1 ()
COMMENT
'12345678901234567890123456789012345678901234567890123456789012345678901234567890'
BEGIN
END;

SELECT routine_comment FROM information_schema.routines WHERE routine_name = "p1";

DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS t1, t2_unrelated;
DROP PROCEDURE IF EXISTS p1;

CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE VIEW t1 AS SELECT 10 AS f1;

CREATE TEMPORARY TABLE t1 (f1 INT);

DROP VIEW t1;
SELECT * FROM t1;

DROP TEMPORARY TABLE t1;
DROP PROCEDURE p1;

CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE VIEW t1 AS SELECT 10 AS f1;
CREATE VIEW v2_unrelated AS SELECT 1 AS r1;

CREATE TEMPORARY TABLE t1 (f1 int);

ALTER VIEW v2_unrelated AS SELECT 2 AS r1;
SELECT * FROM t1;

DROP TEMPORARY TABLE t1;
DROP VIEW t1, v2_unrelated;
DROP PROCEDURE p1;

CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE TEMPORARY TABLE t1 (f1 INT);

CREATE VIEW t1 AS SELECT 10 AS f1;

DROP VIEW t1;
SELECT * FROM t1;

DROP TEMPORARY TABLE t1;
DROP PROCEDURE p1;
drop table if exists t1;
drop procedure if exists p1;
create table t1 (c1 int);
insert into t1 (c1) values (1), (2), (3), (4), (5);
create procedure p1()
begin
  declare a integer;
  select * from t1 limit a, b;
drop table t1;
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4), (5);
drop table t1;
create table t1 (c1 int);
insert into t1 (c1) values (1), (2), (3), (4), (5);
drop procedure p1;
create procedure p1(p1 integer, p2 integer)
  select * from t1 limit a, b;
create procedure p1(p1 date, p2 date) select * from t1 limit p1, p2;
create procedure p1(p1 integer, p2 float) select * from t1 limit p1, p2;
create procedure p1(p1 integer, p2 char(1)) select * from t1 limit p1, p2;
create procedure p1(p1 varchar(5), p2 char(1)) select * from t1 limit p1, p2;
create procedure p1(p1 decimal, p2 decimal) select * from t1 limit p1, p2;
create procedure p1(p1 double, p2 double) select * from t1 limit p1, p2;
create procedure p1(p1 integer, p2 integer)
  select * from t1 limit p1, p2;
create function f1(p1 integer, p2 integer)
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit a, b);

create function f1()
  returns int
begin
  declare a, b, c int;
  set a = (select count(*) from t1 limit b, c);
select f1();

drop function f1;
create function f1(p1 date, p2 date)
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);
create function f1(p1 integer, p2 float)
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);
create function f1(p1 integer, p2 char(1))
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);
create function f1(p1 varchar(5), p2 char(1))
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);
create function f1(p1 decimal, p2 decimal)
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);
create function f1(p1 double, p2 double)
  returns int
begin
  declare a int;
  set a = (select count(*) from t1 limit p1, p2);

create function f1(p1 integer, p2 integer)
returns int
begin
  declare count int;
  set count= (select count(*) from (select * from t1 limit p1, p2) t_1);

select f1(0, 0);
select f1(0, -1);
select f1(-1, 0);
select f1(-1, -1);
select f1(0, 1);
select f1(1, 0);
select f1(1, 5);
select f1(3, 2);
drop table t1;
drop procedure p1;
drop function f1;

CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
CREATE VIEW v1 AS SELECT a FROM t2;
CREATE PROCEDURE proc() SELECT * FROM t1 NATURAL JOIN v1;
ALTER TABLE t2 CHANGE COLUMN a b CHAR;
DROP TABLE t1,t2;
DROP VIEW v1;
DROP PROCEDURE proc;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
CREATE TABLE t3(a INT);

CREATE PROCEDURE p1()
  INSERT INTO t1(a) VALUES (1);
CREATE TRIGGER t1_ai AFTER INSERT ON t1
  FOR EACH ROW
    INSERT INTO t2(a) VALUES (new.a);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1
  FOR EACH ROW
    INSERT INTO t3(a) VALUES (new.a);
DROP TABLE t1, t2, t3;
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET utf8mb3);
INSERT INTO t1 VALUES ('a');

CREATE PROCEDURE p1(dt DATETIME, i INT)
BEGIN
  SELECT
    CASE
      WHEN i = 1 THEN 2
      ELSE dt
    END AS x1;

  SELECT
    CASE _latin1'a'
      WHEN _utf8mb3'a' THEN 'A'
    END AS x2;

  SELECT
    CASE _utf8mb3'a'
      WHEN _latin1'a' THEN _utf8mb3'A'
    END AS x3;

  SELECT
    CASE s1
      WHEN _latin1'a' THEN _latin1'b'
      ELSE _latin1'c'
    END AS x4
  FROM t1;
DROP TABLE t1;
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);

CREATE PROCEDURE p1() 
BEGIN 
  DECLARE foo, cnt INT UNSIGNED DEFAULT 1;
  SET foo = (SELECT MIN(c1) FROM t1 LIMIT cnt);

CREATE PROCEDURE p2()
BEGIN

DECLARE iLimit INT;
  SELECT c1 FROM t1
  LIMIT iLimit;

SET iLimit=1;

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP TABLE t1;

CREATE PROCEDURE p1(x INT UNSIGNED)
BEGIN
  SELECT c1, t2.c2, count(c3)
  FROM
    (
    SELECT 3 as c2 FROM dual WHERE x = 1
    UNION
    SELECT 2       FROM dual WHERE x = 1 OR x = 2
    ) AS t1,
    (
    SELECT '2012-03-01 01:00:00' AS c1, 3 as c2, 1 as c3 FROM dual
    UNION
    SELECT '2012-03-01 02:00:00',       3,       2       FROM dual
    UNION
    SELECT '2012-03-01 01:00:00',       2,       1       FROM dual
    ) AS t2
  WHERE t2.c2 = t1.c2
  GROUP BY c1 , c2
  ORDER BY c1 , c2
  ;

DROP PROCEDURE p1;
DROP FUNCTION IF EXISTS f1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RETURN f1();
    BEGIN
     DECLARE CONTINUE HANDLER FOR SQLEXCEPTION RETURN f1();
     RETURN f1();
    END;
END $ 
delimiter ;

-- This used to cause an assertion.
SELECT f1();

DROP FUNCTION f1;

CREATE TABLE t1 (a INT) ENGINE=myisam;
INSERT INTO t1 VALUES (1);
CREATE VIEW v1 AS SELECT a FROM t1;

CREATE PROCEDURE p1()
SELECT 1 FROM v1 JOIN t1 ON v1.a
WHERE (SELECT 1 FROM t1 WHERE v1.a)
;
DROP PROCEDURE p1;

-- Make sure we keep track of where-to-restore an item:
prepare s from 'select 1 from `v1` join `t1` on `v1`.`a`
where (select 1 from `t1` where `v1`.`a`)';
create view v2 as select 0 as a from t1;

DROP TABLE t1;
DROP VIEW v1,v2;
DROP PROCEDURE IF EXISTS p1;

CREATE PROCEDURE p1()
BEGIN
  DECLARE row_count INT DEFAULT 1;
  SELECT row_count;
  SELECT row_count();
    SET row_count = row_count - 1;
  END WHILE ROW_COUNT;
  SELECT ROW_COUNT;

DROP PROCEDURE p1;
DROP FUNCTION if exists f1;
CREATE FUNCTION f1 (p_value INT) RETURNS INT DETERMINISTIC RETURN x;
SELECT f1(1);
DROP FUNCTION f1;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;

CREATE FUNCTION f1() RETURNS VARCHAR(1)
BEGIN RETURN 'X';

CREATE FUNCTION f2() RETURNS CHAR(1)
BEGIN RETURN 'X';

CREATE FUNCTION f3() RETURNS VARCHAR(1)
BEGIN RETURN NULL;

CREATE FUNCTION f4() RETURNS CHAR(1)
BEGIN RETURN NULL;

SELECT f1() IS NULL;
SELECT f2() IS NULL;
SELECT f3() IS NULL;
SELECT f4() IS NULL;

DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP FUNCTION f4;

CREATE TABLE t1(a INT);
CREATE PROCEDURE p(p INT)
  SET p = DEFAULT|

--error ER_PARSE_ERROR
CREATE PROCEDURE p()
BEGIN
  DECLARE v INT;
  SET v = DEFAULT;
CREATE PROCEDURE p()
BEGIN
  DECLARE v INT DEFAULT 1;
  SET v = DEFAULT;
CREATE PROCEDURE p()
BEGIN
  DECLARE v INT DEFAULT (SELECT * FROM t1);
  SET v = DEFAULT;
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
BEGIN
  SET NEW.a = DEFAULT;

CREATE PROCEDURE p1()
  SET @@default_storage_engine = DEFAULT;

SET @default_storage_engine_saved = @@default_storage_engine;

SELECT @@default_storage_engine;
SET @@default_storage_engine = InnoDB;
SELECT @@default_storage_engine;

SELECT @@default_storage_engine;

SET @@default_storage_engine = @default_storage_engine_saved;

DROP PROCEDURE p1;

DROP TABLE t1;
SET @org_mode= @@sql_mode;
SET sql_mode= 'STRICT_TRANS_TABLES';

CREATE TABLE t1(a INT) ENGINE= InnoDB;
INSERT INTO t1 VALUES (123456);

CREATE PROCEDURE p1() 
BEGIN
 DECLARE `v` TINYINT;
END $ 

DELIMITER ;
SET sql_mode= @org_mode;
DROP PROCEDURE p1;
DROP TABLE t1;
SET sql_mode = 'only_full_group_by';
CREATE TABLE t1 ( a INT, b INT );
CREATE TABLE t2 ( a INT );

CREATE PROCEDURE p1 ()
BEGIN
  DECLARE output INT;
  SET output = ( SELECT b FROM t1 LEFT JOIN t2 USING ( a ) GROUP BY t1.a );
END $$

DELIMITER ;

DROP PROCEDURE p1;

-- Same, as prepared statement
--error ER_WRONG_FIELD_WITH_GROUP
PREPARE s FROM
 'SET @x = ( SELECT b FROM t1 LEFT JOIN t2 USING ( a ) GROUP BY t1.a )';

DROP TABLE t1, t2;
SET sql_mode = DEFAULT;
CREATE TABLE t1 ( a INT );

SET @v = 1;

DROP TABLE t1, t2;

CREATE DATABASE db1;
CREATE FUNCTION f1() RETURNS INT RETURN 1;
CREATE FUNCTION db1.f2() RETURNS INT RETURN test.f1();
CREATE USER myuser@'localhost';
SELECT f2();
SELECT f2();
DROP DATABASE db1;
DROP USER myuser@localhost;
DROP FUNCTION f1;

CREATE FUNCTION f1(a INT) RETURNS INT return 1;
CREATE PROCEDURE p1(IN a INT, INOUT b INT, OUT c INT) select 1;
SELECT * FROM mysql.proc;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'p1';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
ALTER FUNCTION f1 READS SQL DATA;

-- Cleanup
DROP FUNCTION f1;
DROP PROCEDURE p1;
CREATE USER user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;
CREATE DEFINER=user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char PROCEDURE test.proc_test() SELECT CURRENT_USER();
CREATE DEFINER=user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char FUNCTION test.f_test() RETURNS INT RETURN 1;
DROP PROCEDURE test.proc_test;
DROP FUNCTION test.f_test;

DROP USER user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;

-- Disable concurrent inserts to avoid test failures
set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_warnings
drop table if exists t1,t3;


--
-- Bug#4902 Stored procedure with SHOW WARNINGS leads to packet error
--
-- Added tests for show grants command
--disable_warnings
drop procedure if exists bug4902|
--enable_warnings
create procedure bug4902()
begin
  show grants for 'root'@'localhost';

drop procedure bug4902|

-- We need separate SP for SHOW PROCESSLIST  since we want use replace_column
--disable_warnings
drop procedure if exists bug4902_2|
--enable_warnings
create procedure bug4902_2()
begin
  show processlist;
drop procedure bug4902_2|

--
-- Bug#6807 Stored procedure crash if CREATE PROCEDURE ... KILL QUERY
--
--disable_warnings
drop procedure if exists bug6807|
--enable_warnings
create procedure bug6807()
begin
  declare id int;

  set id = connection_id();
  select 'Not reached';

drop procedure bug6807|


--
-- Bug#10100 function (and stored procedure?) recursivity problem
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION'|
--disable_warnings
drop function if exists bug10100f|
drop procedure if exists bug10100p|
drop procedure if exists bug10100t|
drop procedure if exists bug10100pt|
drop procedure if exists bug10100pv|
drop procedure if exists bug10100pd|
drop procedure if exists bug10100pc|
--enable_warnings
-- routines with simple recursion
create function bug10100f(prm int) returns int
begin
  if prm > 1 then
    return prm * bug10100f(prm - 1);
  end if;
create procedure bug10100p(prm int, inout res int)
begin
  set res = res * prm;
  if prm > 1 then
    call bug10100p(prm - 1, res);
  end if;
create procedure bug10100t(prm int)
begin
  declare res int;
  set res = 1;
  select res;

-- a procedure which use tables and recursion
create table t3 (a int)|
insert into t3 values (0)|
create view v1 as select a from t3;
create procedure bug10100pt(level int, lim int)
begin
  if level < lim then
    update t3 set a=level;
    FLUSH TABLES;
    call bug10100pt(level+1, lim);
    select * from t3;
  end if;
create procedure bug10100pv(level int, lim int)
begin
  if level < lim then
    update v1 set a=level;
    FLUSH TABLES;
    call bug10100pv(level+1, lim);
    select * from v1;
  end if;
create procedure bug10100pd(level int, lim int)
begin
  if level < lim then
    select level;
    prepare stmt1 from "update t3 set a=a+2";
    execute stmt1;
    FLUSH TABLES;
    execute stmt1;
    FLUSH TABLES;
    execute stmt1;
    FLUSH TABLES;
    deallocate prepare stmt1;
    execute stmt2;
    select * from t3;
    call bug10100pd(level+1, lim);
    execute stmt2;
  end if;
create procedure bug10100pc(level int, lim int)
begin
  declare lv int;
  if level < lim then
    select level;
    fetch c into lv;
    select lv;
    update t3 set a=level+lv;
    FLUSH TABLES;
    call bug10100pc(level+1, lim);
    select * from t3;
  end if;

-- end of the stack checking
set @@max_sp_recursion_depth=255|
set @var=1|
-- disable log because error about stack overrun contains numbers which
-- depend on a system
-- disable_result_log
-- error ER_STACK_OVERRUN_NEED_MORE
call bug10100p(255, @var)|
-- error ER_STACK_OVERRUN_NEED_MORE
call bug10100pt(1,255)|
-- error ER_STACK_OVERRUN_NEED_MORE
call bug10100pv(1,255)|
-- error ER_STACK_OVERRUN_NEED_MORE
call bug10100pd(1,255)|
-- error ER_STACK_OVERRUN_NEED_MORE
call bug10100pc(1,255)|
-- enable_result_log
set @@max_sp_recursion_depth=0|

deallocate prepare stmt2|

drop function bug10100f|
drop procedure bug10100p|
drop procedure bug10100t|
drop procedure bug10100pt|
drop procedure bug10100pv|
drop procedure bug10100pd|
drop procedure bug10100pc|
drop view v1|
drop table t3|

delimiter ;
SET sql_mode = default;


--
-- Bug#15298 SHOW GRANTS FOR CURRENT_USER: Incorrect output in DEFINER context
--
--disable_warnings
drop procedure if exists bug15298_1;
drop procedure if exists bug15298_2;
create user 'mysqltest_1'@'localhost';
create procedure 15298_1 () sql security definer show grants for current_user;
create procedure 15298_2 () sql security definer show grants;
drop user mysqltest_1@localhost;
drop procedure 15298_1;
drop procedure 15298_2;

--
-- Bug#29936 Stored Procedure DML ignores low_priority_updates setting
--

--disable_warnings
drop table if exists t1;
drop procedure if exists p1;

-- MyISAM acquires table level lock. The locking functionality is
-- different in InnoDB. Hence it is a Myisam specific testcase

create table t1 (value varchar(15)) engine=Myisam;
create procedure p1() update t1 set value='updated' where value='old';

-- load the procedure into sp cache and execute once
call p1();

insert into t1 (value) values ("old");
select get_lock('b26162',120);

-- we must wait till this select opens and locks the tables
connection rl_wait;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
  info = "select 'rl_acquirer', value from t1 where get_lock('b26162',120)";
set session low_priority_updates=on;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
  info = "update t1 set value='updated' where value='old'";
select 'rl_contender', value from t1;
select release_lock('b26162');
drop procedure p1;
drop table t1;
set session low_priority_updates=default;

--
-- Bug#44798 MySQL engine crashes when creating stored procedures with execute_priv=N
--
INSERT INTO mysql.user (Host, User, Select_priv, Insert_priv, Update_priv,
Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv,
Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv,
Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv,
Create_view_priv, Show_view_priv, Create_routine_priv, Alter_routine_priv,
Create_user_priv, ssl_type, ssl_cipher, x509_issuer, x509_subject, max_questions,
max_updates, max_connections, max_user_connections)
VALUES('%', 'mysqltest_1', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 'N', 'N',
'N', 'N', 'N', 'Y', 'Y', 'N', 'N', 'Y', 'Y', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y', 'N', '',
'', '', '', '0', '0', '0', '0');
CREATE PROCEDURE p1(i INT) BEGIN END;
DROP PROCEDURE p1;

DELETE FROM mysql.user WHERE User='mysqltest_1';
SELECT GET_LOCK('Bug44521', 0);
CREATE PROCEDURE p()
BEGIN
  SELECT 1;
  SELECT GET_LOCK('Bug44521', 100);
  SELECT 2;
let $wait_condition=
  SELECT count(*) = 1 FROM information_schema.processlist
  WHERE state = "User lock" AND info = "SELECT GET_LOCK('Bug44521', 100)";
let $conid =
  `SELECT id FROM information_schema.processlist
   WHERE state = "User lock" AND info = "SELECT GET_LOCK('Bug44521', 100)"`;
SELECT RELEASE_LOCK('Bug44521');
let $wait_condition=
  SELECT count(*) = 0 FROM information_schema.processlist
  WHERE id = $conid;
DROP PROCEDURE p;

--
-- Bug#47736 killing a select from a view when the view is processing a function, asserts
--
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1);
CREATE FUNCTION f1 (inp TEXT) RETURNS INT NO SQL RETURN GET_LOCK('Bug47736', 200);
CREATE VIEW v1 AS SELECT f1('a') FROM t1;

SELECT GET_LOCK('Bug47736', 0);
let $wait_condition=
  SELECT count(*) = 1 FROM information_schema.processlist
  WHERE state = "User lock" AND info = "SELECT * FROM v1";
DROP VIEW v1;
DROP TABLE t1;
DROP FUNCTION f1;
DROP DATABASE IF EXISTS `my.db`;

create database `my.db`;
use `my.db`;

CREATE FUNCTION f1(a int) RETURNS INT RETURN a;
USE `my.db`;
SELECT f1(1);
SELECT `my.db`.f1(2);
DROP DATABASE `my.db`;
USE test;
SET @@SQL_MODE = '';

CREATE EVENT teste_bug11763507 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO SELECT 1 $

DELIMITER ;

DROP EVENT teste_bug11763507;

CREATE TABLE t1 (a INT, b INT);
CREATE TABLE t2 (a INT, b INT);
CREATE TABLE t3 (a INT);

INSERT INTO t1 VALUES (1, 2);

-- Make Sure Event scheduler is ON (by default)
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';

SELECT GET_LOCK('e1_lock', 60);

CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND STARTS NOW() DO
BEGIN
  DECLARE EXIT HANDLER FOR 1136 BEGIN
    INSERT INTO t3 VALUES (1);

  SELECT GET_LOCK('e1_lock', 60);
  SELECT RELEASE_LOCK('e1_lock');

  INSERT INTO t2 SELECT * FROM t1;

SELECT RELEASE_LOCK('e1_lock');

let $wait_condition = SELECT COUNT(*) >= 3 FROM t2;

SELECT GET_LOCK('e1_lock', 60);

ALTER TABLE t1 ADD COLUMN (c INT);

SELECT RELEASE_LOCK('e1_lock');
let $wait_condition = SELECT COUNT(*) > 0 FROM t3;

DROP EVENT e1;
DROP TABLE t1, t2, t3;


--
-- Restore global concurrent_insert value. Keep in the end of the test file.
--

set @@global.concurrent_insert= @old_concurrent_insert;

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc


--echo --
--echo -- WL#2284: Increase the length of a user name
--echo --

CREATE DATABASE test1;
CREATE TABLE test1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);

CREATE USER user_name_len_16@localhost;
CREATE USER user_name_len_22_01234@localhost;
CREATE USER user_name_len_32_012345678901234@localhost;
SELECT * FROM test1.t1;
SELECT * FROM test1.t1;
SELECT * FROM test1.t1;

CREATE DEFINER=user_name_len_22_01234@localhost PROCEDURE test1.p1_len22()
  SELECT * FROM test1.t1;
CREATE DEFINER=user_name_len_33_0123456789012345@localhost PROCEDURE test1.p1_len33()
  SELECT * FROM test1.t1;

CREATE DEFINER = user_name_len_32_012345678901234@localhost FUNCTION test1.f1_len32() RETURNS INT
 RETURN (SELECT COUNT(*) FROM test1.t1);
SELECT test1.f1_len32();
DROP PROCEDURE test1.p1_len22;
SELECT * FROM test1.t1;

CREATE DEFINER=user_name_len_22_01234@localhost PROCEDURE test1.p1_len22()
SQL SECURITY INVOKER
  SELECT * FROM test1.t1;
CREATE DEFINER=user_name_len_33_0123456789012345@localhost FUNCTION test1.f1_len33() RETURNS INT
  RETURN (SELECT COUNT(*) FROM test1.t1);

-- Cleanup
disconnect con_user_16;

DROP DATABASE test1;

DROP USER user_name_len_16@localhost;
DROP USER user_name_len_22_01234@localhost;
DROP USER user_name_len_32_012345678901234@localhost;

CREATE TABLE t1(y INT);
INSERT INTO t1 VALUES (5),(7),(9),(11),(15);
CREATE PROCEDURE `v1`(_limit_val BIGINT, _offset_val BIGINT)
BEGIN
CREATE TEMPORARY TABLE n1 AS (SELECT * FROM t1 LIMIT _limit_val OFFSET _offset_val);
SELECT * FROM n1;
END $$
DELIMITER ;
DROP PROCEDURE v1;
DROP TABLE t1;

CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 10);

CREATE TABLE t2(c INTEGER, d INTEGER);
INSERT INTO t2 VALUES(2, 20);
CREATE PROCEDURE cursor_over_union(OUT sum_a INTEGER, OUT sum_b INTEGER)
BEGIN
  DECLARE a INTEGER;
      SELECT t1.a, t1.b FROM t1
      UNION DISTINCT
      SELECT t2.c, t2.d FROM t2;
      SELECT t1.a, t1.b FROM t1
      UNION ALL
      SELECT t2.c, t2.d FROM t2;

  SET sum_a = 0;
  SET sum_b = 0;
    FETCH c1 INTO a, b;
    if NOT done THEN
       SET sum_a = sum_a + a;
       SET sum_b = sum_b + b;
    END IF;

  SET done = 0;
    FETCH c2 INTO a, b;
    if NOT done THEN
       SET sum_a = sum_a + a;
       SET sum_b = sum_b + b;
    END IF;

end //

DELIMITER ;

SET @sa = 0;
SET @sb = 0;
SELECT @sa, @sb;
DROP PROCEDURE cursor_over_union;
DROP TABLE t1, t2;

CREATE TABLE t1( f1 INT NOT NULL PRIMARY KEY, f2 INT);
INSERT INTO t1 VALUES (1, 1);

CREATE FUNCTION ReturnFalse() RETURNS BOOL
    DETERMINISTIC
BEGIN
DECLARE result BOOL;
    SET result = FALSE;
    RETURN result;

SELECT IF (COUNT(*) > 0, 'affected', 'not affected') FROM t1
  WHERE f1 = 1 AND f2 AND ReturnFalse();

DROP FUNCTION ReturnFalse;
DROP TABLE t1;

CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(0), (1), (2);
INSERT INTO t2 VALUES(1, 10), (2, 20), (2, 21);
CREATE PROCEDURE pc(val INTEGER)
BEGIN
  DECLARE finished, col_a, col_b INTEGER DEFAULT 0;
      SELECT a, (SELECT b FROM t2 WHERE t1.a=t2.a) FROM t1 WHERE a = val;
  SET finished = 0;
    FETCH c INTO col_a, col_b;
    IF finished = 1 THEN
      LEAVE loop1;
    END IF;
  END LOOP loop1;
END //
CREATE PROCEDURE pc_with_flush()
BEGIN
  DECLARE finished, col_a, col_b INTEGER DEFAULT 0;
      SELECT a, (SELECT b FROM t2 WHERE t1.a=t2.a) FROM t1 WHERE a = val;
  SET finished = 0;
    FETCH c INTO col_a, col_b;
    IF finished = 1 THEN
      LEAVE loop1;
    END IF;
  END LOOP loop1;
  SET finished = 0;
  SET val = 1;
    FETCH c INTO col_a, col_b;
    IF finished = 1 THEN
      LEAVE loop2;
    END IF;
  END LOOP loop2;
  SET val = 2;
  SET finished = 0;
    FETCH c INTO col_a, col_b;
    IF finished = 1 THEN
      LEAVE loop3;
    END IF;
  END LOOP loop3;
END //
DELIMITER ;
DROP PROCEDURE pc;
DROP PROCEDURE pc_with_flush;
DROP TABLE t1, t2;

CREATE TABLE foo (
  id INTEGER NOT NULL AUTO_INCREMENT,
  fld INTEGER NOT NULL,
  PRIMARY KEY(id),
  UNIQUE KEY fld(fld)
);
CREATE PROCEDURE test() BEGIN
 SET @exist := (SELECT COUNT(*) FROM information_schema.statistics
                WHERE table_name = 'foo' and
                      table_schema = database() and
                      index_name = 'fld');
 SELECT @exist;
DROP PROCEDURE test;
DROP TABLE foo;
CREATE FUNCTION f1 (i INTEGER) RETURNS INTEGER
BEGIN
  IF i = 0 THEN
   RETURN 0;
  END IF;
END //
CREATE FUNCTION f2 () RETURNS INTEGER
 RETURN f1(0) //
DELIMITER ;
SELECT f2();
SELECT f1(1);
DROP FUNCTION f1;
DROP FUNCTION f2;
CREATE PROCEDURE p1()
BEGIN
  DROP TEMPORARY TABLE IF EXISTS tmp;
  CREATE TEMPORARY TABLE tmp(name VARCHAR(64), value VARCHAR(64));

  IF EXISTS(SELECT 1
            FROM tmp d
                 LEFT JOIN information_schema.columns c
                 ON c.table_schema = 'test' AND
                    upper(c.column_name) = upper(d.name)
            WHERE c.table_schema IS NULL
           )
  THEN
    SELECT 'then';
    SELECT 'else';
  END IF;
              FROM tmp d
                   LEFT JOIN information_schema.columns c
                   ON c.table_schema = 'test' AND
                      upper(c.column_name) = upper(d.name)
              WHERE c.table_schema IS NULL
             )
  WHEN TRUE THEN SELECT 'true';
  END CASE;
              FROM tmp d
                   LEFT JOIN information_schema.columns c
                   ON c.table_schema = 'test' AND
                      upper(c.column_name) = upper(d.name)
              WHERE c.table_schema IS NULL
             )
  THEN SELECT 'true';
  END CASE;
               FROM tmp d
                    LEFT JOIN information_schema.columns c
                    ON c.table_schema = 'test' AND
                       upper(c.column_name) = upper(d.name)
               WHERE c.table_schema IS NULL
              )
  DO
    SELECT 'while';
  END WHILE;
    SELECT 'repeat';
        EXISTS(SELECT 1
               FROM tmp d
                    LEFT JOIN information_schema.columns c
                    ON c.table_schema = 'test' AND
                       upper(c.column_name) = upper(d.name)
               WHERE c.table_schema IS NULL
              )
  END REPEAT;
  DROP TEMPORARY TABLE tmp;

DROP PROCEDURE p1;
