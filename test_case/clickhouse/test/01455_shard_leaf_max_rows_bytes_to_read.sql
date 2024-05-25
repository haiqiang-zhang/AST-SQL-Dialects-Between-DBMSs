DROP TABLE IF EXISTS test_local;
DROP TABLE IF EXISTS test_distributed;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_local (date Date, value UInt32) ENGINE = MergeTree(date, date, 8192);
INSERT INTO test_local SELECT '2000-08-01', number as value from numbers(50000);
DROP TABLE IF EXISTS test_local;
DROP TABLE IF EXISTS test_distributed;
