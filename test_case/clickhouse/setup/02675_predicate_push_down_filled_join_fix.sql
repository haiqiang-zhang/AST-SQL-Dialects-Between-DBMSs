SET allow_experimental_analyzer = 1;
SET single_join_prefer_left_table = 0;
SET optimize_move_to_prewhere = 0;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=MergeTree ORDER BY id;
INSERT INTO test_table VALUES (0, 'Value');
DROP TABLE IF EXISTS test_table_join;
CREATE TABLE test_table_join
(
    id UInt64,
    value String
) ENGINE = Join(All, inner, id);
INSERT INTO test_table_join VALUES (0, 'JoinValue');
