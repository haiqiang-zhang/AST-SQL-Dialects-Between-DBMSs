SELECT x, y,
    transform(x,
        (select groupArray(x) from (select x, y from updates order by x) t1),
        (select groupArray(y) from (select x, y from updates order by x) t2),
        y)
FROM test_xy
WHERE 1 ORDER BY x, y;
SET mutations_sync = 1;
ALTER table test_xy
    UPDATE
    y =  transform(x,
        (select groupArray(x) from (select x, y from updates order by x) t1),
        (select groupArray(y) from (select x, y from updates order by x) t2),
        y)
    WHERE 1;
SELECT * FROM test_xy ORDER BY x, y;
DROP TABLE test_xy;
DROP TABLE updates;
