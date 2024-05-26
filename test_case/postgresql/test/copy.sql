select * from copytest except select * from copytest2;
truncate copytest2;
select * from copytest except select * from copytest2;
create temp table copytest3 (
	c1 int,
	"col with , comma" text,
	"col with "" quote"  int);
create temp table copytest4 (
	c1 int,
	"colname with tab: 	" text);
create table parted_copytest (
	a int,
	b int,
	c text
) partition by list (b);
create table parted_copytest_a1 (c text, b int, a int);
create table parted_copytest_a2 (a int, c text, b int);
alter table parted_copytest attach partition parted_copytest_a1 for values in(1);
alter table parted_copytest attach partition parted_copytest_a2 for values in(2);
insert into parted_copytest select x,1,'One' from generate_series(1,1000) x;
insert into parted_copytest select x,2,'Two' from generate_series(1001,1010) x;
insert into parted_copytest select x,1,'One' from generate_series(1011,1020) x;
truncate parted_copytest;
begin;
truncate parted_copytest;
rollback;
select tableoid::regclass,count(*),sum(a) from parted_copytest
group by tableoid order by tableoid::regclass::name;
truncate parted_copytest;
end;
truncate table parted_copytest;
create index on parted_copytest (b);
select * from parted_copytest where b = 2;
drop table parted_copytest;
create table tab_progress_reporting (
	name text,
	age int4,
	location point,
	salary int4,
	manager name
);
drop table tab_progress_reporting;
create table header_copytest (
	a int,
	b int,
	c text
);
alter table header_copytest drop column c;
alter table header_copytest add column c text;
alter table header_copytest drop column b;
drop table header_copytest;
create temp table oversized_column_default (
    col1 varchar(5) DEFAULT 'more than 5 chars',
    col2 varchar(5));
drop table oversized_column_default;
CREATE TABLE parted_si (
  id int not null,
  data text not null,
  rand float8 not null default random()
)
PARTITION BY LIST((id % 2));
CREATE TABLE parted_si_p_even PARTITION OF parted_si FOR VALUES IN (0);
CREATE TABLE parted_si_p_odd PARTITION OF parted_si FOR VALUES IN (1);
SELECT tableoid::regclass, id % 2 = 0 is_even, count(*) from parted_si GROUP BY 1, 2 ORDER BY 1;
DROP TABLE parted_si;
