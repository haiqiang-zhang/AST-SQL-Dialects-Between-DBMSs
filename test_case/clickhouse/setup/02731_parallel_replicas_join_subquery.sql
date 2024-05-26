DROP TABLE IF EXISTS join_inner_table SYNC;
SET max_parallel_replicas = 3;
SET prefer_localhost_replica = 1;
SET cluster_for_parallel_replicas = 'test_cluster_one_shard_three_replicas_localhost';
SET joined_subquery_requires_alias = 0;
