SELECT x, s FROM (
        SELECT 5 AS x, 'Hello' AS s ORDER BY x WITH FILL FROM 1 TO 10 INTERPOLATE (s AS s||'A')
) ORDER BY s;