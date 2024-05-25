DROP TABLE IF EXISTS t_sparse_detach;
CREATE TABLE t_sparse_detach(id UInt64, s String)
ENGINE = MergeTree ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
INSERT INTO t_sparse_detach SELECT number, number % 21 = 0 ? toString(number) : '' FROM numbers(10000);
INSERT INTO t_sparse_detach SELECT number, number % 21 = 0 ? toString(number) : '' FROM numbers(10000);
