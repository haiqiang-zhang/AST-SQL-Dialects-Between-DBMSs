pragma enable_verification;
create or replace table tbl (
	a integer primary key DEFAULT 5,
	b integer
);
insert into tbl DEFAULT VALUES;
