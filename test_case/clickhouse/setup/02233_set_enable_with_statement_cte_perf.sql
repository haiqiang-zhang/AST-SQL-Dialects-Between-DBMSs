DROP TABLE IF EXISTS ev;
DROP TABLE IF EXISTS idx;
CREATE TABLE ev (a Int32, b Int32) Engine=MergeTree() ORDER BY a SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
CREATE TABLE idx (a Int32) Engine=MergeTree() ORDER BY a SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO ev SELECT number, number FROM numbers(10000000);
INSERT INTO idx SELECT number * 5 FROM numbers(1000);
