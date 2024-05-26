set mutations_sync = 2;
set session_timezone = '';
SET allow_suspicious_ttl_expressions = 1;
drop table if exists ttl;
create table ttl (d Date, a Int) engine = MergeTree order by a partition by toDayOfMonth(d)
SETTINGS max_number_of_merges_with_ttl_in_pool=0,materialize_ttl_recalculate_only=true;
insert into ttl values (toDateTime('2000-10-10 00:00:00'), 1);
insert into ttl values (toDateTime('2000-10-10 00:00:00'), 2);
insert into ttl values (toDateTime('2100-10-10 00:00:00'), 3);
insert into ttl values (toDateTime('2100-10-10 00:00:00'), 4);
alter table ttl modify ttl d + interval 1 day;
