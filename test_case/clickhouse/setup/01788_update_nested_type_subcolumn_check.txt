DROP TABLE IF EXISTS test_wide_nested;
CREATE TABLE test_wide_nested
(
    `id` Int,
    `info.id` Array(Int),
    `info.name` Array(String),
    `info.age` Array(Int)
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS min_bytes_for_wide_part = 0;
