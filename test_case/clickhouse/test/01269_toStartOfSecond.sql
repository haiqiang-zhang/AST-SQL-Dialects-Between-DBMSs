WITH toDateTime64('2019-09-16 19:20:11', 3, 'Asia/Istanbul') AS dt64 SELECT toStartOfSecond(dt64, 'UTC') AS res, toTypeName(res);
SELECT 'non-const column';
