
--- (when marks was reading with max_read_buffer_size=0, hence DROP MARK CACHE is required)

DROP TABLE IF EXISTS data_02411;
CREATE TABLE data_02411
(
    key Int32
)
ENGINE = MergeTree
ORDER BY key
SETTINGS min_bytes_for_wide_part = 0, index_granularity = 8192;
INSERT INTO data_02411 SELECT * FROM numbers(100);
SYSTEM DROP MARK CACHE;
