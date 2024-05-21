drop table if exists data_01320;
drop table if exists dist_01320;
create table data_01320 (key Int) Engine=Null();
set optimize_skip_unused_shards=1;
set force_optimize_skip_unused_shards=1;
select * from dist_01320 where key = 0;
drop table data_01320;
drop table dist_01320;