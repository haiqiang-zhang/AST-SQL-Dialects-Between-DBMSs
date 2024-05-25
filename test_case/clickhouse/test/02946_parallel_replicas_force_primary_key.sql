DROP TABLE IF EXISTS t1 SYNC;
DROP TABLE IF EXISTS t2 SYNC;
DROP TABLE IF EXISTS t3 SYNC;
SET allow_experimental_parallel_reading_from_replicas=1, max_parallel_replicas=3, cluster_for_parallel_replicas='test_cluster_one_shard_three_replicas_localhost';
