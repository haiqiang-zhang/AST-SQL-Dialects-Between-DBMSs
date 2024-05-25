DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (`s` String, `x` Array(UInt8), `k` UInt64) ENGINE = Join(ANY, LEFT, k);
CREATE TABLE t2 (`s` String, `x` Array(UInt8), `k` UInt64) ENGINE = Join(ANY, INNER, k);
DROP TABLE t1;
DROP TABLE t2;
