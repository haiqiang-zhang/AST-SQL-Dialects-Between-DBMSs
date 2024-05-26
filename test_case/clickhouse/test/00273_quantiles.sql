SELECT quantiles(0.5)(x) FROM (SELECT number AS x FROM system.numbers LIMIT 1001);
SELECT quantilesExact(0.5)(x) FROM (SELECT number AS x FROM system.numbers LIMIT 1001);
SELECT quantilesTDigest(0.5)(x) FROM (SELECT number AS x FROM system.numbers LIMIT 1001);
SELECT quantilesDeterministic(0.5)(x, x) FROM (SELECT number AS x FROM system.numbers LIMIT 1001);
SELECT arrayMap(a -> round(a, 2), quantilesDD(0.01, 0.5)(x)) FROM (SELECT number AS x FROM system.numbers LIMIT 1001);
SET max_bytes_before_external_group_by = 0;
SELECT round(1000000 / (number + 1)) AS k, count() AS c, arrayMap(x -> round(x, 6), quantilesDeterministic(0.1, 0.5, 0.9)(number, intHash64(number))) AS q1, quantilesExact(0.1, 0.5, 0.9)(number) AS q2 FROM (SELECT number FROM system.numbers LIMIT 1000000) GROUP BY k ORDER BY k;
