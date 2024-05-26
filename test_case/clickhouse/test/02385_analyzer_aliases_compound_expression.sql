SELECT cast(tuple(1, 'Value'), 'Tuple(first UInt64, second String)') AS value, value.first, value.second;
SELECT '--';
WITH (x -> x + 1) AS lambda SELECT lambda(1);
SELECT '--';
SELECT * FROM (SELECT 1) AS t1, t1 AS t2;
SELECT '--';
SELECT * FROM t1 AS t2, (SELECT 1) AS t1;
