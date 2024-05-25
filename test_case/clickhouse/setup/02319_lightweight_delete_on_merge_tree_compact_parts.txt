DROP TABLE IF EXISTS merge_table_standard_delete;
CREATE TABLE merge_table_standard_delete(id Int32, name String) ENGINE = MergeTree order by id settings min_bytes_for_wide_part=10000000;
INSERT INTO merge_table_standard_delete select number, toString(number) from numbers(100);
