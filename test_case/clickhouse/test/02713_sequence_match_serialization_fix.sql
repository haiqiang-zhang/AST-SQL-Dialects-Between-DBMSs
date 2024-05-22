DROP TABLE IF EXISTS 02713_seqt;
DROP TABLE IF EXISTS 02713_seqt_distr;
SELECT
    'serialized state is not used', sequenceMatch('(?1)(?2)')(time, number_ = 1, number_ = 0) AS seq
FROM
(
    SELECT
        number AS time,
        number % 2 AS number_
    FROM numbers_mt(100)
);
CREATE TABLE 02713_seqt
ENGINE = MergeTree
ORDER BY n AS
SELECT
    sequenceMatchState('(?1)(?2)')(time, number_ = 1, number_ = 0) AS seq,
    1 AS n
FROM
(
    SELECT
        number AS time,
        number % 2 AS number_
    FROM numbers_mt(100)
);
SELECT 'serialized state is used', sequenceMatchMerge('(?1)(?2)')(seq) AS seq
FROM 02713_seqt;
