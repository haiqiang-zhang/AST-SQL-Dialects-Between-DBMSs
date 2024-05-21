SELECT * FROM generateRandom('i Array(Int8)', 1, 1, 1048577) LIMIT 65536 SETTINGS max_memory_usage='1Gi', max_block_size=65505, log_queries=1;
SYSTEM FLUSH LOGS;