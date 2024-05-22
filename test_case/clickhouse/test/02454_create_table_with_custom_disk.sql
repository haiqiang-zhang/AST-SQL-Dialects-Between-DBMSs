DROP TABLE IF EXISTS test;
EXPLAIN SYNTAX
CREATE TABLE test (a Int32)
ENGINE = MergeTree() order by tuple()
SETTINGS disk = disk(type=local, path='/var/lib/clickhouse/disks/local/');
