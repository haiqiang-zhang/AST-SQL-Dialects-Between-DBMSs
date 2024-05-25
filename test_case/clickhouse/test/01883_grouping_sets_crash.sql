SELECT
    fact_3_id,
    fact_4_id
FROM grouping_sets
GROUP BY
    GROUPING SETS (
        ('wo\0ldworldwo\0ldworld'),
        (fact_3_id, fact_4_id))
ORDER BY
    fact_3_id, fact_4_id;
SELECT 'SECOND QUERY:';
SELECT
    fact_3_id,
    fact_4_id
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    (fact_1_id, fact_2_id),
    ((-9223372036854775808, NULL, (tuple(1.), (tuple(1.), 1048576), 65535))),
    ((tuple(3.4028234663852886e38), (tuple(1024), -2147483647), NULL)),
    (fact_3_id, fact_4_id))
ORDER BY
    (NULL, ('256', (tuple(NULL), NULL), NULL, NULL), NULL) ASC,
    fact_1_id DESC NULLS FIRST,
    fact_2_id DESC NULLS FIRST,
    fact_4_id ASC;
SELECT 'THIRD QUERY:';
SELECT
    extractAllGroups(NULL, 'worldworldworldwo\0ldworldworldworldwo\0ld'),
    fact_2_id,
    fact_3_id,
    fact_4_id
FROM grouping_sets
GROUP BY
    GROUPING SETS (
        (sales_value),
        (fact_1_id, fact_2_id),
        ('wo\0ldworldwo\0ldworld'),
        (fact_3_id, fact_4_id))
ORDER BY
    fact_1_id DESC NULLS LAST,
    fact_1_id DESC NULLS FIRST,
    fact_2_id ASC,
    fact_3_id DESC NULLS FIRST,
    fact_4_id ASC;
SELECT fact_3_id
FROM grouping_sets
GROUP BY
    GROUPING SETS ((fact_3_id, fact_4_id))
ORDER BY fact_3_id ASC;
SELECT 'w\0\0ldworldwo\0l\0world'
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    ( fact_4_id),
    ( NULL),
    ( fact_3_id, fact_4_id))
ORDER BY
    NULL ASC,
    NULL DESC NULLS FIRST,
    fact_3_id ASC,
    fact_3_id ASC NULLS LAST,
    'wo\0ldworldwo\0ldworld' ASC NULLS LAST,
    'w\0\0ldworldwo\0l\0world' DESC NULLS FIRST,
    'wo\0ldworldwo\0ldworld' ASC,
    NULL ASC NULLS FIRST,
    fact_4_id DESC NULLS LAST;
SELECT fact_3_id
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    ( 'wo\0ldworldwo\0ldworldwo\0ldworldwo\0ldworldwo\0ldworldwo\0ldworldwo\0ldworldwo\0ldworld'),
    ( NULL),
    ( fact_4_id),
    ( fact_3_id, fact_4_id))
ORDER BY fact_3_id ASC NULLS FIRST;
SELECT fact_3_id, fact_4_id, count()
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    ( fact_3_id, fact_4_id))
ORDER BY fact_3_id, fact_4_id
SETTINGS optimize_aggregation_in_order=1;
SELECT fact_3_id, fact_4_id, count()
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    fact_3_id,
    fact_4_id)
ORDER BY fact_3_id, fact_4_id
SETTINGS optimize_aggregation_in_order=1;
SELECT fact_3_id, fact_4_id, count()
FROM grouping_sets
GROUP BY
    GROUPING SETS (
    ( fact_3_id ),
    ( fact_3_id, fact_4_id))
ORDER BY fact_3_id, fact_4_id
SETTINGS optimize_aggregation_in_order=1;
DROP TABLE IF EXISTS grouping_sets;
