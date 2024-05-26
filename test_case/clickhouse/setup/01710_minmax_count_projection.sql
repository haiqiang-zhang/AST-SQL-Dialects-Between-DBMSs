drop table if exists d;
create table d (i int, j int) engine MergeTree partition by i % 2 order by tuple() settings index_granularity = 1;
insert into d select number, number from numbers(10000);
set max_rows_to_read = 2, optimize_use_projections = 1, optimize_use_implicit_projections = 1;
