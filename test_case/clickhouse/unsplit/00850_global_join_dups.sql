DROP TABLE IF EXISTS t_local;
DROP TABLE IF EXISTS t1_00850;
DROP TABLE IF EXISTS t2_00850;
CREATE TABLE t_local (dummy UInt8) ENGINE = Memory;
INSERT INTO t_local VALUES (1);
SET joined_subquery_requires_alias = 0;
SELECT toString('0000-00-00 00:00:000000-00-00 00:00:00', toDateTime64(toDateTime64('655.36', -2, NULL)));
DROP TABLE t_local;
