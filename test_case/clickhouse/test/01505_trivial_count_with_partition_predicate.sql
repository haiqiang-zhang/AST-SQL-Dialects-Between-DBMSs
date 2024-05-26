select count() from test1 settings max_parallel_replicas = 3;
create table test_tuple(p DateTime, i int, j int) engine MergeTree partition by (toDate(p), i) order by j settings index_granularity = 1;
insert into test_tuple values ('2020-09-01 00:01:02', 1, 2), ('2020-09-01 00:01:03', 2, 3), ('2020-09-02 00:01:03', 3, 4);
create table test_two_args(i int, j int, k int) engine MergeTree partition by i + j order by k settings index_granularity = 1;
insert into test_two_args values (1, 2, 3), (2, 1, 3), (0, 3, 4);
drop table test1;
drop table test_tuple;
drop table test_two_args;
