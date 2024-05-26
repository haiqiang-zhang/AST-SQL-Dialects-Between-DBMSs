DROP TABLE IF EXISTS test_00974;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_00974
(
    date Date,
    x Int32,
    ver UInt64
)
ENGINE = ReplacingMergeTree(date, x, 1);
INSERT INTO test_00974 VALUES ('2019-07-23', 1, 1), ('2019-07-23', 1, 2);
INSERT INTO test_00974 VALUES ('2019-07-23', 2, 1), ('2019-07-23', 2, 2);
