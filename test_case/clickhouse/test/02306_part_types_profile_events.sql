DROP TABLE IF EXISTS t_parts_profile_events;
CREATE TABLE t_parts_profile_events (a UInt32)
ENGINE = MergeTree ORDER BY tuple()
SETTINGS min_rows_for_wide_part = 10, min_bytes_for_wide_part = 0;
SYSTEM STOP MERGES t_parts_profile_events;
SET log_comment = '02306_part_types_profile_events';
INSERT INTO t_parts_profile_events VALUES (1);
INSERT INTO t_parts_profile_events VALUES (1);
SYSTEM START MERGES t_parts_profile_events;
OPTIMIZE TABLE t_parts_profile_events FINAL;
SYSTEM STOP MERGES t_parts_profile_events;
INSERT INTO t_parts_profile_events SELECT number FROM numbers(20);
SYSTEM START MERGES t_parts_profile_events;
OPTIMIZE TABLE t_parts_profile_events FINAL;
SYSTEM STOP MERGES t_parts_profile_events;
SYSTEM FLUSH LOGS;
DROP TABLE t_parts_profile_events;
