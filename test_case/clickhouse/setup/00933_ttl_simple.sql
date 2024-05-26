SET allow_suspicious_ttl_expressions = 1;
drop table if exists ttl_00933_1;
create table ttl_00933_1 (d DateTime, a Int ttl d + interval 1 second, b Int ttl d + interval 1 second) engine = MergeTree order by tuple() partition by toMinute(d) settings min_bytes_for_wide_part = 0;
insert into ttl_00933_1 values (now(), 1, 2);
insert into ttl_00933_1 values (now(), 3, 4);
