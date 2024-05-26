create temp view v1 as
  select 2+2 as f1;
create or replace temp view v1 as
  select 2+2+4 as f1;
create schema s1
  create table abc (f1 int);
create schema s2
  create table abc (f1 int);
insert into s1.abc values(123);
insert into s2.abc values(456);
set search_path = s1;
