DROP TABLE IF EXISTS t_sparse;
CREATE TABLE t_sparse (id UInt64, u UInt64, s String)
ENGINE = MergeTree ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9, index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO t_sparse SELECT
    number,
    if (number % 20 = 0, number, 0),
    if (number % 50 = 0, toString(number), '')
FROM numbers(1, 100000);
