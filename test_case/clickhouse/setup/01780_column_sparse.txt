DROP TABLE IF EXISTS t_sparse;
DROP TABLE IF EXISTS t_sparse_1;
CREATE TABLE t_sparse (id UInt64, u UInt64, s String, arr1 Array(String), arr2 Array(UInt64))
ENGINE = MergeTree ORDER BY tuple()
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.1;
INSERT INTO t_sparse SELECT
    number,
    if (number % 10 = 0, number, 0),
    if (number % 5 = 0, toString(number), ''),
    if (number % 7 = 0, arrayMap(x -> toString(x), range(number % 10)), []),
    if (number % 12 = 0, range(number % 10), [])
FROM numbers (200);
