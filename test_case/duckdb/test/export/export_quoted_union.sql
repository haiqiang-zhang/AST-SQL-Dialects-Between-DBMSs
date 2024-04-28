BEGIN TRANSACTION;
create table a (
	u UNION(
		"member name 1" VARCHAR,
		"member name 2" BOOL
	)
);;
insert into a values (
	union_value("member name 1" := 'hello')
);;
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_test';
select * from a;
select * from a;
select union_tag(COLUMNS(*)) from a;;
