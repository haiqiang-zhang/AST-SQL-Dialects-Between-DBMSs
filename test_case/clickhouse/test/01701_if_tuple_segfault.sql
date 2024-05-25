SELECT * FROM agg_table;
SELECT if(xxx = 'x', ([2], 3), ([3], 4)) FROM agg_table;
ALTER TABLE agg_table UPDATE two_values = (two_values.1, two_values.2) WHERE time BETWEEN toDateTime('2020-08-01 00:00:00') AND toDateTime('2020-12-01 00:00:00') SETTINGS mutations_sync = 2;
ALTER TABLE agg_table UPDATE agg_simple = 5 WHERE time BETWEEN toDateTime('2020-08-01 00:00:00') AND toDateTime('2020-12-01 00:00:00') SETTINGS mutations_sync = 2;
ALTER TABLE agg_table UPDATE agg = (agg.1, agg.2) WHERE time BETWEEN toDateTime('2020-08-01 00:00:00') AND toDateTime('2020-12-01 00:00:00') SETTINGS mutations_sync = 2;
ALTER TABLE agg_table UPDATE agg = (agg.1, arrayMap(x -> toUInt64(x / 2), agg.2)) WHERE time BETWEEN toDateTime('2020-08-01 00:00:00') AND toDateTime('2020-12-01 00:00:00') SETTINGS mutations_sync = 2;
SELECT * FROM agg_table;
DROP TABLE IF EXISTS agg_table;
