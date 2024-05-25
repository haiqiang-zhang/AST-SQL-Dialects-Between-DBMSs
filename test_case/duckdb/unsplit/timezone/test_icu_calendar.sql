SET Calendar = 'gregorian';;
SET TimeZone = 'America/Los_Angeles';;
SET Calendar = 'fnord';;
SET TimeZone = 'Asia/Tokyo';;
CREATE TABLE timestamps AS SELECT ts::TIMESTAMPTZ AS ts, era FROM (VALUES
	('0645-06-30 00:00:00+00', 'Taika'),
	('1867-01-01 00:00:00+00', 'Keiou'),
	('1868-09-07 00:00:00+00', 'Keiou'),
	('1868-09-08 00:00:00+00', 'Meiji'),
	('1912-07-29 00:00:00+00', 'Meiji'),
	('1912-07-30 00:00:00+00', 'Taisho'),
	('1926-12-24 00:00:00+00', 'Taisho'),
	('1926-12-25 00:00:00+00', 'Showa'),
	('1989-01-06 00:00:00+00', 'Showa'),
	('1989-01-08 00:00:00+00', 'Heisei'),
	('2019-05-01 00:00:00+00', 'Reiwa'),
	('2022-01-01 00:00:00+00', 'Reiwa')
) tbl(ts, era);;
SET Calendar = 'japanese';;
SET CALENDAR='islamic-umalqura';;
SELECT strftime(TIMESTAMPTZ '-260722-3-4 0:3:52',TIMESTAMP '-285441-5-3 8:3:4'::VARCHAR);;
SET CALENDAR='indian';;
PRAGMA CALENDAR='japanese';;
SELECT strftime(TIMESTAMPTZ '-23831-1-15 2:5:17 America/La_Paz',TIMETZ '0:8:29 America/Cayman'::VARCHAR);;
SELECT name FROM icu_calendar_names()
GROUP BY 1
ORDER BY 1;;
SELECT * FROM duckdb_settings() WHERE name = 'Calendar';;
SELECT * FROM duckdb_settings() WHERE name = 'Calendar';;
SELECT era, ts, DATE_PART(['era', 'year', 'month', 'day'], ts)
FROM timestamps
ORDER BY 2;
SELECT TIMESTAMPTZ '-276069-9-30 0:0:00 America/Whitehorse';;
