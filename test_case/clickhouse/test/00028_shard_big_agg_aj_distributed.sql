SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
INSERT INTO big_array SELECT groupArray(number % 255) AS x FROM (SELECT * FROM system.numbers LIMIT 1000000);
DROP TABLE big_array;
