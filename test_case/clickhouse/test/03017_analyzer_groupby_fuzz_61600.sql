SELECT
    38,
    concat(position(concat(concat(position(concat(toUInt256(3)), 'ca', 2), 3),NULLIF(1, materialize(toLowCardinality(1)))), toLowCardinality(toNullable('ca'))), concat(NULLIF(1, 1), concat(3), toNullable(3)))
FROM set_index_not__fuzz_0
GROUP BY
    toNullable(3),
    concat(concat(NULLIF(1, 1), toNullable(toNullable(3))))
SETTINGS allow_experimental_analyzer = 1;
SELECT
    38,
    concat(position(concat(concat(position(concat(toUInt256(3)), 'ca', 2), 3), NULLIF(1, materialize(toLowCardinality(1)))), toLowCardinality(toNullable('ca'))), concat(NULLIF(1, 1), concat(3), toNullable(3)))
FROM set_index_not__fuzz_0
GROUP BY
    toNullable(3),
    concat(concat(NULLIF(1, 1), toNullable(toNullable(3))))
WITH ROLLUP
SETTINGS allow_experimental_analyzer = 1;