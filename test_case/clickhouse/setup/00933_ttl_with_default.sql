drop table if exists ttl_00933_2;
create table ttl_00933_2 (d DateTime, a Int default 111 ttl d + interval 1 DAY) engine = MergeTree order by tuple() partition by toDayOfMonth(d);
insert into ttl_00933_2 values (toDateTime('2000-10-10 00:00:00'), 1);
insert into ttl_00933_2 values (toDateTime('2000-10-10 00:00:00'), 2);
insert into ttl_00933_2 values (toDateTime('2100-10-10 00:00:00'), 3);
insert into ttl_00933_2 values (toDateTime('2100-10-10 00:00:00'), 4);