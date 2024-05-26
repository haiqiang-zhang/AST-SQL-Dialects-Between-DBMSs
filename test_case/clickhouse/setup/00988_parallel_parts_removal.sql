DROP TABLE IF EXISTS mt;
CREATE TABLE mt (x UInt64) ENGINE = MergeTree ORDER BY x
    SETTINGS cleanup_delay_period = 1, cleanup_delay_period_random_add = 0,
    cleanup_thread_preferred_points_per_iteration=0, old_parts_lifetime = 1, parts_to_delay_insert = 100000, parts_to_throw_insert = 100000;
