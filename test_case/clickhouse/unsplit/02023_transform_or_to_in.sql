DROP TABLE IF EXISTS t_transform_or;
CREATE TABLE t_transform_or(B AggregateFunction(uniq, String), A String) Engine=MergeTree ORDER BY (A);
INSERT INTO t_transform_or SELECT uniqState(''), '0';
DROP TABLE t_transform_or;
