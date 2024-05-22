DROP TABLE IF EXISTS test_table_join;
CREATE TABLE test_table_join
(
    id UInt64,
    value String
) ENGINE = Join(Any, Left, id);
INSERT INTO test_table_join VALUES (1, 'q');
DROP TABLE IF EXISTS test_table_join;
