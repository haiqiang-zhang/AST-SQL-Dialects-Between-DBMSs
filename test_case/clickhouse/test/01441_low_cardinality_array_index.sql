SELECT count() FROM t_01411 WHERE str = 'asdf337';
DROP TABLE IF EXISTS t_01411;
DROP TABLE IF EXISTS t_01411_num;
CREATE TABLE t_01411_num(
    num UInt8,
    arr Array(LowCardinality(Int64)) default [num]
) ENGINE = MergeTree()
ORDER BY tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO t_01411_num (num) SELECT number % 1000 FROM numbers(1000000);
SELECT indexOf(['a', 'b', 'c'], toLowCardinality('a'));
DROP TABLE IF EXISTS t_01411_num;
