DROP TABLE IF EXISTS nested1;
DROP TABLE IF EXISTS nested2;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE nested1 (d Date DEFAULT '2000-01-01', x UInt64, n Nested(a String, b String)) ENGINE = MergeTree(d, x, 1);
INSERT INTO nested1 (x, n.a, n.b) VALUES (1, ['Hello', 'World'], ['abc', 'def']), (2, [], []);
SET max_block_size = 1;
