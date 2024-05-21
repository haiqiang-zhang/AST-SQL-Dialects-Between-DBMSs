drop table if exists nums_in_mem;
drop table if exists nums_in_mem_dist;
create table nums_in_mem(v UInt64) engine=Memory;
insert into nums_in_mem select * from system.numbers limit 1000000;
set prefer_localhost_replica = 0;
set max_rows_to_read = 100;
drop table nums_in_mem;
