DROP TABLE IF EXISTS sparse_tuple;
CREATE TABLE sparse_tuple (id UInt64, t Tuple(a UInt64, s String))
ENGINE = MergeTree ORDER BY tuple()
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.5;
INSERT INTO sparse_tuple SELECT number, (if (number % 20 = 0, number, 0), repeat('a', number % 10 + 1)) FROM numbers(1000);
