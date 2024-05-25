OPTIMIZE TABLE t_vertical_merge_memory FINAL;
SYSTEM FLUSH LOGS;
DROP TABLE IF EXISTS t_vertical_merge_memory;
