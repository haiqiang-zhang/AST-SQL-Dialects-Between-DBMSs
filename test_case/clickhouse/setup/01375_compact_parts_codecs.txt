DROP TABLE IF EXISTS codecs;
CREATE TABLE codecs (id UInt32, val UInt32, s String)
    ENGINE = MergeTree ORDER BY id
    SETTINGS min_rows_for_wide_part = 10000, ratio_of_defaults_for_sparse_serialization = 1;
INSERT INTO codecs SELECT number, number, toString(number) FROM numbers(1000);
