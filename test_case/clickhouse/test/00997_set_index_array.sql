SET max_rows_to_read = 8192;
select count() from set_array where has(index_array, 333);
DROP TABLE set_array;
