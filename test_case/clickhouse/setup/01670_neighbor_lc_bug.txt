drop table if exists neighbor_test;
CREATE TABLE neighbor_test
(
    `rowNr` UInt8,
    `val_string` String,
    `val_low` LowCardinality(String)
)
ENGINE = MergeTree
PARTITION BY tuple()
ORDER BY rowNr;
INSERT INTO neighbor_test VALUES (1, 'String 1', 'String 1'), (2, 'String 1', 'String 1'), (3, 'String 2', 'String 2');
drop table if exists neighbor_test;
