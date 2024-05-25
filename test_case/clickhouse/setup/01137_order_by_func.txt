DROP TABLE IF EXISTS pk_func;
CREATE TABLE pk_func(d DateTime, ui UInt32) ENGINE = MergeTree ORDER BY toDate(d) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO pk_func SELECT '2020-05-05 01:00:00', number FROM numbers(1000000);
INSERT INTO pk_func SELECT '2020-05-06 01:00:00', number FROM numbers(1000000);
INSERT INTO pk_func SELECT '2020-05-07 01:00:00', number FROM numbers(1000000);
