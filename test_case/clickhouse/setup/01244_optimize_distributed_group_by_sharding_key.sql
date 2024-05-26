set optimize_distributed_group_by_sharding_key=1;
set max_bytes_before_external_group_by = 0;
drop table if exists dist_01247;
drop table if exists data_01247;
create table data_01247 as system.numbers engine=Memory();
insert into data_01247 select * from system.numbers limit 2;
set max_distributed_connections=1;
set prefer_localhost_replica=0;
set enable_positional_arguments=0;
