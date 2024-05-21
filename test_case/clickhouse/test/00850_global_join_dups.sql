DROP TABLE IF EXISTS t_local;
DROP TABLE IF EXISTS t1_00850;
DROP TABLE IF EXISTS t2_00850;
CREATE TABLE t_local (dummy UInt8) ENGINE = Memory;
CREATE TABLE t1_00850 (dummy UInt8) ENGINE = Distributed(test_shard_localhost, currentDatabase(), 't_local');
CREATE TABLE t2_00850 (dummy UInt8) ENGINE = Distributed(test_shard_localhost, currentDatabase(), 't_local');
INSERT INTO t_local VALUES (1);
SET joined_subquery_requires_alias = 0;
SELECT * FROM t1_00850
GLOBAL INNER JOIN
(
    SELECT *
    FROM ( SELECT * FROM t2_00850 )
    INNER JOIN ( SELECT * FROM t1_00850 )
    USING dummy
) USING dummy;
SELECT toDateTime64(toString(toString('0000-00-00 00:00:000000-00-00 00:00:00', toDateTime64(toDateTime64('655.36', -2, NULL)))), NULL) FROM t1_00850 GLOBAL INNER JOIN (SELECT toDateTime64(toDateTime64('6553.6', '', NULL), NULL), * FROM (SELECT * FROM t2_00850) INNER JOIN (SELECT toDateTime64('6553.7', 1024, NULL), * FROM t1_00850) USING (dummy)) USING (dummy);
SELECT toString('0000-00-00 00:00:000000-00-00 00:00:00', toDateTime64(toDateTime64('655.36', -2, NULL)));
DROP TABLE t_local;
DROP TABLE t1_00850;
DROP TABLE t2_00850;