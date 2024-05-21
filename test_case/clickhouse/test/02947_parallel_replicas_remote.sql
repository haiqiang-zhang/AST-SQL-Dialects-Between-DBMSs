DROP TABLE IF EXISTS test;
CREATE TABLE test (id UInt64, date Date)
ENGINE = MergeTree
ORDER BY id
AS select *, '2023-12-25' from numbers(100);
DROP TABLE test;
