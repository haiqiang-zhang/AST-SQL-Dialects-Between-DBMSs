WITH
    a as key
SELECT
    a as k1,
    sum(b) as k2
FROM
    test
GROUP BY
    key
ORDER BY k1, k2;
WITH a as key SELECT key as k1 FROM test GROUP BY key ORDER BY key;
WITH a as key SELECT key as k1 FROM test ORDER BY key;
