SET max_block_size = 4213;
SELECT DISTINCT (blockSize() <= 4214)
FROM
(
    SELECT number
    FROM numbers(100000)
    GROUP BY number
);
