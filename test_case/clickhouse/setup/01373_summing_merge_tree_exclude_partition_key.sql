SET optimize_on_insert = 0;
DROP TABLE IF EXISTS tt_01373;
CREATE TABLE tt_01373
(a Int64, d Int64, val Int64) 
ENGINE = SummingMergeTree PARTITION BY (a) ORDER BY (d) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
