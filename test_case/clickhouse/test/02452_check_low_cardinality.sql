SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(String),
                            b LowCardinality(String),
                            c LowCardinality(String),
                            d LowCardinality(String)
                            )') AS json FROM test_low_cardinality_string;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(FixedString(20)),
                            b LowCardinality(FixedString(20)),
                            c LowCardinality(FixedString(20)),
                            d LowCardinality(FixedString(20))
                            )') AS json FROM test_low_cardinality_string;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(Int8),
                            b LowCardinality(Int8),
                            c LowCardinality(Int8),
                            d LowCardinality(Int8)
                            )') AS json FROM test_low_cardinality_int;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(Int16),
                            b LowCardinality(Int16),
                            c LowCardinality(Int16),
                            d LowCardinality(Int16)
                            )') AS json FROM test_low_cardinality_int;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(Int32),
                            b LowCardinality(Int32),
                            c LowCardinality(Int32),
                            d LowCardinality(Int32)
                            )') AS json FROM test_low_cardinality_int;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(Int64),
                            b LowCardinality(Int64),
                            c LowCardinality(Int64),
                            d LowCardinality(Int64)
                            )') AS json FROM test_low_cardinality_int;
SELECT JSONExtract(data, 'Tuple(
                            a LowCardinality(UUID),
                            b LowCardinality(UUID),
                            c LowCardinality(UUID),
                            d LowCardinality(UUID)
                            )') AS json FROM test_low_cardinality_uuid;
DROP TABLE test_low_cardinality_string;
DROP TABLE test_low_cardinality_uuid;
DROP TABLE test_low_cardinality_int;
