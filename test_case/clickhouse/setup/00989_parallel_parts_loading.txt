DROP TABLE IF EXISTS mt;
CREATE TABLE mt (x UInt64) ENGINE = MergeTree ORDER BY x SETTINGS parts_to_delay_insert = 100000, parts_to_throw_insert = 100000;
