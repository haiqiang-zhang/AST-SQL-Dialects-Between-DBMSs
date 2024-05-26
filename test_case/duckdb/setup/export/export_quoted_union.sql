BEGIN TRANSACTION;
create table a (
	u UNION(
		"member name 1" VARCHAR,
		"member name 2" BOOL
	)
);
insert into a values (
	union_value("member name 1" := 'hello')
);
