set distributed_foreground_insert=1;
set prefer_localhost_replica=0;
drop table if exists dist_01850;
drop table shard_0.data_01850;
drop database shard_0;
drop database shard_1;
