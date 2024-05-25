DROP TABLE IF EXISTS lwd_merge;
CREATE TABLE lwd_merge (id UInt64 CODEC(NONE))
    ENGINE = MergeTree ORDER BY id
SETTINGS max_bytes_to_merge_at_max_space_in_pool = 80000, exclude_deleted_rows_for_part_size_in_merge = 0;
INSERT INTO lwd_merge SELECT number FROM numbers(10000);
INSERT INTO lwd_merge SELECT number FROM numbers(10000, 10000);
