SELECT value1 FROM table_with_compact_parts WHERE key = 1;
ALTER TABLE table_with_compact_parts RENAME COLUMN value1 to renamed_value1;
SELECT renamed_value1 FROM table_with_compact_parts WHERE key = 1;
ALTER TABLE table_with_compact_parts RENAME COLUMN value2 TO renamed_value2, RENAME COLUMN value3 TO renamed_value3;
SELECT renamed_value2, renamed_value3 FROM table_with_compact_parts WHERE key = 7;
DROP TABLE IF EXISTS table_with_compact_parts;
