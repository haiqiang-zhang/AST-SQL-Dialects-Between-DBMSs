SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_wide_parts;
CREATE TABLE t_json_wide_parts (data JSON)
ENGINE MergeTree ORDER BY tuple()
SETTINGS min_bytes_for_wide_part = 0;
