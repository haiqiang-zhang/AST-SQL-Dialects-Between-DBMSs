pragma enable_verification;
create or replace table tbl (
	a integer primary key default 4,
	b integer DEFAULT 3
);
insert into tbl VALUES (2,3), (4,5);
insert into tbl VALUES (DEFAULT, 6) ON CONFLICT (a) DO UPDATE SET b = DEFAULT;
