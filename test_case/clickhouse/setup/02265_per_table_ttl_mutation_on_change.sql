drop table if exists per_table_ttl_02265;
create table per_table_ttl_02265 (key Int, date Date, value String) engine=MergeTree() order by key;
insert into per_table_ttl_02265 values (1, today(), '1');
alter table per_table_ttl_02265 modify TTL date + interval 1 month;