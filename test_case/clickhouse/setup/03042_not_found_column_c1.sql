SET allow_experimental_analyzer=1;
CREATE TABLE IF NOT EXISTS t0 (c0 Int32) ENGINE = Memory();
CREATE TABLE t1 (c0 Int32, c1 Int32, c2 Int32) ENGINE = Memory();
CREATE TABLE t2 (c0 String, c1 String MATERIALIZED (c2), c2 Int32) ENGINE = Memory();
CREATE TABLE t3 (c0 String, c1 String, c2 String) ENGINE = Log();
CREATE TABLE IF NOT EXISTS t4 (c0 Int32) ENGINE = Log();
