SET join_algorithm = 'partial_merge';
SET max_bytes_in_join = '100';
CREATE TABLE foo_lc (n LowCardinality(String)) ENGINE = Memory;
CREATE TABLE foo (n String) ENGINE = Memory;
INSERT INTO foo SELECT toString(number) AS n FROM system.numbers LIMIT 1025;
INSERT INTO foo_lc SELECT toString(number) AS n FROM system.numbers LIMIT 1025;
