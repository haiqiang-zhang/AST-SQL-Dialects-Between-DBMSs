system stop merges shard_0.from_1;
system stop merges shard_1.from_1;
drop table if exists shard_0.from_1;
drop table if exists shard_1.from_1;
select name, active from system.parts where database='shard_0' and table='to' and active order by name;
drop table if exists shard_0.to;
drop table if exists shard_1.to;
