SELECT countIf(sym = 'Red') OVER () AS res
FROM
(
    SELECT CAST(CAST(number % 5, 'Enum8(\'Red\' = 0, \'Blue\' = 1, \'Yellow\' = 2, \'Black\' = 3, \'White\' = 4)'), 'LowCardinality(String)') AS sym
    FROM numbers(10)
);
SELECT materialize(toLowCardinality('a\0aa')), countIf(toLowCardinality('aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0aaaaaaa\0'), sym = 'Red') OVER (Range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS res FROM (SELECT CAST(CAST(number % 5, 'Enum8(\'Red\' = 0, \'Blue\' = 1, \'Yellow\' = 2, \'Black\' = 3, \'White\' = 4)'), 'LowCardinality(String)') AS sym FROM numbers(3));