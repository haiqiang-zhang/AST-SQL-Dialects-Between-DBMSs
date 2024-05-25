DROP TABLE IF EXISTS foo;
DROP TABLE IF EXISTS foo2;
DROP TABLE IF EXISTS foo2_dist;
DROP TABLE IF EXISTS merge1;
CREATE TABLE foo (`Id` Int32, `Val` Int32) ENGINE = MergeTree ORDER BY Id;
INSERT INTO foo SELECT number, number FROM numbers(100);
CREATE TABLE foo2 (`Id` Int32, `Val` Int32) ENGINE = MergeTree ORDER BY Id;
INSERT INTO foo2 SELECT number, number FROM numbers(100);
CREATE TABLE merge1 AS foo ENGINE = Merge(currentDatabase(), '^(foo|foo2_dist)$');
