DROP TABLE IF EXISTS nnd;
CREATE TABLE nnd
(
    id Int8, ts DateTime64(3, 'UTC'), metric Float64
)
ENGINE=MergeTree()
ORDER BY id;
INSERT INTO nnd VALUES (1, toDateTime64('1979-12-12 21:21:21.123456788', 9, 'UTC'), 1.1), (2, toDateTime64('1979-12-12 21:21:21.123456789', 9, 'UTC'), 2.34), (3, toDateTime64('1979-12-12 21:21:21.127', 3, 'UTC'), 3.7);
INSERT INTO nnd VALUES (4, toDateTime64('1979-12-12 21:21:21.129', 3, 'UTC'), 2.1), (5, toDateTime('1979-12-12 21:21:22', 'UTC'), 1.3345), (6, toDateTime('1979-12-12 21:21:23', 'UTC'), 1.54), (7, toDateTime('1979-12-12 21:21:23', 'UTC'), 1.54);
OPTIMIZE TABLE nnd;
SELECT (
           SELECT
               ts,
               metric,
               nonNegativeDerivative(metric, ts) OVER (PARTITION BY metric ORDER BY ts, metric ASC Rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS deriv
           FROM nnd
           LIMIT 5, 1
       ) = (
           SELECT
               ts,
               metric,
               nonNegativeDerivative(metric, ts, toIntervalSecond(1)) OVER (PARTITION BY metric ORDER BY ts ASC Rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS deriv
           FROM nnd
           LIMIT 5, 1
       );
SELECT ts, metric, nonNegativeDerivative(metric, ts) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 3 NANOSECOND) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 4 MICROSECOND) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 5 MILLISECOND) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 6 SECOND) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 7 MINUTE) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 8 HOUR) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 9 DAY) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 3 PRECEDING AND 3 FOLLOWING) AS deriv FROM nnd;
SELECT ts, metric, nonNegativeDerivative(metric, ts, INTERVAL 10 WEEK) OVER (PARTITION BY id>3 ORDER BY ts, metric ASC Rows BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING) AS deriv FROM nnd;
DROP TABLE IF EXISTS nnd;
