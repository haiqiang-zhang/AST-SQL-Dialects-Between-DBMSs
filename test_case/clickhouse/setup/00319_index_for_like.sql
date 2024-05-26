SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS index_for_like;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE index_for_like (s String, d Date DEFAULT today()) ENGINE = MergeTree(d, (s, d), 1);
INSERT INTO index_for_like (s) VALUES ('Hello'), ('Hello, World'), ('Hello, World 1'), ('Hello 1'), ('Goodbye'), ('Goodbye, World'), ('Goodbye 1'), ('Goodbye, World 1');
SET max_rows_to_read = 3;
