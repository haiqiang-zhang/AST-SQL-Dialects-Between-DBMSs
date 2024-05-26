SELECT 'exponentialMovingAverage';
SELECT value, time, round(exp_smooth, 3) FROM (SELECT number = 0 AS value, number AS time, exponentialMovingAverage(1)(value, time) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS exp_smooth FROM numbers(10));
SELECT 'exponentialTimeDecayedSum';
SELECT 'exponentialTimeDecayedMax';
SELECT 'exponentialTimeDecayedCount';
SELECT 'exponentialTimeDecayedAvg';
SELECT 'Check `exponentialTimeDecayed.*` supports sliding windows';
SELECT 'Check `exponentialTimeDecayedMax` works with negative values';
