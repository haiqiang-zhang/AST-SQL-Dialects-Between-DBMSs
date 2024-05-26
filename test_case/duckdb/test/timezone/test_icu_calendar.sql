SELECT strftime(TIMESTAMPTZ '-260722-3-4 0:3:52',TIMESTAMP '-285441-5-3 8:3:4'::VARCHAR);
SET CALENDAR='indian';
PRAGMA CALENDAR='japanese';
SELECT name FROM icu_calendar_names()
GROUP BY 1
ORDER BY 1;
SELECT * FROM duckdb_settings() WHERE name = 'Calendar';
SELECT * FROM duckdb_settings() WHERE name = 'Calendar';
SELECT era, ts, DATE_PART(['era', 'year', 'month', 'day'], ts)
FROM timestamps
ORDER BY 2;
SELECT TIMESTAMPTZ '-276069-9-30 0:0:00 America/Whitehorse';
