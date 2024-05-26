SET allow_experimental_analyzer=1;
CREATE TABLE t1 (i Int64, j Int64) ENGINE = Memory;
INSERT INTO t1 SELECT number, number FROM system.numbers LIMIT 10;
