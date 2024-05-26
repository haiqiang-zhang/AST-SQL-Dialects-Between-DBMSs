pragma enable_verification;
create or replace table tbl(
	i integer UNIQUE,
	j integer,
	k integer PRIMARY KEY
);
insert into tbl values (3,4,2), (5,3,1);
insert into tbl(k, i) values (2,3), (4,4), (1,8) on conflict (k) do update set j = excluded.j;
