pragma enable_verification;
create or replace table index_tbl (
	i integer,
	j integer
);
insert into index_tbl values (5, 3);
create unique index other_index on index_tbl(i);
select * from index_tbl;
