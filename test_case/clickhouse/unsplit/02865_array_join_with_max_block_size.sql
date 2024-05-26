set max_block_size = 10, enable_unaligned_array_join = true;
SELECT n, count(1) from (SELECT groupArray(number % 10) AS x FROM (SELECT * FROM numbers(100000))) ARRAY JOIN x as n group by n;
set max_block_size = 1000, enable_unaligned_array_join = true;
set max_block_size = 100000, enable_unaligned_array_join = true;
