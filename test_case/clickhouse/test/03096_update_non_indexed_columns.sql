select count() from test_03096;
select count() from test_03096 where b = 0;
alter table test_03096 update b = 100 where b = 0 SETTINGS mutations_sync=2;
select latest_fail_reason == '', is_done == 1 from system.mutations where table='test_03096' and database = currentDatabase();
alter table test_03096 update b = 123 where c = 0 SETTINGS mutations_sync=2;
select latest_fail_reason == '', is_done == 1 from system.mutations where table='test_03096' and database = currentDatabase();
DROP TABLE IF EXISTS test_03096;
