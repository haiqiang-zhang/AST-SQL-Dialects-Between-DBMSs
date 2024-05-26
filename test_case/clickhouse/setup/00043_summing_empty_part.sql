DROP TABLE IF EXISTS empty_summing;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE empty_summing (d Date, k UInt64, v Int8) ENGINE=SummingMergeTree(d, k, 8192);
INSERT INTO empty_summing VALUES ('2015-01-01', 1, 10);
INSERT INTO empty_summing VALUES ('2015-01-01', 1, -10);
