DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    `d` Nullable(Date),
    `f1` Nullable(String),
    `f2` Nullable(String),
    `c` Nullable(Int64)
)
ENGINE = ReplacingMergeTree
ORDER BY (f1, f2, d)
SETTINGS allow_nullable_key = 1;
INSERT INTO t SELECT
    toDate('2023-09-10', 'UTC') AS d,
    [number % 99999, NULL][number % 2] AS f1,
    ['x', NULL][number % 2] AS f2,
    [number, NULL][number % 2] AS c
FROM numbers(100000);