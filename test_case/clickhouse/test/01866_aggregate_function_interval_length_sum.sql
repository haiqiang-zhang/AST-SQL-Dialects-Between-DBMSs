SELECT id, intervalLengthSum(start, end), toTypeName(intervalLengthSum(start, end)) FROM interval GROUP BY id ORDER BY id;
SELECT id, 3.4 < intervalLengthSum(start, end) AND intervalLengthSum(start, end) < 3.6, toTypeName(intervalLengthSum(start, end)) FROM fl_interval GROUP BY id ORDER BY id;
DROP TABLE interval;
DROP TABLE fl_interval;
DROP TABLE dt_interval;
DROP TABLE date_interval;
