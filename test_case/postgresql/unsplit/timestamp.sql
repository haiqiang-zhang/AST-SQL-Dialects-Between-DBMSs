CREATE TABLE TIMESTAMP_TBL (d1 timestamp(2) without time zone);
BEGIN;
INSERT INTO TIMESTAMP_TBL VALUES ('today');
INSERT INTO TIMESTAMP_TBL VALUES ('yesterday');
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow');
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow EST');
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow zulu');
SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'today';
SELECT count(*) AS Three FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'tomorrow';
SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'yesterday';
COMMIT;
DELETE FROM TIMESTAMP_TBL;
INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);
BEGIN;
INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);
INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);
SELECT count(*) AS two FROM TIMESTAMP_TBL WHERE d1 = timestamp(2) without time zone 'now';
SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMP_TBL;
COMMIT;
TRUNCATE TIMESTAMP_TBL;
INSERT INTO TIMESTAMP_TBL VALUES ('-infinity');
INSERT INTO TIMESTAMP_TBL VALUES ('infinity');
INSERT INTO TIMESTAMP_TBL VALUES ('epoch');
SELECT timestamp 'infinity' = timestamp '+infinity' AS t;
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.000001 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.999999 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.4 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.5 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.6 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-01-02');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-01-02 03:04:05');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01-08');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01-0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01 -08:00');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 -0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-06-10 17:32:01 -07:00');
INSERT INTO TIMESTAMP_TBL VALUES ('2001-09-22T18:19:20');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 08:14:01 GMT+8');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 13:14:02 GMT-1');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 12:14:03 GMT-2');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 03:14:04 PST+8');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 02:14:05 MST+7:00');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997 -0800');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 5:32PM 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('1997/02/10 17:32:01-0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('02-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 PST');
set datestyle to ymd;
INSERT INTO TIMESTAMP_TBL VALUES ('97FEB10 5:32:01PM UTC');
INSERT INTO TIMESTAMP_TBL VALUES ('97/02/10 17:32:01 UTC');
reset datestyle;
INSERT INTO TIMESTAMP_TBL VALUES ('1997.041 17:32:01 UTC');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 America/New_York');
SELECT pg_input_is_valid('now', 'timestamp');
SELECT pg_input_is_valid('garbage', 'timestamp');
SELECT pg_input_is_valid('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamp');
SELECT * FROM pg_input_error_info('garbage', 'timestamp');
SELECT * FROM pg_input_error_info('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamp');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-06-10 18:32:01 PDT');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 11 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 12 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 13 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 14 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 15 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0097 BC');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0597');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1697');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1797');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1897');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 2097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 28 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 29 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Mar 01 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 30 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 28 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Mar 01 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 30 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1999');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 2000');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 2000');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 2001');
SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 > timestamp without time zone '1997-01-02';
SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 = timestamp without time zone '1997-01-02';
SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 >= timestamp without time zone '1997-01-02';
SELECT d1 - timestamp without time zone '1997-01-02' AS diff
   FROM TIMESTAMP_TBL WHERE d1 BETWEEN '1902-01-01' AND '2038-01-01';
SELECT date_trunc( 'week', timestamp '2004-02-29 15:44:17.71393' ) AS week_trunc;
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2001-01-01') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '2020-02-29 15:44:17.71393')) ts (ts);
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2000-01-01 BC') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '0055-6-10 15:44:17.71393 BC')) ts (ts);
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2020-03-02') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '2020-02-29 15:44:17.71393')) ts (ts);
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '0055-06-17 BC') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '0055-6-10 15:44:17.71393 BC')) ts (ts);
SELECT
  interval,
  ts,
  origin,
  date_bin(interval::interval, ts, origin)
FROM (
  VALUES
  ('15 days'),
  ('2 hours'),
  ('1 hour 30 minutes'),
  ('15 minutes'),
  ('10 seconds'),
  ('100 milliseconds'),
  ('250 microseconds')
) intervals (interval),
(VALUES (timestamp '2020-02-11 15:44:17.71393')) ts (ts),
(VALUES (timestamp '2001-01-01')) origin (origin);
SELECT date_bin('5 min'::interval, timestamp '2020-02-01 01:01:01', timestamp '2020-02-01 00:02:30');
SELECT date_bin('30 minutes'::interval, timestamp '2024-02-01 15:00:00', timestamp '2024-02-01 17:00:00');
SELECT d1 - timestamp without time zone '1997-01-02' AS diff
  FROM TIMESTAMP_TBL
  WHERE d1 BETWEEN timestamp without time zone '1902-01-01'
   AND timestamp without time zone '2038-01-01';
SELECT date_part('epoch', '294270-01-01 00:00:00'::timestamp);
SELECT extract(epoch from '294270-01-01 00:00:00'::timestamp);
SELECT extract(epoch from '5000-01-01 00:00:00'::timestamp);
SELECT timestamp '294276-12-31 23:59:59' - timestamp '1999-12-23 19:59:04.224193' AS ok;
SELECT to_char(d1, 'DAY Day day DY Dy dy MONTH Month month RM MON Mon mon')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'FMDAY FMDay FMday FMMONTH FMMonth FMmonth FMRM')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'Y,YYY YYYY YYY YY Y CC Q MM WW DDD DD D J')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'FMY,YYY FMYYYY FMYYY FMYY FMY FMCC FMQ FMMM FMWW FMDDD FMDD FMD FMJ')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'HH HH12 HH24 MI SS SSSS')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, E'"HH:MI:SS is" HH:MI:SS "\\"text between quote marks\\""')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'YYYYTH YYYYth Jth')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'YYYY A.D. YYYY a.d. YYYY bc HH:MI:SS P.M. HH:MI:SS p.m. HH:MI:SS pm')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'IYYY IYY IY I IW IDDD ID')
   FROM TIMESTAMP_TBL;
SELECT to_char(d1, 'FMIYYY FMIYY FMIY FMI FMIW FMIDDD FMID')
   FROM TIMESTAMP_TBL;
SELECT to_char(d, 'FF1 FF2 FF3 FF4 FF5 FF6  ff1 ff2 ff3 ff4 ff5 ff6  MS US')
   FROM (VALUES
       ('2018-11-02 12:34:56'::timestamp),
       ('2018-11-02 12:34:56.78'),
       ('2018-11-02 12:34:56.78901'),
       ('2018-11-02 12:34:56.78901234')
   ) d(d);
SELECT i,
       to_char(i * interval '1mon', 'rm'),
       to_char(i * interval '1mon', 'RM')
    FROM generate_series(-13, 13) i;
SELECT make_timestamp(2014, 12, 28, 6, 30, 45.887);
select * from generate_series('2020-01-01 00:00'::timestamp,
                              '2020-01-02 03:00'::timestamp,
                              '1 hour'::interval);
select generate_series('2022-01-01 00:00'::timestamp,
                       'infinity'::timestamp,
                       '1 month'::interval) limit 10;
select age(timestamp 'infinity');
select age(timestamp 'infinity', timestamp 'infinity');