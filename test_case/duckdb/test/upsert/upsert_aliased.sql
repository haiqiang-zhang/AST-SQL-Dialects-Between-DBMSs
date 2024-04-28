pragma enable_verification;;
create table tbl (
	i integer,
	j integer unique
);;
insert into tbl values (5,3), (6,7);;
insert into tbl AS test values (3,5), (8,3), (2,6) on conflict (j) where i <= excluded.i do update set i = excluded.i * 2;;
insert into tbl AS test values (2,3) on conflict do update set i = test.i;;
insert into tbl as test values (2,3) on conflict (j) where test.i < 5 do update set i = excluded.j;;
insert into tbl as test values (2,3) on conflict (j) where test.i >= 5 do update set i = excluded.j;;
insert into tbl as test (j, i) values (5,3) on conflict (j) do update set i = 10 where test.j <= 3;;
insert into tbl as test (j, i) values (5,3) on conflict (j) do update set i = 10 where test.j > 3;;
insert into tbl as excluded values (8,3) on conflict (j) do update set i = 5;;
select * from tbl;;
select * from tbl;;
select * from tbl;;
select * from tbl;;
select * from tbl;;
