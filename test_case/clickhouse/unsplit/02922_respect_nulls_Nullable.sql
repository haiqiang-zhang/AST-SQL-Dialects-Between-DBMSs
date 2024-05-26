SELECT
    any(tp) AS default,
    toTypeName(default) as default_type,
    any(tp) RESPECT NULLS AS respect,
    toTypeName(respect) as respect_type
FROM
(
    SELECT (toLowCardinality(number), number) AS tp
    FROM numbers(10)
);
SELECT first_value_respect_nullsMerge(t) FROM (Select first_value_respect_nullsState(number) as t FROM numbers(0));
SELECT first_value_respect_nullsOrNullMerge(t) FROM (Select first_value_respect_nullsOrNullState(number) as t FROM numbers(0));
SELECT
    anyLastIf(n, cond) RESPECT NULLS,
    anyLastIf(nullable_n, cond) RESPECT NULLS
FROM
(
    SELECT
        number AS n,
        NULL as cond,
        number::Nullable(Int64) as nullable_n
    FROM numbers(10000)
);
