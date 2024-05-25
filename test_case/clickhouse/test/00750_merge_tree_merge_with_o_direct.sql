OPTIMIZE TABLE sample_merge_tree FINAL;
SELECT * FROM sample_merge_tree ORDER BY x;
DROP TABLE IF EXISTS sample_merge_tree;
