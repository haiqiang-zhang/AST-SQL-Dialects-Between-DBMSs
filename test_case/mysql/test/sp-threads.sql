--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (con1root,localhost,root,,);
use test;
drop table if exists t1;
create table t1 (s1 int, s2 int, s3 int);
create procedure bug4934()
begin
   insert into t1 values (1,0,1);
use test;
select * from t1;

drop table t1;
create table t1 (s1 int, s2 int, s3 int);

drop procedure bug4934;
create procedure bug4934()
begin
end//
delimiter ;

select * from t1;
select * from t1;

drop table t1;
drop procedure bug4934;


--
-- Bug#9486 Can't perform multi-update in stored procedure
--
--disable_warnings
drop procedure if exists bug9486;
drop table if exists t1, t2;
create table t1 (id1 int, val int);
create table t2 (id2 int);

create procedure bug9486()
  update t1, t2 set val= 1 where id1=id2;

drop procedure bug9486;
drop table t1, t2;


--
-- Bug#11158 Can't perform multi-delete in stored procedure
--
--disable_warnings
drop procedure if exists bug11158;
create procedure bug11158() delete t1 from t1, t2 where t1.id = t2.id;
create table t1 (id int, j int);
insert into t1 values (1, 1), (2, 2);
create table t2 (id int);
insert into t2 values (1);
select * from t1;
drop procedure bug11158;
drop table t1, t2;


--
-- Bug#11554 Server crashes on statement indirectly using non-cached function
--
--disable_warnings
drop function if exists bug11554;
drop view if exists v1;
create table t1 (i int);
create function bug11554 () returns int return 1;
create view v1 as select bug11554() as f;
insert into t1 (select f from v1);
drop function bug11554;
drop table t1;
drop view v1;


-- Bug#12228 Crash happens during calling specific SP in multithread environment
--disable_warnings
drop procedure if exists p1;
drop procedure if exists p2;
create table t1 (s1 int)|
create procedure p1() select * from t1|
create procedure p2()
begin
  insert into t1 values (1);
  select * from t1;
use test;
use test;
drop procedure p1;
create procedure p1() select * from t1;

drop procedure p1;
drop procedure p2;
drop table t1;


--
-- Bug#NNNN New bug synopsis
--
----disable_warnings
--drop procedure if exists bugNNNN;
