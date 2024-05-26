SELECT count() FROM index_memory;
DETACH TABLE index_memory;
SET max_memory_usage = 39000000;
ATTACH TABLE index_memory;
DROP TABLE index_memory;
