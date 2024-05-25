SELECT
    sum(multiIf(id IS NOT NULL, 1, 0))
FROM t_subcolumns_if
SETTINGS allow_experimental_analyzer = 1, optimize_functions_to_subcolumns = 1;
SELECT
    sum(multiIf(id IS NULL, 1, 0))
FROM t_subcolumns_if
SETTINGS allow_experimental_analyzer = 0, optimize_functions_to_subcolumns = 1;
SELECT
    sum(multiIf(id IS NULL, 1, 0))
FROM t_subcolumns_if
SETTINGS allow_experimental_analyzer = 1, optimize_functions_to_subcolumns = 0;
SELECT
    sum(multiIf(id IS NULL, 1, 0))
FROM t_subcolumns_if
SETTINGS allow_experimental_analyzer = 1, optimize_functions_to_subcolumns = 1;
DROP TABLE IF EXISTS t_subcolumns_if;
