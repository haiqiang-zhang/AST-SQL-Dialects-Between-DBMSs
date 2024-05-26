SELECT count() AS amount, a, b, GROUPING(a, b) FROM test02315 GROUP BY GROUPING SETS ((a, b), (a), ()) ORDER BY (amount, a, b) SETTINGS force_grouping_standard_compatibility=0;
SELECT count() AS amount, a, b, GROUPING(a, b) FROM test02315 GROUP BY ROLLUP(a, b) ORDER BY (amount, a, b) SETTINGS force_grouping_standard_compatibility=0;
DROP TABLE test02315;
