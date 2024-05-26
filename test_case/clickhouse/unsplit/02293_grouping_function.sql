set optimize_group_by_function_keys=0;
SELECT
    number,
    grouping(number, number % 2) AS gr
FROM numbers(10)
GROUP BY
    GROUPING SETS (
        (number),
        (number % 2)
    )
ORDER BY number, gr
SETTINGS force_grouping_standard_compatibility=0;
SELECT
    number,
    count(),
    grouping(number, number % 2) AS gr
FROM numbers(10)
GROUP BY
    GROUPING SETS (
        (number),
        (number, number % 2),
        ()
    )
ORDER BY (gr, number)
SETTINGS force_grouping_standard_compatibility=0;
