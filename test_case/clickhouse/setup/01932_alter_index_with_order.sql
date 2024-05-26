DROP TABLE IF EXISTS alter_index_test;
CREATE TABLE alter_index_test (
    a UInt32,
    b Date,
    c UInt32,
    d UInt32,
    INDEX index_a a TYPE set(0) GRANULARITY 1
)
ENGINE = MergeTree()
ORDER BY tuple();
