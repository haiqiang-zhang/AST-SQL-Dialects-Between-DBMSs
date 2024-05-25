SELECT * FROM tokenbf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id;
SELECT * FROM ngrambf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id;
-- Required string: 'Hello '
-- Alternatives: 'Hello ClickHouse', 'Hello World'

SELECT *
FROM
(
    EXPLAIN PLAN indexes=1
    SELECT * FROM tokenbf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes=1
    SELECT * FROM tokenbf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
SELECT *
FROM
(
    EXPLAIN PLAN indexes=1
    SELECT * FROM ngrambf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes=1
    SELECT * FROM ngrambf_tab WHERE match(str, 'Hello (ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
SELECT '---';
SELECT * FROM tokenbf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id;
SELECT * FROM ngrambf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id;
-- Required string: -
-- Alternatives: 'ClickHouse', 'World'

SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM tokenbf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM tokenbf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM ngrambf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM ngrambf_tab WHERE match(str, '.*(ClickHouse|World)') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
SELECT '---';
SELECT * FROM tokenbf_tab WHERE match(str, 'OLAP.*') ORDER BY id;
SELECT * FROM ngrambf_tab WHERE match(str, 'OLAP.*') ORDER BY id;
-- Required string: 'OLAP'
-- Alternatives: -

SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM tokenbf_tab WHERE match(str, 'OLAP (.*?)*') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM tokenbf_tab WHERE match(str, 'OLAP (.*?)*') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM ngrambf_tab WHERE match(str, 'OLAP (.*?)*') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 0;
SELECT *
FROM
(
    EXPLAIN PLAN indexes = 1
    SELECT * FROM ngrambf_tab WHERE match(str, 'OLAP (.*?)*') ORDER BY id
)
WHERE
    explain LIKE '%Granules: %'
SETTINGS
  allow_experimental_analyzer = 1;
DROP TABLE tokenbf_tab;
DROP TABLE ngrambf_tab;
