SELECT * FROM mv;
SET allow_experimental_alter_materialized_view_structure = 1;
DROP TABLE src_table;
DROP TABLE mv;
