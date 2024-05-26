DROP TABLE IF EXISTS merge;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE IF NOT EXISTS merge (d Date DEFAULT '2000-01-01', x UInt64) ENGINE = MergeTree(d, x, 5);
INSERT INTO merge (x) VALUES (1), (2), (3);
INSERT INTO merge (x) VALUES (4), (5), (6);
