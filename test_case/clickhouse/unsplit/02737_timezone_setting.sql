SELECT timezone(), timezoneOf(now()) SETTINGS session_timezone = 'Pacific/Pitcairn';
SET session_timezone = 'Asia/Novosibirsk';
SELECT timezone(), timezoneOf(now());
SELECT toDateTime(toDateTime('2022-12-12 23:23:23'), 'Europe/Zurich');
SELECT toDateTime64(toDateTime64('2022-12-12 23:23:23.123', 3), 3, 'Europe/Zurich') SETTINGS session_timezone = 'America/Denver';
SELECT toDateTime('2002-12-12 23:23:23') AS dt, toString(dt) SETTINGS session_timezone = 'Asia/Phnom_Penh';
SELECT toDateTime64('2002-12-12 23:23:23.123', 3) AS dt64, toString(dt64) SETTINGS session_timezone = 'Asia/Phnom_Penh';
CREATE TABLE test_tz_setting (d DateTime('UTC')) Engine=Memory AS SELECT toDateTime('2000-01-01 00:00:00');
INSERT INTO test_tz_setting VALUES ('2000-01-01 01:00:00');
INSERT INTO test_tz_setting VALUES (toDateTime('2000-01-02 02:00:00'));
-- Test parsing in WHERE filter, shall have the same logic as insert
SELECT d FROM test_tz_setting WHERE d == '2000-01-01 01:00:00';
SELECT d FROM test_tz_setting WHERE d == toDateTime('2000-01-01 02:00:00');
-- Cleanup table
DROP TABLE test_tz_setting SYNC;
