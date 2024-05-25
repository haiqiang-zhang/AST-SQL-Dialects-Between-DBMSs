DROP TABLE IF EXISTS i20203_1 SYNC;
DROP TABLE IF EXISTS i20203_2 SYNC;
SET function_sleep_max_microseconds_per_block = 10000000;
SELECT num_tries < 50
FROM system.replication_queue
WHERE table = 'i20203_2' AND database = currentDatabase();
