SELECT toTypeName(sumCount(v)), sumCount(v) FROM
(
    SELECT v FROM
    (
        SELECT '9007199254740992'::UInt64 AS v
        UNION ALL
        SELECT '1'::UInt64 AS v
        UNION ALL SELECT '1'::UInt64 AS v
    )
    ORDER BY v
);
SET allow_suspicious_low_cardinality_types=1;
SELECT toTypeName(sumCount(number::Int8)), sumCount(number::Int8) FROM numbers(120);
SELECT sumCountIf(n, n > 10) FROM (SELECT number AS n FROM system.numbers LIMIT 100 );
