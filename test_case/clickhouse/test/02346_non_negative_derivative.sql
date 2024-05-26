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
