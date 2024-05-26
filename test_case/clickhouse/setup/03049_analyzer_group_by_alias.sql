SET allow_experimental_analyzer=1;
CREATE TABLE test (`a` UInt32, `b` UInt32) ENGINE = Memory;
INSERT INTO test VALUES (1,2), (1,3), (2,4);
