SET Calendar = 'gregorian';
SET TimeZone = 'America/Los_Angeles';
CREATE TABLE attimezone (ts TIMESTAMP, tstz TIMESTAMPTZ, ttz TIMETZ, tz VARCHAR);
INSERT INTO attimezone (VALUES
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40-08', 'America/Phoenix'),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40-05', 'America/Phoenix'),
	('infinity', 'infinity', '19:38:40-08', 'America/Phoenix'),
	('-infinity', '-infinity', '20:38:40-05', 'America/Phoenix'),
	(NULL, NULL, NULL, 'America/Phoenix'),
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40+08', 'Europe/Duck'),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40+15:59', 'Europe/Duck'),
	('infinity', 'infinity', '12:15:37.123456-08', 'Europe/Duck'),
	('-infinity', '-infinity', '20:38:40-15:59', 'Europe/Duck'),
	(NULL, NULL, NULL, 'Europe/Duck'),
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40-08', NULL),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40-05', NULL),
	('infinity', 'infinity', '12:15:37.123456-08', NULL),
	('-infinity', '-infinity', '20:38:40-15:59', NULL),
);
select localtimestamp;
select localtime;
select current_localtimestamp();
select current_localtime();
SET TimeZone = 'Asia/Amman';
SET TimeZone = 'America/Chihuahua';
SET TimeZone = 'America/Ciudad_Juarez';
SET TimeZone = 'Egypt';
SET TimeZone = 'Asia/Beirut';
SET TimeZone = 'America/Nuuk';
SET TimeZone = 'America/Scoresbysund';
SET TimeZone = 'Asia/Almaty';
SELECT * FROM duckdb_settings() WHERE name = 'TimeZone';
SELECT  '2001-02-16 20:38:40'::TIMESTAMP AT TIME ZONE 'America/Denver';
SELECT '2001-02-16 20:38:40-05'::TIMESTAMPTZ AT TIME ZONE 'America/Denver';
SELECT  '2001-02-16 20:38:40'::TIMESTAMP AT TIME ZONE 'Europe/Duck';
SELECT '2001-02-16 20:38:40-05'::TIMESTAMPTZ AT TIME ZONE 'Europe/Duck';
SELECT  NULL::TIMESTAMP AT TIME ZONE 'America/Denver';
SELECT NULL::TIMESTAMPTZ AT TIME ZONE 'America/Denver';
SELECT  '2001-02-16 20:38:40'::TIMESTAMP AT TIME ZONE NULL;
SELECT '2001-02-16 20:38:40-05'::TIMESTAMPTZ AT TIME ZONE NULL;
select '12:15:37.123456-08'::TIMETZ AT TIME ZONE 'America/Phoenix';
select timezone('America/Phoenix', '12:15:37.123456-08'::TIMETZ);
SELECT ts AT TIME ZONE tz, tstz AT TIME ZONE tz, ttz AT TIME ZONE tz
FROM attimezone;
SELECT ts AT TIME ZONE tz, tstz AT TIME ZONE tz, ttz AT TIME ZONE tz
FROM attimezone
WHERE ts > '2001-02-16 18:38:40'::TIMESTAMP;
SELECT name, abbrev FROM pg_timezone_names() ORDER BY name;
SELECT '2022-10-29 00:00:00+00'::TIMESTAMPTZ;
SELECT '2022-11-01 00:00:00+00'::TIMESTAMPTZ;
SELECT '2023-05-01 12:00:00+00'::TIMESTAMPTZ;
SELECT '2023-05-15 12:00:00+00'::TIMESTAMPTZ;
SELECT '2023-03-26 12:00:00+00'::TIMESTAMPTZ, '2023-04-21 12:00:00+00'::TIMESTAMPTZ;
SELECT '2022-10-30 03:00:00-07'::TIMESTAMPTZ, '2023-10-30 02:00:00-07'::TIMESTAMPTZ;
SELECT '2024-03-31 00:59:00-01'::TIMESTAMPTZ, '2024-03-31 01:00:00-01'::TIMESTAMPTZ;
select '2024-02-29 00:00:00+06'::TIMESTAMPTZ, '2024-03-01 01:00:00+06'::TIMESTAMPTZ;
