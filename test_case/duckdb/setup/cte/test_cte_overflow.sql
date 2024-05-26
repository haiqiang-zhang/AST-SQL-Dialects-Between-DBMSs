create table a (id integer);
insert into a values (1729);
create view va as (with v as (select * from a) select * from v);
