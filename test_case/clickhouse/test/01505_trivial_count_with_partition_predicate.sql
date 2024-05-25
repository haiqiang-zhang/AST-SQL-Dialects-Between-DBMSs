set max_rows_to_read = 1;
set optimize_use_implicit_projections = 1;
select count() from test1 settings max_parallel_replicas = 3;
select count() from test1 where toYear(toDate(p)) = 1999;
-- optimized (partition expr wrapped with non-monotonic functions)
select count() FROM test1 where toDate(p) = '2020-09-01' and sipHash64(toString(toDate(p))) % 2 = 1;
select count() FROM test1 where toDate(p) = '2020-09-01' and sipHash64(toString(toDate(p))) % 2 = 0;
-- optimized
select count() from test1 where toDate(p) > '2020-09-01';
select count() from test1 where toDate(p) >= '2020-09-01' and p <= '2020-09-01 00:00:00';
create table test_tuple(p DateTime, i int, j int) engine MergeTree partition by (toDate(p), i) order by j settings index_granularity = 1;
insert into test_tuple values ('2020-09-01 00:01:02', 1, 2), ('2020-09-01 00:01:03', 2, 3), ('2020-09-02 00:01:03', 3, 4);
select count() from test_tuple where toDate(p) > '2020-09-01';
select count() from test_tuple where toDate(p) > '2020-09-01' and i = 1;
select count() from test_tuple where i > 2;
select count() from test_tuple where i < 1;
select count() from test_tuple array join [1,2] as c where toDate(p) = '2020-09-01' settings max_rows_to_read = 4;
select count() from test_tuple array join [1,2,3] as c where toDate(p) = '2020-09-01' settings max_rows_to_read = 6;
create table test_two_args(i int, j int, k int) engine MergeTree partition by i + j order by k settings index_granularity = 1;
insert into test_two_args values (1, 2, 3), (2, 1, 3), (0, 3, 4);
select count() from test_two_args where i + j = 3;
drop table test1;
drop table test_tuple;
drop table test_two_args;
