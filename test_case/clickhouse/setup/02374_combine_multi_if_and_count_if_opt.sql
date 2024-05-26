drop table if exists m;
create table m (a int) engine Log;
insert into m values (1);
set optimize_rewrite_sum_if_to_count_if=1;
