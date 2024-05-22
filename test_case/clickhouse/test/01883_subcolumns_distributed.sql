DROP TABLE IF EXISTS t_subcolumns_local;
DROP TABLE IF EXISTS t_subcolumns_dist;
CREATE TABLE t_subcolumns_local (arr Array(UInt32), n Nullable(String), t Tuple(s1 String, s2 String))
ENGINE = MergeTree ORDER BY tuple();
INSERT INTO t_subcolumns_local VALUES ([1, 2, 3], 'aaa', ('bbb', 'ccc'));
DROP TABLE t_subcolumns_local;
CREATE TABLE t_subcolumns_local (arr Array(UInt32), n Nullable(String), t Tuple(s1 String, s2 String)) ENGINE = StripeLog;
DROP TABLE t_subcolumns_local;
