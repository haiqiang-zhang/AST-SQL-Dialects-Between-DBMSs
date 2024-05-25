drop table if exists test;
create table test (i int) engine MergeTree order by tuple();
insert into test select arrayJoin(range(10000));
set prefer_localhost_replica = 0;
set prefer_localhost_replica = 1;
drop table if exists test;
