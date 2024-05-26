SELECT avg(arrayJoin([NULL]));
SELECT quantileExactWeighted(0.5)(x, y) FROM
(
    SELECT CAST(NULL AS Nullable(UInt8)) AS x, CAST(1 AS Nullable(UInt8)) AS y
    UNION ALL
    SELECT CAST(2 AS Nullable(UInt8)) AS x, CAST(NULL AS Nullable(UInt8)) AS y
);
SELECT CAST(NULL AS Nullable(UInt64)) FROM system.numbers LIMIT 2;
