drop table if exists test;
drop table if exists test1;
CREATE TABLE test
(
    `pt` String,
    `count_distinct_exposure_uv` AggregateFunction(uniqHLL12, Int64)
)
ENGINE = AggregatingMergeTree
ORDER BY pt;
CREATE TABLE test1
(
    `pt` String,
    `exposure_uv` Float64
)
ENGINE = Memory;
SELECT  *
FROM
(
        SELECT  m0.pt
               ,m0.exposure_uv AS exposure_uv
               ,round(m2.exposure_uv,4)
        FROM
        (
                SELECT  pt
                       ,exposure_uv
                FROM test1
        ) m0
        LEFT JOIN
        (
                SELECT  pt
                       ,exposure_uv
                FROM test1
        ) m1
        ON m0.pt = m1.pt
        LEFT JOIN
        (
                SELECT  pt
                        ,exposure_uv
                FROM test1
        ) m2
        ON m0.pt = m2.pt
) c0
ORDER BY exposure_uv
settings join_use_nulls = 1;
SELECT
    pt AS pt,
    exposure_uv AS exposure_uv
FROM
(
    SELECT
        pt
    FROM test1
) AS m0
FULL OUTER JOIN
(
    SELECT
        pt,
        exposure_uv
    FROM test1
) AS m1 ON m0.pt = m1.pt;
