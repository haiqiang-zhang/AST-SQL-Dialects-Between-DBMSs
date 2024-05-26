SET allow_experimental_parallel_reading_from_replicas = 0;
SET prefer_localhost_replica = 1;
DROP TABLE IF EXISTS local_01099_a;
DROP TABLE IF EXISTS local_01099_b;
DROP TABLE IF EXISTS distributed_01099_a;
DROP TABLE IF EXISTS distributed_01099_b;
SET parallel_distributed_insert_select=1;
