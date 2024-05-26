DROP TABLE IF EXISTS t_parts_profile_events;
CREATE TABLE t_parts_profile_events (a UInt32)
ENGINE = MergeTree ORDER BY tuple()
SETTINGS min_rows_for_wide_part = 10, min_bytes_for_wide_part = 0;
