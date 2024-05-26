DROP TABLE IF EXISTS testJoinTable;
SET any_join_distinct_right_table_keys = 1;
SET enable_optimize_predicate_expression = 0;
CREATE TABLE testJoinTable (number UInt64, data String) ENGINE = Join(ANY, INNER, number) SETTINGS any_join_distinct_right_table_keys = 1;
INSERT INTO testJoinTable VALUES (1, '1'), (2, '2'), (3, '3');
