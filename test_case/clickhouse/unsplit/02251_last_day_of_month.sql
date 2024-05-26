WITH
    toDate('2021-09-12') AS date_value,
    toDateTime('2021-09-12 11:22:33') AS date_time_value,
    toDateTime64('2021-09-12 11:22:33', 3) AS date_time_64_value
SELECT toLastDayOfMonth(date_value), toLastDayOfMonth(date_time_value), toLastDayOfMonth(date_time_64_value);
WITH
    toDate('2020-12-12') AS date_value
SELECT last_day(date_value), LAST_DAY(date_value);
