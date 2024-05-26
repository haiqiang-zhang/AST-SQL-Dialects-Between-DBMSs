DROP TABLE IF EXISTS rename_table_multiple;
CREATE TABLE rename_table_multiple (key Int32, value1 String, value2 Int32) ENGINE = MergeTree ORDER BY tuple() SETTINGS min_bytes_for_wide_part=0;
INSERT INTO rename_table_multiple VALUES (1, 2, 3);
ALTER TABLE rename_table_multiple RENAME COLUMN value1 TO value1_string;
ALTER TABLE rename_table_multiple MODIFY COLUMN value1_string String;
