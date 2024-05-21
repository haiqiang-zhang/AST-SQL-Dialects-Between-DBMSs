DROP TABLE IF EXISTS t_constant_index;
CREATE TABLE t_constant_index
(
    id UInt64,
    INDEX t_constant_index 'foo' TYPE set(2) GRANULARITY 1
) ENGINE = MergeTree
ORDER BY id;
CREATE TABLE t_constant_index
(
    id UInt64,
    INDEX t_constant_index id * 2 TYPE set(2) GRANULARITY 1
) ENGINE = MergeTree
ORDER BY id;
DROP TABLE t_constant_index;