SET allow_experimental_analyzer=1;
SELECT *
FROM
(
    SELECT
        [1, 2, 3] AS x,
        [4, 5, 6] AS y
)
ARRAY JOIN
    x,
    Y;