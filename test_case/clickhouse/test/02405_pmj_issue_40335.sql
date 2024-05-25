SET max_block_size=3;
SET max_joined_block_size_rows = 2;
SET join_algorithm='partial_merge';
SELECT value FROM t1 LEFT JOIN t2 ON t1.x = t2.x ORDER BY value;
