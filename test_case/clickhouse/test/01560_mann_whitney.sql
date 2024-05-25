SELECT mannWhitneyUTest(left, right) from mann_whitney_test;
SELECT '223.0', '0.5426959774289482';
WITH mannWhitneyUTest(left, right) AS pair SELECT roundBankers(pair.1, 16) as t_stat, roundBankers(pair.2, 16) as p_value from mann_whitney_test;
WITH mannWhitneyUTest('two-sided', 1)(left, right) as pair SELECT roundBankers(pair.1, 16) as t_stat, roundBankers(pair.2, 16) as p_value from mann_whitney_test;
WITH mannWhitneyUTest('two-sided')(left, right) as pair SELECT roundBankers(pair.1, 16) as t_stat, roundBankers(pair.2, 16) as p_value from mann_whitney_test;
DROP TABLE IF EXISTS mann_whitney_test;
