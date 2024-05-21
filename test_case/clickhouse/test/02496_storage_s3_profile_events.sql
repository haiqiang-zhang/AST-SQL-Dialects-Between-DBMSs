DROP TABLE IF EXISTS t_s3_events_02496;
INSERT INTO t_s3_events_02496 SELECT number FROM numbers(10) SETTINGS s3_truncate_on_insert=1;
SET max_threads = 1;
SYSTEM FLUSH LOGS;
DROP TABLE t_s3_events_02496;