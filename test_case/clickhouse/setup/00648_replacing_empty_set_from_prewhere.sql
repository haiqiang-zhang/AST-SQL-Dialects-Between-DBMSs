DROP TABLE IF EXISTS final_test;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE final_test (id String, version Date) ENGINE = ReplacingMergeTree(version, id, 8192);
INSERT INTO final_test (id, version) VALUES ('2018-01-01', '2018-01-01');
