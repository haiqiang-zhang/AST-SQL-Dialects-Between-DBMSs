SET allow_suspicious_low_cardinality_types=1;
DROP TABLE IF EXISTS t_01411;
CREATE TABLE t_01411(
    str LowCardinality(String),
    arr Array(LowCardinality(String)) default [str]
) ENGINE = MergeTree()
ORDER BY tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO t_01411 (str) SELECT concat('asdf', toString(number % 10000)) FROM numbers(1000000);
