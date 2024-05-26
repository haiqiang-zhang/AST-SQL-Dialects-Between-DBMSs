SELECT id, alias_value_1, alias_value_2 FROM test_table;
DROP TABLE test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String,
    alias_value ALIAS ((id + 1) AS inside_value) + inside_value
) ENGINE=TinyLog;
INSERT INTO test_table VALUES (0, 'Value');
SELECT id, value, alias_value FROM test_table;
DROP TABLE test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String,
    alias_value ALIAS ((id + 1) AS value) + value
) ENGINE=TinyLog;
INSERT INTO test_table VALUES (0, 'Value');
SELECT id, value, alias_value FROM test_table;
DROP TABLE test_table;
