DROP TABLE IF EXISTS table_with_column_ttl;
CREATE TABLE table_with_column_ttl
(
    EventTime DateTime,
    UserID UInt64,
    Age UInt8 TTL EventTime + INTERVAL 3 MONTH
)
ENGINE MergeTree()
ORDER BY tuple()
SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO table_with_column_ttl VALUES (now(), 1, 32);
INSERT INTO table_with_column_ttl VALUES (now() - INTERVAL 4 MONTH, 2, 45);
