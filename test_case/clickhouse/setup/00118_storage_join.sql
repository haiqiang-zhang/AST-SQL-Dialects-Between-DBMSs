DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (k UInt64, s String) ENGINE = Join(ANY, LEFT, k);
INSERT INTO t2 VALUES (1, 'abc'), (2, 'def');