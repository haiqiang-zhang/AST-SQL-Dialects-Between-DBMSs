DROP TABLE IF EXISTS summing_merge_tree;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE summing_merge_tree (d Date, a String, x UInt32, y UInt64, z Float64) ENGINE = SummingMergeTree(d, a, 8192);
INSERT INTO summing_merge_tree VALUES ('2000-01-01', 'Hello', 1, 2, 3);
INSERT INTO summing_merge_tree VALUES ('2000-01-01', 'Hello', 4, 5, 6);
INSERT INTO summing_merge_tree VALUES ('2000-01-01', 'Goodbye', 1, 2, 3);
