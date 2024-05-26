SYSTEM FLUSH LOGS;
SET use_hedged_requests=1;
SYSTEM FLUSH LOGS;
SET allow_experimental_parallel_reading_from_replicas=0;
DROP TABLE test_parallel_replicas_settings;
