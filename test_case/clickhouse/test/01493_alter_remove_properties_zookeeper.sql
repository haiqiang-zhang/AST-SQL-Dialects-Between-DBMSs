SET replication_alter_partitions_sync = 2;
SELECT '====== remove column comment ======';
SELECT '====== remove column codec ======';
SELECT '====== remove column default ======';
SELECT '====== remove column TTL ======';
SELECT '====== remove table TTL ======';
DROP TABLE IF EXISTS r_prop_table1;
DROP TABLE IF EXISTS r_prop_table2;
