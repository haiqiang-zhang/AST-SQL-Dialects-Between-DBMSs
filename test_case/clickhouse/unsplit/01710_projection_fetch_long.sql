drop table if exists tp_1;
drop table if exists tp_2;
select count() from system.projection_parts where database = currentDatabase() and table = 'tp_2' and name = 'pp' and active;
set mutations_sync = 2;
select count() from system.projection_parts where database = currentDatabase() and table = 'tp_2' and name = 'pp' and active;
select * from system.projection_parts where database = currentDatabase() and table = 'tp_2' and name = 'pp' and active;
select * from system.projection_parts where database = currentDatabase() and table = 'tp_2' and name = 'pp' and active;
drop table if exists tp_1;
drop table if exists tp_2;
