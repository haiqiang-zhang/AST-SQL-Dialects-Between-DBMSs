SET max_memory_usage = 32000000;
SET join_on_disk_max_files_to_merge = 4;
SET join_algorithm = 'partial_merge';
SET default_max_bytes_in_join = 0;
SET partial_merge_join_optimizations = 1;
SET default_max_bytes_in_join = 10000000;
SELECT n, j FROM
(
    SELECT number * 200000 as n FROM numbers(5)
) nums
JOIN (
    SELECT number * 2 AS n, number AS j
    FROM numbers(1000000)
) js2
USING n
ORDER BY n;
