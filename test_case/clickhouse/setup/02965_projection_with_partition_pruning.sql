drop table if exists a;
create table a (i int, j int, projection p (select * order by j)) engine MergeTree partition by i order by tuple() settings index_granularity = 1;
insert into a values (1, 2), (0, 5), (3, 4);
