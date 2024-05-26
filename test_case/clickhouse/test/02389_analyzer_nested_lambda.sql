SELECT arrayMap(x -> x + arrayMap(x -> x + 1, [1])[1], [1,2,3]);
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
WITH x -> toString(x) AS lambda SELECT arrayMap(x -> lambda(x), [1,2,3]);
SELECT '--';
SELECT '--';
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=TinyLog;
INSERT INTO test_table VALUES (0, 'Value');
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
SELECT '--';
DROP TABLE test_table;
