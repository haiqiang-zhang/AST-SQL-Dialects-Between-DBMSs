pragma enable_verification;
create table tbl (i integer, j integer);
insert into tbl values (5,3), (3,2);
create unique index my_index on tbl(i);
insert into tbl values (5,2) on conflict (i) do update set j = 10;
select * from tbl;