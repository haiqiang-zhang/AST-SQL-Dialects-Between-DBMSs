set optimize_skip_unused_shards=1;
drop table if exists data_01755;
drop table if exists dist_01755;
create table data_01755 (i Int) Engine=Memory;
insert into data_01755 values (1);
drop table if exists data_01755;
drop table if exists dist_01755;
