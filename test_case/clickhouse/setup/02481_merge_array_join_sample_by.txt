DROP TABLE IF EXISTS 02481_mergetree;
DROP TABLE IF EXISTS 02481_merge;
CREATE TABLE 02481_mergetree(x UInt64, y UInt64, arr Array(String)) ENGINE = MergeTree ORDER BY x SAMPLE BY x SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
CREATE TABLE 02481_merge(x UInt64, y UInt64, arr Array(String)) ENGINE = Merge(currentDatabase(), '^(02481_mergetree)$');
INSERT INTO 02481_mergetree SELECT number, number + 1, [1,2] FROM system.numbers LIMIT 100000;
