CREATE TABLE data (str String) ENGINE=MergeTree ORDER BY str;
INSERT INTO data (str) SELECT 'aa' FROM numbers(100000);
INSERT INTO data (str) SELECT 'ba' FROM numbers(100000);
INSERT INTO data (str) SELECT 'ca' FROM numbers(100000);
