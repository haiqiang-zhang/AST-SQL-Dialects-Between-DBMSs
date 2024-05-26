SELECT count() FROM minmax_compact WHERE i64 = 2;
ALTER TABLE minmax_compact MATERIALIZE INDEX idx IN PARTITION 2;
set max_rows_to_read = 6;
ALTER TABLE minmax_compact CLEAR INDEX idx IN PARTITION 1;
ALTER TABLE minmax_compact CLEAR INDEX idx IN PARTITION 2;
set max_rows_to_read = 10;
DROP TABLE minmax_compact;
