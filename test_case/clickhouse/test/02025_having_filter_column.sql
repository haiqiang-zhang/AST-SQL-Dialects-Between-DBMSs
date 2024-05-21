drop table if exists test;
CREATE TABLE test
(
    d DateTime,
    a String,
    b UInt64
)
ENGINE = MergeTree
PARTITION BY toDate(d)
ORDER BY d;
SELECT *
FROM (
    SELECT
        a,
        max((d, b)).2 AS value
    FROM test
    GROUP BY rollup(a)
)
WHERE a <> '';
SELECT
    a,
    value
FROM
(
    SELECT
        a,
        max((d, b)).2 AS value
    FROM test
    GROUP BY a
        WITH ROLLUP
    HAVING a != ''
)
WHERE a != '';
drop table if exists test;