set send_logs_level = 'fatal';
drop table if exists ttl;
create table ttl (d Date, a Int) engine = MergeTree order by a partition by toDayOfMonth(d) settings remove_empty_parts = 0;
alter table ttl modify ttl d + interval 1 day;
