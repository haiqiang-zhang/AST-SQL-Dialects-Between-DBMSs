create materialized view mv_02572 to copy_02572 as select * from data_02572;
insert into buffer_02572 values (1);
select * from data_02572;
select * from copy_02572;
SET function_sleep_max_microseconds_per_block = 6000000;
select * from data_02572;
select * from copy_02572;
system flush logs;
