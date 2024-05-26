SELECT age('nanosecond', toDateTime64('2015-08-18 20:30:36.100200005', 9, 'UTC'), toDateTime64('2015-08-18 20:30:41.200400005', 9, 'UTC'));
SELECT DATEDIFF(millisecond, '2021-01-01'::Date, '2021-01-02'::Date);
SELECT toYYYYMMDDhhmmss(toDateTime64('1969-12-31 23:59:59.900', 3));
