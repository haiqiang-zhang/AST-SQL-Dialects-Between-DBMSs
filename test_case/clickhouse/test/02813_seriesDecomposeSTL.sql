SELECT seriesDecomposeSTL([10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34, 10.1, 20.45, 40.34], 3);
SELECT seriesDecomposeSTL([2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], 0);
SELECT seriesDecomposeSTL(ts, period) FROM tb2 ORDER BY period;
DROP TABLE IF EXISTS tb2;
