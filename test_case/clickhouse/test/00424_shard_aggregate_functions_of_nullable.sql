SELECT avg(arrayJoin([NULL]));
SELECT avg(arrayJoin([NULL, 1]));
SELECT avg(arrayJoin([NULL, 1, 2]));
SELECT quantileExactWeighted(0.5)(x, y) FROM
(
    SELECT CAST(NULL AS Nullable(UInt8)) AS x, CAST(1 AS Nullable(UInt8)) AS y
    UNION ALL
    SELECT CAST(2 AS Nullable(UInt8)) AS x, CAST(NULL AS Nullable(UInt8)) AS y
);
SELECT quantileExactWeighted(0.5)(x, y) FROM
(
    SELECT CAST(1 AS Nullable(UInt8)) AS x, CAST(0 AS Nullable(UInt8)) AS y
    UNION ALL
    SELECT CAST(NULL AS Nullable(UInt8)) AS x, CAST(1 AS Nullable(UInt8)) AS y
    UNION ALL
    SELECT CAST(2 AS Nullable(UInt8)) AS x, CAST(NULL AS Nullable(UInt8)) AS y
    UNION ALL
    SELECT CAST(number AS Nullable(UInt8)) AS x, CAST(number AS Nullable(UInt8)) AS y FROM system.numbers LIMIT 10
);
SELECT quantileExactWeighted(0.5)(x, y) FROM
(
    SELECT CAST(NULL AS Nullable(UInt8)) AS x, 1 AS y
    UNION ALL
    SELECT CAST(2 AS Nullable(UInt8)) AS x, 1 AS y
);
SELECT quantileExactWeighted(0.5)(x, y) FROM
(
    SELECT CAST(NULL AS Nullable(UInt8)) AS x, 1 AS y
);
SELECT CAST(NULL AS Nullable(UInt64)) FROM system.numbers LIMIT 2;