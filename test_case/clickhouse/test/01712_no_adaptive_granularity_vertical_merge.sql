OPTIMIZE TABLE old_school_table FINAL;
SELECT * FROM old_school_table ORDER BY key;
OPTIMIZE TABLE old_school_table FINAL;
SELECT * FROM old_school_table ORDER BY key;
ALTER TABLE old_school_table MODIFY SETTING vertical_merge_algorithm_min_rows_to_activate = 10000, vertical_merge_algorithm_min_columns_to_activate = 10000;
OPTIMIZE TABLE old_school_table FINAL;
SELECT * FROM old_school_table ORDER BY key;
DROP TABLE IF EXISTS old_school_table;
