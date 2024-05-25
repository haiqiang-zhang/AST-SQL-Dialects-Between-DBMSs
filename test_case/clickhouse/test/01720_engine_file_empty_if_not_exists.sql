SET engine_file_empty_if_not_exists=0;
SET engine_file_empty_if_not_exists=1;
SELECT * FROM file_engine_table;
SET engine_file_empty_if_not_exists=0;
DROP TABLE file_engine_table;
