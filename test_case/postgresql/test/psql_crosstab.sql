ANALYZE ctv_data;
SELECT v, EXTRACT(year FROM d), count(*)
 FROM ctv_data
 GROUP BY 1, 2
 ORDER BY 1, 2;
INSERT INTO ctv_data SELECT 1, x, '*' || x FROM generate_series(1,10) x;
