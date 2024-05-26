SELECT 'ignore';
SET date_time_overflow_behavior = 'ignore';
SELECT toDateTime(toDateTime64('1900-01-01 00:00:00.123', 3));
SELECT toDate(toDateTime64('1900-01-01 00:00:00.123', 3));
SELECT 'No output on `throw`';
SET date_time_overflow_behavior = 'throw';
SELECT 'saturate';
SET date_time_overflow_behavior = 'saturate';
