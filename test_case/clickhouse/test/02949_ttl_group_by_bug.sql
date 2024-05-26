OPTIMIZE TABLE ttl_group_by_bug FINAL;
SELECT *
FROM
(
    SELECT
        _part,
        rowNumberInAllBlocks(),
        (key, toStartOfInterval(ts, toIntervalMinute(3)), ts) AS cur,
        lagInFrame((key, toStartOfInterval(ts, toIntervalMinute(3)), ts), 1) OVER () AS prev,
        1
    FROM ttl_group_by_bug
)
WHERE cur < prev
LIMIT 2
SETTINGS max_threads = 1;
DROP TABLE IF EXISTS ttl_group_by_bug;
