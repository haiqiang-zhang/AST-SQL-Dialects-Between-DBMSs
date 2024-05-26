SELECT count() FROM merge_tree;
SET max_rows_to_read = 900000;
DROP TABLE merge_tree;
