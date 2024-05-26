DROP TABLE IF EXISTS null_in;
CREATE TABLE null_in (dt DateTime, idx int, i Nullable(int), s Nullable(String)) ENGINE = MergeTree() PARTITION BY dt ORDER BY idx SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO null_in VALUES (1, 1, 1, '1') (2, 2, NULL, NULL) (3, 3, 3, '3') (4, 4, NULL, NULL) (5, 5, 5, '5');
