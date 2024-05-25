SET max_block_size = 1;
SET max_rows_to_read = 5;
SELECT toUInt32(x), y, z FROM pk WHERE (x >= toDateTime(100000)) AND (x <= toDateTime(90000));
DROP TABLE IF EXISTS pk;
