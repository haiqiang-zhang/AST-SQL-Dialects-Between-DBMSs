drop table if exists test_01081;
create table test_01081 (key Int) engine=MergeTree() order by key;
insert into test_01081 select * from system.numbers limit 10;
drop table if exists test_01081;
