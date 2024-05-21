SET max_memory_usage = 300000000;
SET max_bytes_before_external_sort = 20000000;
DROP TABLE IF EXISTS numbers10m;
CREATE VIEW numbers10m AS SELECT number FROM system.numbers LIMIT 10000000;
DROP TABLE numbers10m;
