set optimize_skip_unused_shards=1;
drop table if exists data_02000;
drop table if exists dist_02000;
create table data_02000 (key Int) Engine=Null();
select * from data_02000 where key = 0xdeadbeafdeadbeaf;
drop table data_02000;
