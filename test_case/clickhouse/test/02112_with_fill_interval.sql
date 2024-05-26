SELECT '1 DAY';
SELECT d, count() FROM with_fill_date GROUP BY d ORDER BY d WITH FILL STEP INTERVAL 1 DAY LIMIT 5;
SELECT '1 WEEK';
SELECT '1 MONTH';
SELECT '3 MONTH';
SELECT toStartOfMonth(d) as d, count() FROM with_fill_date GROUP BY d ORDER BY d WITH FILL
    FROM toDate('2020-01-01')
    TO toDate('2021-01-01')
    STEP INTERVAL 3 MONTH;
SELECT '1 DAY';
SELECT '1 WEEK';
SELECT '1 MONTH';
SELECT '3 MONTH';
DROP TABLE with_fill_date;
DROP TABLE IF EXISTS with_fill_date;
CREATE TABLE with_fill_date (d DateTime('UTC'), d64 DateTime64(3, 'UTC')) ENGINE = Memory;
INSERT INTO with_fill_date VALUES (toDateTime('2020-02-05 10:20:00', 'UTC'), toDateTime64('2020-02-05 10:20:00', 3, 'UTC'));
INSERT INTO with_fill_date VALUES (toDateTime('2020-03-08 11:01:00', 'UTC'), toDateTime64('2020-03-08 11:01:00', 3, 'UTC'));
SELECT '15 MINUTE';
SELECT '6 HOUR';
SELECT '10 DAY';
SELECT '15 MINUTE';
SELECT '6 HOUR';
SELECT '10 DAY';
DROP TABLE with_fill_date;
CREATE TABLE with_fill_date (d Date, id UInt32) ENGINE = Memory;
INSERT INTO with_fill_date VALUES (toDate('2020-02-05'), 1);
INSERT INTO with_fill_date VALUES (toDate('2020-02-16'), 3);
INSERT INTO with_fill_date VALUES (toDate('2020-03-10'), 2);
INSERT INTO with_fill_date VALUES (toDate('2020-03-03'), 3);
SELECT '1 MONTH';
DROP TABLE with_fill_date;
SELECT d FROM (SELECT toDate(1) AS d)
ORDER BY d DESC WITH FILL FROM toDate(3) TO toDate(0) STEP INTERVAL -1 DAY;
