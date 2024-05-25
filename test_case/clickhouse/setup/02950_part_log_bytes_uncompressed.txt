CREATE TABLE part_log_bytes_uncompressed (
    key UInt8,
    value UInt8
)
Engine=MergeTree()
ORDER BY key;
INSERT INTO part_log_bytes_uncompressed SELECT 1, 1 FROM numbers(1000);
INSERT INTO part_log_bytes_uncompressed SELECT 2, 1 FROM numbers(1000);
