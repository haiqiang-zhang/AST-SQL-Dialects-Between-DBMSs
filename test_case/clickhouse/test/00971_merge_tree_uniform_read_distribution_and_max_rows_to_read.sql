SET max_threads = 4;
SET max_rows_to_read = 1100000;
SELECT count() FROM merge_tree;
SELECT count() FROM merge_tree;
SET max_rows_to_read = 900000;
DROP TABLE merge_tree;
