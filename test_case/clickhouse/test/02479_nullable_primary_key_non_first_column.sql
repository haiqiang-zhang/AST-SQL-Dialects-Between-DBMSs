select * from test_table where B is null;
drop table test_table;
DROP TABLE IF EXISTS dm_metric_small2;
CREATE TABLE dm_metric_small2 (`x` Nullable(Int64), `y` Nullable(Int64), `z` Nullable(Int64)) ENGINE = MergeTree() ORDER BY (x, y, z) SETTINGS index_granularity = 1, allow_nullable_key = 1;
INSERT INTO dm_metric_small2 VALUES (1,1,NULL) (1,1,1) (1,2,0) (1,2,1) (1,2,NULL) (1,2,NULL);
SELECT * FROM dm_metric_small2 WHERE (x = 1) AND (y = 1) AND z IS NULL;
DROP TABLE dm_metric_small2;
