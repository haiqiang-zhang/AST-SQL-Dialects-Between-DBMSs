ALTER TABLE column_size_bug DELETE WHERE value=1;
OPTIMIZE TABLE column_size_bug;
DROP TABLE column_size_bug;
