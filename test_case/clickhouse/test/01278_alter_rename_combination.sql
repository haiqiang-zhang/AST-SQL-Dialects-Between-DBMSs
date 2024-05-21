DROP TABLE IF EXISTS rename_table;
CREATE TABLE rename_table (key Int32, value1 Int32, value2 Int32) ENGINE = MergeTree ORDER BY tuple() SETTINGS min_bytes_for_wide_part=0;
INSERT INTO rename_table VALUES (1, 2, 3);
ALTER TABLE rename_table RENAME COLUMN value1 TO old_value1, RENAME COLUMN value2 TO value1;
SHOW CREATE TABLE rename_table;
INSERT INTO rename_table VALUES (4, 5, 6);
ALTER TABLE rename_table RENAME COLUMN old_value1 TO v1, RENAME COLUMN value1 TO v2, RENAME COLUMN key to k;
SHOW CREATE TABLE rename_table;
DROP TABLE IF EXISTS rename_table;
SELECT '---polymorphic---';
DROP TABLE IF EXISTS rename_table_polymorphic;
CREATE TABLE rename_table_polymorphic (
  key Int32,
  value1 Int32,
  value2 Int32
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS min_rows_for_wide_part = 10000;
INSERT INTO rename_table_polymorphic VALUES (1, 2, 3);
ALTER TABLE rename_table_polymorphic RENAME COLUMN value1 TO old_value1, RENAME COLUMN value2 TO value1;
SHOW CREATE TABLE rename_table_polymorphic;
INSERT INTO rename_table_polymorphic VALUES (4, 5, 6);
ALTER TABLE rename_table_polymorphic RENAME COLUMN old_value1 TO v1, RENAME COLUMN value1 TO v2, RENAME COLUMN key to k;
SHOW CREATE TABLE rename_table_polymorphic;
DROP TABLE IF EXISTS rename_table_polymorphic;
