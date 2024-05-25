-- Different result means Backward Incompatible Change. Old partitions will not be accepted by new server.
select partition_id from system.parts where table = 'tab' and database = currentDatabase();
drop table if exists tab;
