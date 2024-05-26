SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_tuple_filter;
CREATE TABLE test_tuple_filter (id UInt32, value String, log_date Date) Engine=MergeTree() ORDER BY id PARTITION BY log_date SETTINGS index_granularity = 3, index_granularity_bytes = '10Mi';
INSERT INTO test_tuple_filter VALUES (1,'A','2021-01-01'),(2,'B','2021-01-01'),(3,'C','2021-01-01'),(4,'D','2021-01-02'),(5,'E','2021-01-02');
SET force_primary_key = 1;
SET optimize_move_to_prewhere = 1;
