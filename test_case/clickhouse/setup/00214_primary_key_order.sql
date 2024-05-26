DROP TABLE IF EXISTS primary_key;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE primary_key (d Date DEFAULT today(), x Int8) ENGINE = MergeTree(d, -x, 1);
INSERT INTO primary_key (x) VALUES (1), (2), (3);
