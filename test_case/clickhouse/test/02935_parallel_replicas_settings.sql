SET allow_experimental_parallel_reading_from_replicas=2, max_parallel_replicas=3, parallel_replicas_for_non_replicated_merge_tree=1;
SET cluster_for_parallel_replicas='';
SET cluster_for_parallel_replicas='parallel_replicas';
SYSTEM FLUSH LOGS;
SET use_hedged_requests=1;
SYSTEM FLUSH LOGS;
SET allow_experimental_parallel_reading_from_replicas=0;
DROP TABLE test_parallel_replicas_settings;
