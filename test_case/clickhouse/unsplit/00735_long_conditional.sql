SET send_logs_level = 'fatal';
SELECT 'value vs value';
SELECT toInt8(0) AS x, toInt8(1) AS y, ((x > y) ? x : y) AS z, toTypeName(x), toTypeName(y), toTypeName(z);
SELECT 'column vs value';
