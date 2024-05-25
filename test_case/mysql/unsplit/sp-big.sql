drop table if exists t1;
create table t1 (a int);
insert into t1 values (1),(2),(3);
select length(routine_definition) from information_schema.routines where routine_schema = 'test' and routine_name = 'longprocedure';
drop table t1;
create table t1 (f1 char(100) , f2 mediumint , f3 int , f4 real, f5 numeric);
insert into t1 (f1, f2, f3, f4, f5) values
("This is a test case for for Bug#9819", 1, 2, 3.0, 4.598);
create table t2 like t1;
select count(*) from t1;
select count(*) from t2;
drop procedure if exists p1;
select count(*) from t1;
select count(*) from t2;
select f1 from t1 limit 1;
select f1 from t2 limit 1;
drop table t1, t2;
