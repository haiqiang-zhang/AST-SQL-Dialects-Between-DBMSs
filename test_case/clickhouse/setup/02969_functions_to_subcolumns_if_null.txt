DROP TABLE IF EXISTS t_subcolumns_if;
CREATE TABLE t_subcolumns_if (id Nullable(Int64)) ENGINE=MergeTree ORDER BY tuple();
INSERT INTO t_subcolumns_if SELECT number::Nullable(Int64) as number FROM numbers(10000);
