SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'today';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'yesterday';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow EST';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow zulu';
COMMIT;
DELETE FROM TIMESTAMPTZ_TBL;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
SELECT pg_sleep(0.1);
BEGIN;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
SELECT count(*) AS two FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp(2) with time zone 'now';
SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMPTZ_TBL;
COMMIT;
TRUNCATE TIMESTAMPTZ_TBL;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('-infinity');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('infinity');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('epoch');
SELECT timestamptz 'infinity' = timestamptz '+infinity' AS t;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.000001 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.999999 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.4 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.5 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.6 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-01-02');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-01-02 03:04:05');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01-08');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01-0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01 -08:00');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 -0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-06-10 17:32:01 -07:00');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2001-09-22T18:19:20');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 08:14:01 GMT+8');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 13:14:02 GMT-1');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 12:14:03 GMT-2');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 03:14:04 PST+8');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 02:14:05 MST+7:00');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997 -0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 5:32PM 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997/02/10 17:32:01-0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('02-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 PST');
set datestyle to ymd;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('97FEB10 5:32:01PM UTC');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('97/02/10 17:32:01 UTC');
reset datestyle;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997.041 17:32:01 UTC');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 America/New_York');
SELECT '19970210 173201' AT TIME ZONE 'America/New_York';
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970710 173201 America/New_York');
SELECT '19970710 173201' AT TIME ZONE 'America/New_York';
SELECT '20500710 173201 Europe/Helsinki'::timestamptz;
SELECT '20500110 173201 Europe/Helsinki'::timestamptz;
SELECT pg_input_is_valid('now', 'timestamptz');
SELECT * FROM pg_input_error_info('garbage', 'timestamptz');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-06-10 18:32:01 PDT');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 11 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 12 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 13 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 14 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 15 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0097 BC');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0597');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1697');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1797');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1897');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 2097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 28 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 29 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mar 01 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 30 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 28 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mar 01 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 30 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1999');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 2000');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 2000');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 2001');
SELECT 'Wed Jul 11 10:51:14 America/New_York 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 GMT-4 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 GMT+4 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 PST-03:00 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 PST+03:00 2001'::timestamptz;
SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 > timestamp with time zone '1997-01-02';
SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 = timestamp with time zone '1997-01-02';
SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 >= timestamp with time zone '1997-01-02';
SELECT d1 - timestamp with time zone '1997-01-02' AS diff
   FROM TIMESTAMPTZ_TBL WHERE d1 BETWEEN '1902-01-01' AND '2038-01-01';
SELECT date_trunc( 'week', timestamp with time zone '2004-02-29 15:44:17.71393' ) AS week_trunc;
SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'Australia/Sydney') as sydney_trunc;
SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'GMT') as gmt_trunc;
SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'VET') as vet_trunc;
SELECT
  str,
  interval,
  date_trunc(str, ts, 'Australia/Sydney') = date_bin(interval::interval, ts, timestamp with time zone '2001-01-01+11') AS equal
FROM (
  VALUES
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamptz '2020-02-29 15:44:17.71393+00')) ts (ts);
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
(VALUES (timestamptz '2020-02-11 15:44:17.71393')) ts (ts),
(VALUES (timestamptz '2001-01-01')) origin (origin);
SELECT date_bin('5 min'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2020-02-01 00:02:30+00');
SELECT d1 - timestamp with time zone '1997-01-02' AS diff
  FROM TIMESTAMPTZ_TBL
  WHERE d1 BETWEEN timestamp with time zone '1902-01-01' AND timestamp with time zone '2038-01-01';
SELECT date_part('epoch', '294270-01-01 00:00:00+00'::timestamptz);
SELECT extract(epoch from '294270-01-01 00:00:00+00'::timestamptz);
SELECT timestamptz '294276-12-31 23:59:59 UTC' - timestamptz '1999-12-23 19:59:04.224193 UTC' AS ok;
SELECT to_char(d1, 'DAY Day day DY Dy dy MONTH Month month RM MON Mon mon')
   FROM TIMESTAMPTZ_TBL;
SELECT to_char(d, 'FF1 FF2 FF3 FF4 FF5 FF6  ff1 ff2 ff3 ff4 ff5 ff6  MS US')
   FROM (VALUES
       ('2018-11-02 12:34:56'::timestamptz),
       ('2018-11-02 12:34:56.78'),
       ('2018-11-02 12:34:56.78901'),
       ('2018-11-02 12:34:56.78901234')
   ) d(d);
SET timezone = '00:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '+02:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-13:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-00:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '00:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-04:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '04:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-04:15';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '04:15';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
RESET timezone;
SET timezone = '00:00';
SELECT to_char(now(), 'of') as "Of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '+02:00';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-13:00';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-00:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '00:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-04:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '04:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-04:15';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '04:15';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
RESET timezone;
CREATE TABLE TIMESTAMPTZ_TST (a int , b timestamptz);
INSERT INTO TIMESTAMPTZ_TST VALUES(1, 'Sat Mar 12 23:58:48 1000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(2, 'Sat Mar 12 23:58:48 10000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(3, 'Sat Mar 12 23:58:48 100000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(3, '10000 Mar 12 23:58:48 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(4, '100000312 23:58:48 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(4, '1000000312 23:58:48 IST');
DROP TABLE TIMESTAMPTZ_TST;
set TimeZone to 'America/New_York';
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33);
WITH tzs (tz) AS (VALUES
    ('+1'), ('+1:'), ('+1:0'), ('+100'), ('+1:00'), ('+01:00'),
    ('+10'), ('+1000'), ('+10:'), ('+10:0'), ('+10:00'), ('+10:00:'),
    ('+10:00:1'), ('+10:00:01'),
    ('+10:00:10'))
     SELECT make_timestamptz(2010, 2, 27, 3, 45, 00, tz), tz FROM tzs;
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '+2') = '1973-07-15 08:15:55.33+02'::timestamptz;
SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') = timestamptz '2014-12-10 00:00:00 Europe/Prague';
RESET TimeZone;
select * from generate_series('2020-01-01 00:00'::timestamptz,
                              '2020-01-02 03:00'::timestamptz,
                              '1 hour'::interval);
SET TimeZone to 'UTC';
SELECT date_add('2022-10-30 00:00:00+01'::timestamptz,
                '1 day'::interval);
SELECT date_subtract('2022-10-30 00:00:00+01'::timestamptz,
                     '1 day'::interval);
RESET TimeZone;
SET TimeZone to 'UTC';
SELECT '2011-03-27 00:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 01:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 01:59:59 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:00:01 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:59:59 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 03:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 03:00:01 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 04:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 00:00:00 MSK'::timestamptz;
SELECT '2011-03-27 01:00:00 MSK'::timestamptz;
SELECT '2011-03-27 01:59:59 MSK'::timestamptz;
SELECT '2011-03-27 02:00:00 MSK'::timestamptz;
SELECT '2011-03-27 02:00:01 MSK'::timestamptz;
SELECT '2011-03-27 02:59:59 MSK'::timestamptz;
SELECT '2011-03-27 03:00:00 MSK'::timestamptz;
SELECT '2011-03-27 03:00:01 MSK'::timestamptz;
SELECT '2011-03-27 04:00:00 MSK'::timestamptz;
SELECT '2014-10-26 00:00:00 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 00:59:59 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 01:00:00 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 01:00:01 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 02:00:00 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 00:00:00 MSK'::timestamptz;
SELECT '2014-10-26 00:59:59 MSK'::timestamptz;
SELECT '2014-10-26 01:00:00 MSK'::timestamptz;
SELECT '2014-10-26 01:00:01 MSK'::timestamptz;
SELECT '2014-10-26 02:00:00 MSK'::timestamptz;
SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT to_timestamp(         0);
SET TimeZone to 'Europe/Moscow';
SELECT '2011-03-26 21:00:00 UTC'::timestamptz;
SELECT '2011-03-26 22:00:00 UTC'::timestamptz;
SELECT '2011-03-26 22:59:59 UTC'::timestamptz;
SELECT '2011-03-26 23:00:00 UTC'::timestamptz;
SELECT '2011-03-26 23:00:01 UTC'::timestamptz;
SELECT '2011-03-26 23:59:59 UTC'::timestamptz;
SELECT '2011-03-27 00:00:00 UTC'::timestamptz;
SELECT '2014-10-25 21:00:00 UTC'::timestamptz;
SELECT '2014-10-25 21:59:59 UTC'::timestamptz;
SELECT '2014-10-25 22:00:00 UTC'::timestamptz;
SELECT '2014-10-25 22:00:01 UTC'::timestamptz;
SELECT '2014-10-25 23:00:00 UTC'::timestamptz;
RESET TimeZone;
SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
BEGIN;
SET LOCAL TIME ZONE 'Europe/Paris';
COMMIT;
create temp table tmptz (f1 timestamptz primary key);
insert into tmptz values ('2017-01-18 00:00+00');
explain (costs off)
select * from tmptz where f1 at time zone 'utc' = '2017-01-18 00:00';
select * from tmptz where f1 at time zone 'utc' = '2017-01-18 00:00';
SELECT age(timestamptz 'infinity');
