DROP TABLE IF EXISTS t_local;
DROP TABLE IF EXISTS t1_00850;
DROP TABLE IF EXISTS t2_00850;
CREATE TABLE t_local (dummy UInt8) ENGINE = Memory;
INSERT INTO t_local VALUES (1);
SET joined_subquery_requires_alias = 0;
