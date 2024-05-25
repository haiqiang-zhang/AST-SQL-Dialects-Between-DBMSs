DROP TABLE IF EXISTS test_grouping_sets_predicate;
CREATE TABLE test_grouping_sets_predicate
(
    day_ Date,
    type_1 String
)
ENGINE=MergeTree
ORDER BY day_;
INSERT INTO test_grouping_sets_predicate SELECT
    toDate('2023-01-05') AS day_,
    'hello, world'
FROM numbers (10);
