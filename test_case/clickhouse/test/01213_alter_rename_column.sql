SELECT value1 FROM table_for_rename WHERE key = 1;
ALTER TABLE table_for_rename RENAME COLUMN value1 to renamed_value1;
SELECT renamed_value1 FROM table_for_rename WHERE key = 1;
ALTER TABLE table_for_rename RENAME COLUMN value2 TO renamed_value2, RENAME COLUMN value3 TO renamed_value3;
SELECT renamed_value2, renamed_value3 FROM table_for_rename WHERE key = 7;
ALTER TABLE table_for_rename RENAME COLUMN IF EXISTS value100 to renamed_value100;
DROP TABLE IF EXISTS table_for_rename;
