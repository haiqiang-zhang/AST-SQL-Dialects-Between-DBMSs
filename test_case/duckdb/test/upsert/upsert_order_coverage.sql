pragma enable_verification;;
create or replace table tbl(
	i integer UNIQUE,
	j integer,
	k integer PRIMARY KEY
);;
insert into tbl values (3,4,2), (5,3,1);;
insert into tbl(k, i) values (2,3), (4,4), (1,8) on conflict (k) do update set j = excluded.j;;
insert into tbl(i,k) values (3,2), (5,5) on conflict (k) do update set j = 10;;
insert into tbl(i,k) values (3,10), (6,2) on conflict(i) do update set j = 10;;
select * from tbl;;
select * from tbl;;
select * from tbl;;
select * from tbl;;
