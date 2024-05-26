SET function_sleep_max_microseconds_per_block = 4000000;
drop table if exists data_01256;
drop table if exists buffer_01256;
create table data_01256 as system.numbers Engine=Memory();
