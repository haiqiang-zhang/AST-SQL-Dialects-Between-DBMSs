select partition_id from system.parts where table = 'tab' and database = currentDatabase();
drop table if exists tab;
