SYSTEM STOP MERGES limited_merge_table;
INSERT INTO limited_merge_table SELECT number FROM numbers(100);
SYSTEM START MERGES limited_merge_table;
OPTIMIZE TABLE limited_merge_table FINAL;
SYSTEM FLUSH LOGS;
SELECT COUNT() FROM limited_merge_table;
DROP TABLE IF EXISTS limited_merge_table;
