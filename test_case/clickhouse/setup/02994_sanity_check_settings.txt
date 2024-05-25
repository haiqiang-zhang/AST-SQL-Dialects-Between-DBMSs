CREATE TABLE data_02052_1_wide0__fuzz_48
(
    `key` Nullable(Int64),
    `value` UInt8
)
    ENGINE = MergeTree
        ORDER BY key
        SETTINGS min_bytes_for_wide_part = 0, allow_nullable_key = 1 AS
SELECT
    number,
    repeat(toString(number), 5)
FROM numbers(1);
