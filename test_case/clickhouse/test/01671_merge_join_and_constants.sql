SELECT pow('0.0000000257', NULL), pow(pow(NULL, NULL), NULL) - NULL, (val + NULL) = (rval * 0), * FROM (SELECT (val + 256) = (NULL * NULL), toLowCardinality(toNullable(dummy)) AS val FROM system.one) AS s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) AS s2 ON (val + 0) = (rval * 255) settings max_rows_in_join = 1;
DROP TABLE IF EXISTS table1;
DROP TABLE IF EXISTS table2;
