DROP TABLE IF EXISTS t_having;
CREATE TABLE t_having (c0 Int32, c1 UInt64) ENGINE = Memory;
INSERT INTO t_having SELECT number, number FROM numbers(1000);
