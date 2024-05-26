select * from data_02572;
select * from copy_02572;
SET function_sleep_max_microseconds_per_block = 6000000;
select * from data_02572;
select * from copy_02572;
system flush logs;
