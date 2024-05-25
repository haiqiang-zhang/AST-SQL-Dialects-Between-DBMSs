SET max_block_size=900;
OPTIMIZE TABLE adaptive_table FINAL;
SELECT marks FROM system.parts WHERE table = 'adaptive_table' and database=currentDatabase() and active;
SET enable_filesystem_cache = 0;
SET max_memory_usage='30M';
SET max_threads = 1;
SELECT max(length(value)) FROM adaptive_table;
DROP TABLE IF EXISTS adaptive_table;
