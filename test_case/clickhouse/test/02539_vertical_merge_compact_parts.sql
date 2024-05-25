OPTIMIZE TABLE t_compact_vertical_merge FINAL;
SYSTEM FLUSH LOGS;
INSERT INTO t_compact_vertical_merge SELECT number, toString(number), range(number % 10) FROM numbers(40);
OPTIMIZE TABLE t_compact_vertical_merge FINAL;
SYSTEM FLUSH LOGS;
DROP TABLE t_compact_vertical_merge;
