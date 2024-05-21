drop table if exists test;
create table test (a Int8) engine = MergeTree order by tuple();
select * from test;
drop table test;