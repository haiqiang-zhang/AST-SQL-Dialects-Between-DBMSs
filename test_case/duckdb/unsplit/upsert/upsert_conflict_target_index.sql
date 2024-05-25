pragma enable_verification;;
create or replace table index_tbl (
	i integer,
	j integer
);;
insert into index_tbl values (5, 3);;
create unique index other_index on index_tbl(i);;
insert into index_tbl values (5, 5);;
insert into index_tbl values (5, 10) on conflict on constraint other_index do update set j = excluded.j;;
select * from index_tbl;;
