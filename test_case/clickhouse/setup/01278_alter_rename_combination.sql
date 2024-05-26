DROP TABLE IF EXISTS rename_table;
CREATE TABLE rename_table (key Int32, value1 Int32, value2 Int32) ENGINE = MergeTree ORDER BY tuple() SETTINGS min_bytes_for_wide_part=0;
INSERT INTO rename_table VALUES (1, 2, 3);
ALTER TABLE rename_table RENAME COLUMN value1 TO old_value1, RENAME COLUMN value2 TO value1;
