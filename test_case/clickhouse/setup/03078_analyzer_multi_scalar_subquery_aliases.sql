SET allow_experimental_analyzer=1;
CREATE TABLE t2 (first_column Int64, second_column Int64) ENGINE = Memory;
INSERT INTO t2 SELECT number, number FROM system.numbers LIMIT 10;
