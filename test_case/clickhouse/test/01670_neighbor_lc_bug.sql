SELECT
    neighbor(n, -2) AS int,
    neighbor(s, -2) AS str,
    neighbor(lcs, -2) AS lowCstr
FROM
(
    SELECT
        number % 5 AS n,
        toString(n) AS s,
        CAST(s, 'LowCardinality(String)') AS lcs
    FROM numbers(10)
);
drop table if exists neighbor_test;
CREATE TABLE neighbor_test
(
    `rowNr` UInt8,
    `val_string` String,
    `val_low` LowCardinality(String)
)
ENGINE = MergeTree
PARTITION BY tuple()
ORDER BY rowNr;
INSERT INTO neighbor_test VALUES (1, 'String 1', 'String 1'), (2, 'String 1', 'String 1'), (3, 'String 2', 'String 2');
drop table if exists neighbor_test;