SELECT toHour(toTimeZone(t, 'UTC')) AS toHour_UTC, toHour(toTimeZone(t, 'Asia/Jerusalem')) AS toHour_Israel, count()
FROM 02680_datetime64_monotonic_check
WHERE toHour_Israel = 0
GROUP BY toHour_UTC, toHour_Israel;
DROP TABLE 02680_datetime64_monotonic_check;
SET allow_suspicious_low_cardinality_types = 1;
CREATE TABLE 02680_datetime_monotonic_check_lc (`timestamp` LowCardinality(UInt32))
ENGINE = MergeTree
ORDER BY timestamp
SETTINGS index_granularity = 1;
INSERT INTO 02680_datetime_monotonic_check_lc VALUES (2);
SELECT toDateTime(timestamp, 'Asia/Jerusalem') FROM 02680_datetime_monotonic_check_lc WHERE toHour(toDateTime(timestamp, 'Asia/Jerusalem')) = 2;
DROP TABLE 02680_datetime_monotonic_check_lc;
