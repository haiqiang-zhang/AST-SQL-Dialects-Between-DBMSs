SET convert_query_to_cnf = 1;
SET optimize_using_constraints = 1;
SET optimize_move_to_prewhere = 1;
SET optimize_substitute_columns = 1;
SET optimize_append_index = 1;
DROP TABLE IF EXISTS column_swap_test_test;
CREATE TABLE column_swap_test_test (i Int64, a String, b UInt64, CONSTRAINT c1 ASSUME b = cityHash64(a)) ENGINE = MergeTree() ORDER BY i;
INSERT INTO column_swap_test_test VALUES (1, 'cat', 1), (2, 'dog', 2);
