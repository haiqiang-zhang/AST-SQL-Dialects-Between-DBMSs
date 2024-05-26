ATTACH '__TEST_DIR__/database.db' as persistent;
CREATE OR REPLACE TABLE persistent.T1 (A0 int);
insert into persistent.T1 values (5);
SELECT column_name from pragma_storage_info('persistent.T1');
