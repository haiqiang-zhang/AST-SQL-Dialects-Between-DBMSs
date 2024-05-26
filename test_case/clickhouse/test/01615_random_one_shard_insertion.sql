select count() != 0 from shard_0.tbl;
select count() != 0 from shard_1.tbl;
drop table if exists shard_0.tbl;
drop table if exists shard_1.tbl;
drop database shard_0;
drop database shard_1;
