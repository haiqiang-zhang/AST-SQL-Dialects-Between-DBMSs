CREATE TABLE IF NOT EXISTS posts
(
    `page_id` LowCardinality(String),
    `post_id` String CODEC(LZ4),
    `host_id` UInt32 CODEC(T64, LZ4),
    `path_id` UInt32,
    `created` DateTime CODEC(T64, LZ4),
    `as_of` DateTime CODEC(T64, LZ4)
)
ENGINE = ReplacingMergeTree(as_of)
PARTITION BY toStartOfMonth(created)
ORDER BY (page_id, post_id);
CREATE TABLE IF NOT EXISTS post_metrics
(
    `page_id` LowCardinality(String),
    `post_id` String CODEC(LZ4),
    `created` DateTime CODEC(T64, LZ4),
    `impressions` UInt32 CODEC(T64, LZ4),
    `clicks` UInt32 CODEC(T64, LZ4),
    `as_of` DateTime CODEC(T64, LZ4)
)
ENGINE = ReplacingMergeTree(as_of)
PARTITION BY toStartOfMonth(created)
ORDER BY (page_id, post_id);
INSERT INTO posts SELECT
    repeat('a', (number % 10) + 1),
    toString(number),
    number % 10,
    number,
    now() - toIntervalMinute(number),
    now()
FROM numbers(100000);
INSERT INTO post_metrics SELECT
    repeat('a', (number % 10) + 1),
    toString(number),
    now() - toIntervalMinute(number),
    number * 100,
    number * 10,
    now()
FROM numbers(100000);
