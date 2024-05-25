SELECT '-- 1 shard, 3 replicas';
DROP TABLE IF EXISTS test_d;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id UInt64, date Date)
ENGINE = MergeTree
ORDER BY id;
insert into test select *, today() from numbers(100);
insert into test select *, today() from numbers(100);
SELECT '-- 2 shards, 3 replicas each';
DROP TABLE IF EXISTS test2_d;
DROP TABLE IF EXISTS test2;
CREATE TABLE test2 (id UInt64, date Date)
ENGINE = MergeTree
ORDER BY id;
insert into test2 select *, today() from numbers(100);
insert into test2 select *, today() from numbers(100);
