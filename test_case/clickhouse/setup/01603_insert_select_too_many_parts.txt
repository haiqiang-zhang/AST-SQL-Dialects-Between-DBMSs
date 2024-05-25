DROP TABLE IF EXISTS too_many_parts;
CREATE TABLE too_many_parts (x UInt64) ENGINE = MergeTree ORDER BY tuple() SETTINGS parts_to_delay_insert = 5, parts_to_throw_insert = 5;
