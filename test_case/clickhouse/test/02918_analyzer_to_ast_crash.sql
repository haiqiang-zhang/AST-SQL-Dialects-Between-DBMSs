WITH
    x AS (SELECT in((SELECT * FROM y))),
    y AS (SELECT 1)
SELECT * FROM x;