WITH filtered_groups AS (SELECT a FROM pr_1 WHERE a >= 10000)
SELECT count() FROM pr_2 INNER JOIN filtered_groups ON pr_2.a = filtered_groups.a;
CREATE TABLE numbers_1e6
(
    `n` UInt64
)
ENGINE = MergeTree
ORDER BY n
AS SELECT * FROM numbers(1_000_000);
DROP TABLE IF EXISTS numbers_1e6;
DROP TABLE IF EXISTS pr_1;
DROP TABLE IF EXISTS pr_2;
