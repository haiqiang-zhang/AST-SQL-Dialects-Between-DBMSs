SELECT toString((1, 'Hello', toDate('2016-01-01'))), toString([1, 2, 3]);
SELECT hex(toString(countState())) FROM (SELECT * FROM system.numbers LIMIT 10);
SELECT CAST((1, 'Hello', toDate('2016-01-01')) AS String), CAST([1, 2, 3] AS String);
