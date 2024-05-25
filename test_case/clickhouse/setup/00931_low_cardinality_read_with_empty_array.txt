DROP TABLE IF EXISTS lc_00931;
CREATE TABLE lc_00931 (
    key UInt64,
    value Array(LowCardinality(String)))
ENGINE = MergeTree
ORDER BY key;
INSERT INTO lc_00931 SELECT number,
if (number < 10000 OR number > 100000,
    [toString(number)],
    emptyArrayString())
    FROM system.numbers LIMIT 200000;
