SELECT toDateTime('2017-01-01 00:00:00') + INTERVAL 0 MONTH AS x;
SELECT toDate('2017-01-01') + INTERVAL 0 MONTH AS x;
SELECT INTERVAL number - 15 MONTH + toDate('2017-01-01') AS x FROM system.numbers LIMIT 30;
SELECT INTERVAL number - 15 YEAR + toDate('2017-01-01') AS x FROM system.numbers LIMIT 30;
SELECT toDate32('2217-01-01') + INTERVAL number * 20 - 100 DAY AS x FROM system.numbers LIMIT 10;
SELECT INTERVAL 100 - number * 20 DAY + toDate32('2217-01-01') AS x FROM system.numbers LIMIT 10;
SELECT INTERVAL number * 4 - 20 MONTH + toDate32('2217-01-01') AS x FROM system.numbers LIMIT 10;
SELECT INTERVAL number * 4 - 20 YEAR + toDate32('2217-01-01') AS x FROM system.numbers LIMIT 10;
