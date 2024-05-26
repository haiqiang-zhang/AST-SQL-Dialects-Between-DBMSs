SET DATESTYLE = 'ISO';
SET IntervalStyle to postgres;
SELECT INTERVAL '01:00' AS "One hour";
SELECT INTERVAL '+02:00' AS "Two hours";
SELECT INTERVAL '-08:00' AS "Eight hours";
SELECT INTERVAL '-1 +02:03' AS "22 hours ago...";
SELECT INTERVAL '-1 days +02:03' AS "22 hours ago...";
SELECT INTERVAL '1.5 weeks' AS "Ten days twelve hours";
SELECT INTERVAL '1.5 months' AS "One month 15 days";
SELECT INTERVAL '10 years -11 month -12 days +13:14' AS "9 years...";
CREATE TABLE INTERVAL_TBL (f1 interval);
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 1 minute');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 5 hour');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 10 day');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 34 year');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 3 months');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 14 seconds ago');
INSERT INTO INTERVAL_TBL (f1) VALUES ('1 day 2 hours 3 minutes 4 seconds');
INSERT INTO INTERVAL_TBL (f1) VALUES ('6 years');
INSERT INTO INTERVAL_TBL (f1) VALUES ('5 months');
INSERT INTO INTERVAL_TBL (f1) VALUES ('5 months 12 hours');
SELECT pg_input_is_valid('1.5 weeks', 'interval');
SELECT * FROM pg_input_error_info('garbage', 'interval');
SELECT * FROM INTERVAL_TBL;
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <> interval '@ 10 days';
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <= interval '@ 5 hours';
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 < interval '@ 1 day';
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 = interval '@ 34 years';
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 >= interval '@ 1 month';
SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 > interval '@ 3 seconds ago';
SELECT r1.*, r2.*
   FROM INTERVAL_TBL r1, INTERVAL_TBL r2
   WHERE r1.f1 > r2.f1
   ORDER BY r1.f1, r2.f1;
SELECT f1, -f1 FROM INTERVAL_TBL;
CREATE TEMP TABLE INTERVAL_TBL_OF (f1 interval);
INSERT INTO INTERVAL_TBL_OF (f1) VALUES
  ('2147483647 days 2147483647 months'),
  ('2147483647 days -2147483648 months'),
  ('1 year'),
  ('-2147483648 days 2147483647 months'),
  ('-2147483648 days -2147483648 months');
CREATE INDEX ON INTERVAL_TBL_OF USING btree (f1);
SET enable_seqscan TO false;
EXPLAIN (COSTS OFF)
SELECT f1 FROM INTERVAL_TBL_OF r1 ORDER BY f1;
RESET enable_seqscan;
SELECT f1 - f1 FROM INTERVAL_TBL_OF;
DROP TABLE INTERVAL_TBL_OF;
CREATE TABLE INTERVAL_MULDIV_TBL (span interval);
SELECT span * 8.2 AS product
FROM INTERVAL_MULDIV_TBL;
SELECT span / 10 AS quotient
FROM INTERVAL_MULDIV_TBL;
SELECT span / 100 AS quotient
FROM INTERVAL_MULDIV_TBL;
DROP TABLE INTERVAL_MULDIV_TBL;
SET DATESTYLE = 'postgres';
SET IntervalStyle to postgres_verbose;
select avg(f1) from interval_tbl where isfinite(f1);
select '4 millenniums 5 centuries 4 decades 1 year 4 months 4 days 17 minutes 31 seconds'::interval;
SELECT justify_hours(interval '6 months 3 days 52 hours 3 minutes 2 seconds') as "6 mons 5 days 4 hours 3 mins 2 seconds";
SELECT justify_days(interval '6 months 36 days 5 hours 4 minutes 3 seconds') as "7 mons 6 days 5 hours 4 mins 3 seconds";
SELECT justify_interval(interval '1 month -1 hour') as "1 month -1 hour";
SET DATESTYLE = 'ISO';
SET IntervalStyle TO postgres;
SELECT '1 millisecond'::interval, '1 microsecond'::interval,
       '500 seconds 99 milliseconds 51 microseconds'::interval;
SELECT '3 days 5 milliseconds'::interval;
SELECT interval '1-2';
SELECT interval '999' second;
SELECT interval '999' minute;
SELECT interval '999' hour;
SELECT interval '999' day;
SELECT interval '999' month;
SELECT interval '1' year;
SELECT interval '2' month;
SELECT interval '3' day;
SELECT interval '4' hour;
SELECT interval '5' minute;
SELECT interval '6' second;
SELECT interval '1' year to month;
SELECT interval '1-2' year to month;
SELECT interval '1 2' day to hour;
SELECT interval '1 2:03' day to hour;
SELECT interval '1 2:03:04' day to hour;
SELECT interval '1 2:03' day to minute;
SELECT interval '1 2:03:04' day to minute;
SELECT interval '1 2:03' day to second;
SELECT interval '1 2:03:04' day to second;
SELECT interval '1 2:03' hour to minute;
SELECT interval '1 2:03:04' hour to minute;
SELECT interval '1 2:03' hour to second;
SELECT interval '1 2:03:04' hour to second;
SELECT interval '1 2:03' minute to second;
SELECT interval '1 2:03:04' minute to second;
SELECT interval '1 +2:03' minute to second;
SELECT interval '1 +2:03:04' minute to second;
SELECT interval '1 -2:03' minute to second;
SELECT interval '1 -2:03:04' minute to second;
SELECT interval '123 11' day to hour;
SELECT interval(0) '1 day 01:23:45.6789';
SELECT interval '12:34.5678' minute to second(2);
SELECT interval '1.234' second;
SELECT f1, f1::INTERVAL DAY TO MINUTE AS "minutes",
  (f1 + INTERVAL '1 month')::INTERVAL MONTH::INTERVAL YEAR AS "years"
  FROM interval_tbl;
SET IntervalStyle TO sql_standard;
SET IntervalStyle TO postgres;
SELECT  interval '+1 -1:00:00',
        interval '-1 +1:00:00',
        interval '+1-2 -3 +4:05:06.789',
        interval '-1-2 +3 -4:05:06.789';
SELECT  interval '-23 hours 45 min 12.34 sec',
        interval '-1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min +12.34 sec';
SET IntervalStyle TO sql_standard;
SELECT  interval '1 day -1 hours',
        interval '-1 days +1 hours',
        interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds',
        - interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds';
SELECT  interval '-23 hours 45 min 12.34 sec',
        interval '-1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min +12.34 sec';
SET IntervalStyle to iso_8601;
SET IntervalStyle to sql_standard;
SET IntervalStyle to postgres;
select  interval 'P00021015T103020'       AS "ISO8601 Basic Format",
        interval 'P0002-10-15T10:30:20'   AS "ISO8601 Extended Format";
select  interval 'P0002'                  AS "year only",
        interval 'P0002-10'               AS "year month",
        interval 'P0002-10-15'            AS "year month day",
        interval 'P0002T1S'               AS "year only plus time",
        interval 'P0002-10T1S'            AS "year month plus time",
        interval 'P0002-10-15T1S'         AS "year month day plus time",
        interval 'PT10'                   AS "hour only",
        interval 'PT10:30'                AS "hour minute";
select interval 'P1Y0M3DT4H5M6S';
select interval 'P1.0Y0M3DT4H5M6S';
select interval 'P1.1Y0M3DT4H5M6S';
select interval 'P1.Y0M3DT4H5M6S';
select interval 'P.1Y0M3DT4H5M6S';
select interval 'P10.5e4Y';
SET IntervalStyle to postgres_verbose;
select interval '-10 mons -3 days +03:55:06.70';
select interval '1 year 2 mons 3 days 04:05:06.699999';
SET IntervalStyle to postgres;
SET IntervalStyle to sql_standard;
SET IntervalStyle to iso_8601;
SET IntervalStyle to postgres_verbose;
select '30 days'::interval = '1 month'::interval as t;
select interval_hash('30 days'::interval) = interval_hash('1 month'::interval) as t;
select make_interval(years := 2);
select make_interval() = make_interval(years := 0, months := 0, weeks := 0, days := 0, mins := 0, secs := 0.0);
SELECT EXTRACT(DECADE FROM INTERVAL '100 y');
SELECT extract(epoch from interval '1000000000 days');
CREATE TABLE INFINITE_INTERVAL_TBL (i interval);
SELECT i, isfinite(i) FROM INFINITE_INTERVAL_TBL;
SELECT lhst.i lhs,
    rhst.i rhs,
    lhst.i < rhst.i AS lt,
    lhst.i <= rhst.i AS le,
    lhst.i = rhst.i AS eq,
    lhst.i > rhst.i AS gt,
    lhst.i >= rhst.i AS ge,
    lhst.i <> rhst.i AS ne
    FROM INFINITE_INTERVAL_TBL lhst CROSS JOIN INFINITE_INTERVAL_TBL rhst
    WHERE NOT isfinite(lhst.i);
SELECT i AS interval,
    -i AS um,
    i * 2.0 AS mul,
    i * -2.0 AS mul_neg,
    i * 'infinity' AS mul_inf,
    i * '-infinity' AS mul_inf_neg,
    i / 3.0 AS div,
    i / -3.0 AS div_neg
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);
SELECT i AS interval, date_trunc('hour', i)
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);
SELECT i AS interval, justify_days(i), justify_hours(i), justify_interval(i)
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);
SELECT INTERVAL '42 days 2 seconds ago ago';
SELECT INTERVAL '2 minutes ago 5 days';
SELECT INTERVAL 'hour 5 months';
SELECT INTERVAL '1 year months days 5 hours';
