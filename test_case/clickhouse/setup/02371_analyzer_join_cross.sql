SET allow_experimental_analyzer = 1;
SET single_join_prefer_left_table = 0;
DROP TABLE IF EXISTS test_table_join_1;
CREATE TABLE test_table_join_1
(
    id UInt64,
    value String
) ENGINE = TinyLog;
DROP TABLE IF EXISTS test_table_join_2;
CREATE TABLE test_table_join_2
(
    id UInt64,
    value String
) ENGINE = TinyLog;
DROP TABLE IF EXISTS test_table_join_3;
CREATE TABLE test_table_join_3
(
    id UInt64,
    value String
) ENGINE = TinyLog;
INSERT INTO test_table_join_1 VALUES (0, 'Join_1_Value_0');
INSERT INTO test_table_join_1 VALUES (1, 'Join_1_Value_1');
INSERT INTO test_table_join_1 VALUES (3, 'Join_1_Value_3');
INSERT INTO test_table_join_2 VALUES (0, 'Join_2_Value_0');
INSERT INTO test_table_join_2 VALUES (1, 'Join_2_Value_1');
INSERT INTO test_table_join_2 VALUES (2, 'Join_2_Value_2');
INSERT INTO test_table_join_3 VALUES (0, 'Join_3_Value_0');
INSERT INTO test_table_join_3 VALUES (1, 'Join_3_Value_1');
INSERT INTO test_table_join_3 VALUES (2, 'Join_3_Value_2');