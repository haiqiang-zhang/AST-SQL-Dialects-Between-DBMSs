DROP TABLE IF EXISTS tdm__fuzz_23;
CREATE TABLE tdm__fuzz_23 (`x` UInt256) ENGINE = MergeTree ORDER BY x SETTINGS write_final_mark = 0;
