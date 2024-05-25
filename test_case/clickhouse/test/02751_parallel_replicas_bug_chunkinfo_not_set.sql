SET max_parallel_replicas = 3,  prefer_localhost_replica = 1, cluster_for_parallel_replicas = 'test_cluster_one_shard_three_replicas_localhost', allow_experimental_parallel_reading_from_replicas = 1;
SET send_logs_level='error';
