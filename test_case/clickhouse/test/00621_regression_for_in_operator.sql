SELECT count() FROM regression_for_in_operator_view WHERE g = '5';
SET optimize_min_equality_disjunction_chain_length = 1;
EXPLAIN QUERY TREE SELECT count() FROM regression_for_in_operator_view WHERE g = '5' OR g = '6' SETTINGS allow_experimental_analyzer = 1;
SET optimize_min_equality_disjunction_chain_length = 3;
DROP TABLE regression_for_in_operator_view;
DROP TABLE regression_for_in_operator;
