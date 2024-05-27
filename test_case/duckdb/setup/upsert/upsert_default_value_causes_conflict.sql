pragma enable_verification;
create or replace table tbl (
	a integer primary key default 5,
	b integer
);
insert into tbl(b) VALUES (10);
insert into tbl(b) VALUES (10) ON CONFLICT (a) DO NOTHING;
insert into tbl(b) VALUES (10) ON CONFLICT (a) DO UPDATE SET b = excluded.b * 2;