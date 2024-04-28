SET Calendar = 'gregorian';;
SET TimeZone = 'America/Los_Angeles';;
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1992-12-31 12:00:00-08', INTERVAL '0 MONTH') tbl(d);
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1992-12-31 12:00:00-08', INTERVAL '1 MONTH ago') tbl(d);
SELECT d FROM range(TIMESTAMPTZ '1993-01-01 00:00:00-08', TIMESTAMPTZ '1992-01-01 00:00:00-08', INTERVAL '1 MONTH') tbl(d);
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1992-12-31 12:00:00-08', INTERVAL '1 MONTH' - INTERVAL '1 HOUR') tbl(d);
SELECT COUNT(*) FROM generate_series('294247-01-09'::TIMESTAMPTZ, 'infinity'::TIMESTAMPTZ, INTERVAL '1 DAY');;
SELECT COUNT(*) FROM range('294247-01-09'::TIMESTAMPTZ, 'infinity'::TIMESTAMPTZ, INTERVAL '1 DAY');;
SELECT COUNT(*) FROM generate_series('-infinity'::TIMESTAMPTZ, '290303-12-11 (BC) 00:00:00'::TIMESTAMPTZ, INTERVAL '1 DAY');;
SELECT COUNT(*) FROM range('-infinity'::TIMESTAMPTZ, '290303-12-11 (BC) 00:00:00'::TIMESTAMPTZ, INTERVAL '1 DAY');;
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1992-01-01 12:00:00-08', INTERVAL (1) HOUR) tbl(d);
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ'1991-06-01 00:00:00-07', INTERVAL '1 MONTH ago') tbl(d);
SELECT d FROM generate_series(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1991-06-01 00:00:00-07', -INTERVAL '1 MONTH') tbl(d);
SELECT d FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '1992-12-31 12:00:00-08', INTERVAL '1 MONTH 1 DAY 1 HOUR') tbl(d);
SELECT d FROM generate_series(TIMESTAMPTZ '1992-04-05 00:00:00-08', TIMESTAMPTZ '1992-04-05 12:00:00-07', INTERVAL '1 HOUR') tbl(d);
SELECT d FROM generate_series(TIMESTAMPTZ '1992-10-25 00:00:00-07', TIMESTAMPTZ '1992-10-25 12:00:00-08', INTERVAL '1 HOUR') tbl(d);
SELECT COUNT(*) FROM range(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '2020-01-01 00:00:00-08', INTERVAL '1 DAY') tbl(d);
SELECT COUNT(*) FROM generate_series(TIMESTAMPTZ '1992-01-01 00:00:00-08', TIMESTAMPTZ '2020-01-01 00:00:00-08', INTERVAL '1 DAY') tbl(d);