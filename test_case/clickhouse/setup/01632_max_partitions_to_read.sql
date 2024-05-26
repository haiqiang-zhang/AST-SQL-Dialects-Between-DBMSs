drop table if exists p;
create table p(d Date, i int, j int) engine MergeTree partition by d order by i settings max_partitions_to_read = 1;
insert into p values ('2021-01-01', 1, 2), ('2021-01-02', 4, 5);
