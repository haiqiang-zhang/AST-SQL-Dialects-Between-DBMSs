pragma enable_verification;
create or replace table tbl (
	a integer,
	b integer,
	c integer,
	primary key (a, b)
);
insert into tbl VALUES (1,2,3), (1,4,5);
insert into tbl VALUES (1,4,7), (1,8,4) ON CONFLICT (a,b) DO UPDATE set c = 5;
select * from tbl;