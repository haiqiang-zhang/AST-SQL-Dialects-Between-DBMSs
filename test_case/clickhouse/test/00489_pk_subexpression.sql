DROP TABLE IF EXISTS pk;
set allow_deprecated_syntax_for_merge_tree=1;
-- timezones" (timezones that does not starts from 00:00), like
-- Africa/Monrovia, for which toStartOfMinute(0) and toStartOfMinute(59) can
-- give different values:
--
--     SELECT
--         toDateTime(0, 'Africa/Monrovia') AS sec0,
--         toDateTime(59, 'Africa/Monrovia') AS sec59
--
--     âââââââââââââââââsec0ââ¬âââââââââââââââsec59ââ
--     â 1969-12-31 23:15:30 â 1969-12-31 23:16:29 â
--     âââââââââââââââââââââââ´ââââââââââââââââââââââ
--
CREATE TABLE pk (d Date DEFAULT '2000-01-01', x DateTime, y UInt64, z UInt64) ENGINE = MergeTree(d, (toStartOfMinute(x, 'UTC'), y, z), 1);
INSERT INTO pk (x, y, z) VALUES (1, 11, 1235), (2, 11, 4395), (3, 22, 3545), (4, 22, 6984), (5, 33, 4596), (61, 11, 4563), (62, 11, 4578), (63, 11, 3572), (64, 22, 5786), (65, 22, 5786), (66, 22, 2791), (67, 22, 2791), (121, 33, 2791), (122, 33, 2791), (123, 33, 1235), (124, 44, 4935), (125, 44, 4578), (126, 55, 5786), (127, 55, 2791), (128, 55, 1235);
SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
SET max_block_size = 1;
SET max_rows_to_read = 5;
SELECT toUInt32(x), y, z FROM pk WHERE x BETWEEN toDateTime(0) AND toDateTime(59);
SET max_rows_to_read = 9;
SELECT toUInt32(x), y, z FROM pk WHERE x BETWEEN toDateTime(120) AND toDateTime(240);
SET max_rows_to_read = 5;
SELECT toUInt32(x), y, z FROM pk WHERE x = toDateTime(1);
SET max_rows_to_read = 4;
SELECT toUInt32(x), y, z FROM pk WHERE (x BETWEEN toDateTime(60) AND toDateTime(119)) AND y = 11;
SET max_rows_to_read = 5;
SELECT toUInt32(x), y, z FROM pk WHERE (x BETWEEN toDateTime(60) AND toDateTime(120)) AND y = 11;
DROP TABLE pk;