set allow_deprecated_syntax_for_merge_tree=0;
DROP TABLE IF EXISTS test;
CREATE TABLE test (uid String, version UInt32, is_deleted UInt8) ENGINE = ReplacingMergeTree(version) Order by (uid) settings allow_experimental_replacing_merge_with_cleanup=1;
INSERT INTO test (*) VALUES ('d1', 1, 0), ('d2', 1, 0), ('d6', 1, 0), ('d4', 1, 0), ('d6', 2, 1), ('d3', 1, 0), ('d1', 2, 1), ('d5', 1, 0), ('d4', 2, 1), ('d1', 3, 0), ('d1', 4, 1), ('d4', 3, 0), ('d1', 5, 0);
