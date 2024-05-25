DROP TABLE IF EXISTS date_t;
CREATE TABLE date_t (id UInt32, value1 String, date1 Date) ENGINE ReplacingMergeTree() ORDER BY id;
