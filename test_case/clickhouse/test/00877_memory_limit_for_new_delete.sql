-- Tag no-msan: memory limits don't work correctly under msan because it replaces malloc/free

SET max_memory_usage = 1000000000;
SET max_bytes_before_external_group_by = 0;
