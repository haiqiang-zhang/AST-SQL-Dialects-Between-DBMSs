SELECT COUNT(*) FROM demo WHERE col_1='same_value_col1' AND col_3 IS NOT NULL;
UPDATE demo SET col_3 = NULL WHERE col_1='same_value_col1' AND col_3='same_value_col3';
DROP PROCEDURE IF EXISTS insert_demo_data;
DROP TABLE demo;
