-- test for #56790

DROP TABLE IF EXISTS test_local;
CREATE TABLE test_local (x Int64) ENGINE = MergeTree order by x as select * from numbers(10);
set prefer_localhost_replica=0;
DROP TABLE test_local;
