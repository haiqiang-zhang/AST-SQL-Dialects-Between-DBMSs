SELECT
        (SELECT max(i) FROM t1) as i,
        (SELECT max(i) FROM t1) as j,
        (SELECT max(i) FROM t1) as k,
        (SELECT max(i) FROM t1) as l
FROM t1;
SELECT 1;
WITH (
        SELECT max(i)
        FROM t1
    ) AS value
SELECT
    value AS i,
    value AS j,
    value AS k,
    value AS l
FROM t1;
