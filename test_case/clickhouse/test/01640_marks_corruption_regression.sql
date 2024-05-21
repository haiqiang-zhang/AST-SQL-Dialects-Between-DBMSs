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
--
--     $ check-marks /path/to/db/adaptive_table/all_*/key.{mrk2,bin}
--     Mark 0, points to 0, 0, has rows after 8192, decompressed size 72808. <!-- wrong number of rows, should be 5461
--     Mark 1, points to 0, 43688, has rows after 1820, decompressed size 29120.
--     Mark 2, points to 0, 58248, has rows after 1820, decompressed size 14560.
--     Mark 3, points to 36441, 0, has rows after 1820, decompressed size 58264.
--     Mark 4, points to 36441, 14560, has rows after 1820, decompressed size 43704.
--     Mark 5, points to 36441, 29120, has rows after 8192, decompressed size 29144.
--     Mark 6, points to 36441, 58264, has rows after 0, decompressed size 0.
OPTIMIZE TABLE adaptive_table FINAL;
DETACH TABLE adaptive_table;
ATTACH TABLE adaptive_table;
DROP TABLE adaptive_table;