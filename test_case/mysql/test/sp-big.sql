--

--disable_warnings
drop procedure if exists test.longprocedure;
drop table if exists t1;

create table t1 (a int);
insert into t1 values (1),(2),(3);

let $body=`select repeat('select count(*) into out1 from t1;

-- this is larger than the length above, because it includes the 'begin' and
-- 'end' bits and some whitespace
select length(routine_definition) from information_schema.routines where routine_schema = 'test' and routine_name = 'longprocedure';

drop procedure test.longprocedure;
drop table t1;
create table t1 (f1 char(100) , f2 mediumint , f3 int , f4 real, f5 numeric);
insert into t1 (f1, f2, f3, f4, f5) values
("This is a test case for for Bug--9819", 1, 2, 3.0, 4.598);
create table t2 like t1;
let $1=8;
{
  eval insert into t1 select * from t1;
  dec $1;
select count(*) from t1;
select count(*) from t2;
drop procedure if exists p1;
create procedure p1()
begin
  declare done integer default 0;
    fetch cur1 into vf1, vf2, vf3, vf4, vf5;
    if not done then
      insert into t2 values (vf1, vf2, vf3, vf4, vf5);
    end if;
  end while;
select count(*) from t1;
select count(*) from t2;
select f1 from t1 limit 1;
select f1 from t2 limit 1;
drop procedure p1;
drop table t1, t2;
