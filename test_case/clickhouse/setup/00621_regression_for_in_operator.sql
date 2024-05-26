DROP TABLE IF EXISTS regression_for_in_operator_view;
DROP TABLE IF EXISTS regression_for_in_operator;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE regression_for_in_operator (d Date, v UInt32, g String) ENGINE=MergeTree(d, d, 8192);
CREATE MATERIALIZED VIEW regression_for_in_operator_view ENGINE=AggregatingMergeTree(d, (d,g), 8192) AS SELECT d, g, maxState(v) FROM regression_for_in_operator GROUP BY d, g;
INSERT INTO regression_for_in_operator SELECT today(), toString(number % 10), number FROM system.numbers limit 1000;
