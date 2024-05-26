SELECT * 
FROM
(
SELECT
  max(`column_1`) AS `column_1`,
NULL AS `column_2`,
  `id`
FROM `clickhouse_alias_issue_1`
GROUP BY
  `id`
UNION ALL
SELECT
  NULL AS `column_1`,
  max(`column_2`) AS `column_2`,
  `id`
FROM `clickhouse_alias_issue_2`
GROUP BY
  `id`
SETTINGS prefer_column_name_to_alias=1
)
ORDER BY ALL DESC NULLS LAST;
SELECT '-------------------------';
SELECT
  max(`column_1`) AS `column_1`,
  max(`column_2`) AS `column_2`,
  `id`
FROM (
  SELECT
    max(`column_1`) AS `column_1`,
    NULL AS `column_2`,
    `id`
  FROM `clickhouse_alias_issue_1`
  GROUP BY
    `id`
  UNION ALL
  SELECT
    NULL AS `column_1`,
    max(`column_2`) AS `column_2`,
    `id`
  FROM `clickhouse_alias_issue_2`
  GROUP BY
    `id`
  SETTINGS prefer_column_name_to_alias=1
) as T1
GROUP BY `id`
ORDER BY `id` DESC
SETTINGS prefer_column_name_to_alias=1;
SELECT '-------------------------';
SELECT `column_1` / `column_2`, `id`
FROM (
    SELECT
        max(`column_1`) AS `column_1`,
        max(`column_2`) AS `column_2`,
        `id`
    FROM (
        SELECT
          max(`column_1`) AS `column_1`,
          NULL AS `column_2`,
          `id`
        FROM `clickhouse_alias_issue_1`
        GROUP BY
          `id`
        UNION ALL
        SELECT
          NULL AS `column_1`,
          max(`column_2`) AS `column_2`,
          `id`
        FROM `clickhouse_alias_issue_2`
        GROUP BY
          `id`
        SETTINGS prefer_column_name_to_alias=1
        ) as T1
    GROUP BY `id`
    ORDER BY `id` DESC
    SETTINGS prefer_column_name_to_alias=1
) as T2
WHERE `column_1` IS NOT NULL AND `column_2` IS NOT NULL
SETTINGS prefer_column_name_to_alias=1;
SELECT '-------------------------';
SELECT `column_1` / `column_2`, `id`
FROM (
    SELECT
        max(`column_1`) AS `column_1`,
        max(`column_2`) AS `column_2`,
        `id`
    FROM (
        SELECT
          max(`column_1`) AS `column_1`,
          NULL AS `column_2`,
          `id`
        FROM `clickhouse_alias_issue_1`
        GROUP BY
          `id`
        UNION ALL
        SELECT
          NULL AS `column_1`,
          max(`column_2`) AS `column_2`,
          `id`
        FROM `clickhouse_alias_issue_2`
        GROUP BY
          `id`
        ) as T1
    GROUP BY `id`
    ORDER BY `id` DESC
) as T2
WHERE `column_1` IS NOT NULL AND `column_2` IS NOT NULL;
DROP TABLE IF EXISTS clickhouse_alias_issue_1;
DROP TABLE IF EXISTS clickhouse_alias_issue_2;
