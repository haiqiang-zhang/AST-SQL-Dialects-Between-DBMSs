SET max_rows_to_read = 1;
SELECT count() FROM totimezone_op_mono WHERE toTimeZone(create_time, 'UTC') = '2020-09-01 00:00:00';
DROP TABLE IF EXISTS totimezone_op_mono;
