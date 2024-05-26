DROP TABLE IF EXISTS join_test;
DROP TABLE IF EXISTS join_test_right;
CREATE TABLE join_test ( `key` UInt64, `value` UInt64 ) ENGINE = Join(ANY, LEFT, key);
CREATE TEMPORARY TABLE initial_table_size AS
    SELECT engine_full, total_rows, total_bytes FROM system.tables WHERE (name = 'join_test') AND (database = currentDatabase());
