DROP TABLE IF EXISTS t_local;
DROP TABLE IF EXISTS t_distr;
CREATE TABLE t_local (a Int) ENGINE = Memory;
INSERT INTO t_local VALUES (1), (2);
SET optimize_skip_unused_shards = 1;
DROP table t_local;
