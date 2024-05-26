DROP TABLE IF EXISTS pk_set;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE pk_set (d Date, n UInt64, host String, code UInt64) ENGINE = MergeTree(d, (n, host, code), 1);
INSERT INTO pk_set (n, host, code) VALUES (1, 'market', 100), (11, 'news', 100);
SELECT count() FROM pk_set WHERE host IN ('admin.market1', 'admin.market2') AND code = 100;
