SET session_timezone = 'Etc/UTC';
SELECT toDateTime('2017-10-30 08:18:19') + INTERVAL 1 DAY + INTERVAL 1 MONTH - INTERVAL 1 YEAR;
SELECT (toDateTime('2000-01-01 12:00:00') + INTERVAL 1234567 SECOND) x, toTypeName(x);
select toDateTime64('3000-01-01 12:00:00.12345', 0) + interval 0 microsecond;
