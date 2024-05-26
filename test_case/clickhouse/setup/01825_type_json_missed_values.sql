DROP TABLE IF EXISTS t_json;
SET allow_experimental_object_type = 1;
CREATE TABLE t_json(id UInt64, obj JSON)
ENGINE = MergeTree ORDER BY id
SETTINGS min_bytes_for_wide_part = 0;
