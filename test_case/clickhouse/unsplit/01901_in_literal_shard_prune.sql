set optimize_skip_unused_shards=1;
set force_optimize_skip_unused_shards=1;
drop table if exists d;
drop table if exists dp;
create table d (i UInt8) Engine=Memory;
insert into d values (1), (2);
drop table if exists d;
drop table if exists dp;
