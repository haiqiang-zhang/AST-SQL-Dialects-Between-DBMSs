SET log_queries=1;
DROP TABLE IF EXISTS tabl_1;
DROP TABLE IF EXISTS tabl_2;
CREATE TABLE tabl_1 (key String) ENGINE MergeTree ORDER BY key;
CREATE TABLE tabl_2 (key String) ENGINE MergeTree ORDER BY key;
