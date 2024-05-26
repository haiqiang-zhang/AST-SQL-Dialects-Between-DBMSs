DROP TABLE IF EXISTS test_01778;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_01778
(
    `key` LowCardinality(FixedString(3)),
    `d` date
)
ENGINE = MergeTree(d, key, 8192);
INSERT INTO test_01778 SELECT toString(intDiv(number,8000)), today() FROM numbers(100000);
INSERT INTO test_01778 SELECT toString('xxx'), today() FROM numbers(100);
