drop table if exists test;
create table test (key Int) engine=MergeTree() order by tuple() settings ratio_of_defaults_for_sparse_serialization=0.1;
insert into test select 0 from numbers(10);
