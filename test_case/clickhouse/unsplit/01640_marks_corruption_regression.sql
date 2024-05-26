DROP TABLE IF EXISTS adaptive_table;
CREATE TABLE adaptive_table(
    key UInt64,
    value String
) ENGINE MergeTree()
ORDER BY key
SETTINGS
    index_granularity_bytes=1048576,
    min_bytes_for_wide_part=0,
    old_parts_lifetime=0,
    index_granularity=8192;
INSERT INTO adaptive_table SELECT number, randomPrintableASCII(if(number BETWEEN 8192-30 AND 8192, 102400, 1)) FROM system.numbers LIMIT 16384;

--     Mark 6, points to 36441, 58264, has rows after 0, decompressed size 0.
OPTIMIZE TABLE adaptive_table FINAL;
DETACH TABLE adaptive_table;
ATTACH TABLE adaptive_table;
DROP TABLE adaptive_table;
