DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    `n` int,
    `__unused_group_by_column` int
)
ENGINE = MergeTree
ORDER BY n AS
SELECT number, number
FROM numbers(10);
