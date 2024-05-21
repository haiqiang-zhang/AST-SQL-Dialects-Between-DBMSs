DROP TABLE IF EXISTS lwd_test;
CREATE TABLE lwd_test
(
    `id` UInt64,
    `value` String
)
ENGINE = MergeTree
ORDER BY id
SETTINGS
    vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 1,
    min_rows_for_wide_part = 1,
    min_bytes_for_wide_part = 1;
INSERT INTO lwd_test SELECT number AS id, toString(number) AS value FROM numbers(10);
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
SET mutations_sync = 0;
DELETE FROM lwd_test WHERE (id % 3) = 0;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
OPTIMIZE TABLE lwd_test FINAL SETTINGS mutations_sync = 2;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
DELETE FROM lwd_test WHERE (id % 2) = 0;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
INSERT INTO lwd_test SELECT number AS id, toString(number+100) AS value FROM numbers(10);
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
-- physically delete the rows
OPTIMIZE TABLE lwd_test FINAL SETTINGS mutations_sync = 2;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
INSERT INTO lwd_test SELECT number AS id, toString(number+200) AS value FROM numbers(10);
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
DELETE FROM lwd_test WHERE (id % 3) = 2;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
-- physically delete the rows
OPTIMIZE TABLE lwd_test FINAL SETTINGS mutations_sync = 2;
SELECT * FROM lwd_test ORDER BY id, value;
SELECT name, part_type
FROM system.parts
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name;
SELECT name, column, type, rows
FROM system.parts_columns
WHERE (database = currentDatabase()) AND (table = 'lwd_test') AND active
ORDER BY name, column;
DROP TABLE lwd_test;