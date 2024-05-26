SET allow_experimental_analyzer=1;
CREATE TABLE test1(id UInt64, t1value UInt64) ENGINE=MergeTree ORDER BY tuple();
CREATE TABLE test2(id UInt64, t2value String) ENGINE=MergeTree ORDER BY tuple();
