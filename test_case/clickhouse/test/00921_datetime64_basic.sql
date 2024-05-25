DROP TABLE IF EXISTS A;
WITH 'UTC' as timezone SELECT timezone, timeZoneOf(now64(3, timezone)) == timezone;
WITH 'Europe/Minsk' as timezone SELECT timezone, timeZoneOf(now64(3, timezone)) == timezone;
SELECT toDateTime64('2019-09-16 19:20:11', 3, 'UTC');
CREATE TABLE A(t DateTime64(3, 'UTC')) ENGINE = MergeTree() ORDER BY t;
INSERT INTO A(t) VALUES ('2019-05-03 11:25:25.123456789');
SELECT toString(t, 'UTC'), toDate(t), toStartOfDay(t), toStartOfQuarter(t), toTime(t), toStartOfMinute(t) FROM A ORDER BY t;
SELECT toDateTime64('2019-09-16 19:20:11.234', 3, 'Europe/Minsk');
DROP TABLE A;
