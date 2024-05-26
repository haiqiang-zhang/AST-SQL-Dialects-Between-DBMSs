drop tables if exists t1, t2;
drop view if exists v1;
create table t1 (a int, b datetime);
create table t2 (c int, d datetime);
select convert_tz('2004-10-21 19:00:00', 'Europe/Moscow', 'UTC');
update t1, t2 set t1.b = convert_tz('2004-10-21 19:00:00', 'Europe/Moscow', 'UTC')
              where t1.a = t2.c and t2.d = (select max(d) from t2);
update t1, t2 set t1.b = convert_tz('2004-11-30 12:00:00', 'Europe/Moscow', 'UTC')
              where t1.a = t2.c and t2.d = (select max(d) from t2);
drop table t1, t2;
create table t1 (a int, b datetime);
create table t2 (a int, b varchar(40));
update t1 set b = '2005-01-01 10:00';
update t1 set b = convert_tz(b, 'UTC', 'UTC');
update t1 join t2 on (t1.a = t2.a) set t1.b = '2005-01-01 10:00' where t2.b = 'foo';
update t1 join t2 on (t1.a = t2.a) set t1.b = convert_tz('2005-01-01 10:00','UTC','UTC') where t2.b = 'foo';
drop table t1, t2;
create table t1 (a int, b datetime);
insert into t1 values (1, 20010101000000), (2, 20020101000000);
create view v1 as select a, convert_tz(b, 'UTC', 'Europe/Moscow') as lb from t1;
select * from v1;
drop view v1;
drop table t1;
