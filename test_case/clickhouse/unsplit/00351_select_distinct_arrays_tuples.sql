SELECT DISTINCT number % 3, number % 5, (number % 3, number % 5), [number % 3, number % 5] FROM (SELECT * FROM system.numbers LIMIT 100);
SELECT count(), count(DISTINCT x, y) FROM (SELECT DISTINCT * FROM (SELECT 'a\0b' AS x, 'c' AS y UNION ALL SELECT 'a', 'b\0c'));
