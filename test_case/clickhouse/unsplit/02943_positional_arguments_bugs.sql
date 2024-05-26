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
SELECT
    sum(n),
    __unused_group_by_column 
FROM t
GROUP BY __unused_group_by_column ORDER BY __unused_group_by_column;
SELECT
    'processed' AS type,
    max(number) AS max_date,
    min(number) AS min_date
FROM numbers(100)
GROUP BY type;
