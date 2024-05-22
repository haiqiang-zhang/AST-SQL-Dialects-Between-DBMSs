DROP TABLE IF EXISTS local_table;
DROP TABLE IF EXISTS dist_table;
CREATE TABLE local_table (id UInt64, val String) ENGINE = Memory;
INSERT INTO local_table SELECT number AS id, toString(number) AS val FROM numbers(100);
DROP TABLE local_table;
