drop table if exists dist;
create table dist as system.one engine=Distributed('test_shard_localhost', system, one);