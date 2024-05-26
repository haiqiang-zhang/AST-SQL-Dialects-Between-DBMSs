select * from data_02572 order by key;
insert into data_02572 settings materialized_views_ignore_errors=1 values (2);
select * from data_02572 order by key;
system flush logs;
select * from data_02572 order by key;
create table receiver_02572 as data_02572;
select * from data_02572 order by key;
select * from receiver_02572 order by key;
