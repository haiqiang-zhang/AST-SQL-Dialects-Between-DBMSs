DROP TABLE IF EXISTS data_compact;
DROP TABLE IF EXISTS data_memory;
DROP TABLE IF EXISTS data_wide;
DROP TABLE IF EXISTS data_compact;
CREATE TABLE data_compact
(
    `root.array` Array(UInt8),
)
ENGINE = MergeTree()
ORDER BY tuple()
SETTINGS min_rows_for_wide_part=100, min_bytes_for_wide_part=1e9;
INSERT INTO data_compact VALUES ([0]);
ALTER TABLE data_compact ADD COLUMN root.nested_array Array(Array(UInt8));