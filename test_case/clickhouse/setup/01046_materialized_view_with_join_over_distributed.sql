set distributed_foreground_insert = 1;
DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS t_d;
DROP TABLE IF EXISTS t_v;
CREATE TABLE t (`A` Int64) ENGINE = MergeTree() ORDER BY tuple();
CREATE MATERIALIZED VIEW t_v ENGINE = MergeTree() ORDER BY tuple() AS SELECT A FROM t LEFT JOIN ( SELECT toInt64(dummy) AS A FROM system.one ) js2 USING (A);
