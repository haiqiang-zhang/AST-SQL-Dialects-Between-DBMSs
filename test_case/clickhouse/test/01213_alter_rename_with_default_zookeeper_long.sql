SHOW CREATE TABLE table_rename_with_default;
ALTER TABLE table_rename_with_default RENAME COLUMN value1 TO renamed_value1;
SHOW CREATE TABLE table_rename_with_default;
SELECT value2 FROM table_rename_with_default WHERE key = 1;
SELECT value3 FROM table_rename_with_default WHERE key = 1;
DROP TABLE IF EXISTS table_rename_with_default;
DROP TABLE IF EXISTS table_rename_with_ttl;
DROP TABLE IF EXISTS table_rename_with_ttl;
