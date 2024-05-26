SELECT 'defaults';
SELECT count(1) FROM (
    SELECT materialize(1) as k, n FROM numbers(10) nums
    JOIN (SELECT materialize(1) AS k, number n FROM numbers(1000000)) j
    USING k);
SELECT count(1), uniqExact(n) FROM (
    SELECT materialize(1) as k, n FROM numbers(1000000) nums
    JOIN (SELECT materialize(1) AS k, number n FROM numbers(10)) j
    USING k);
SET max_joined_block_size_rows = 0;
SELECT 'max_joined_block_size_rows = 2000';
SET max_joined_block_size_rows = 2000;
SELECT 'max_rows_in_join = 1000';
SET max_rows_in_join = 1000;
