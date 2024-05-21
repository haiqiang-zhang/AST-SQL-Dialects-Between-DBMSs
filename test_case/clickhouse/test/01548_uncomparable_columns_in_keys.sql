DROP TABLE IF EXISTS uncomparable_keys;
CREATE TABLE foo (id UInt64, key AggregateFunction(max, UInt64)) ENGINE MergeTree ORDER BY key;
CREATE TABLE foo (id UInt64, key AggregateFunction(max, UInt64)) ENGINE MergeTree PARTITION BY key;
CREATE TABLE foo (id UInt64, key AggregateFunction(max, UInt64)) ENGINE MergeTree ORDER BY (key) SAMPLE BY key;
DROP TABLE IF EXISTS uncomparable_keys;