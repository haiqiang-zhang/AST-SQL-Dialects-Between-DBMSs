DROP TABLE IF EXISTS file_engine_table;
CREATE TABLE file_engine_table (id UInt32) ENGINE=File(TSV);
SET engine_file_empty_if_not_exists=0;
SET engine_file_empty_if_not_exists=1;
