SELECT
    label,
    number
FROM
(
    SELECT
        'a' AS label,
        number
    FROM
    (
        SELECT number
        FROM numbers(10)
    )
    UNION ALL
    SELECT
        'b' AS label,
        number
    FROM
    (
        SELECT number
        FROM numbers(10)
    )
)
WHERE number IN
(
    SELECT number
    FROM numbers(5)
) order by label, number;
SELECT NULL FROM
(SELECT [1048575, NULL] AS ax, 2147483648 AS c) t1 ARRAY JOIN ax
INNER JOIN (SELECT NULL AS c) t2 USING (c);
