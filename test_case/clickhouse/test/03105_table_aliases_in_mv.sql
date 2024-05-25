CREATE MATERIALIZED VIEW mv
(
    `event_time` DateTime,
    `event_name` String,
    `user_id` String,
    `user_type` String
)
ENGINE = MergeTree()
ORDER BY (event_time, event_name) POPULATE AS
SELECT
    e.event_time,
    e.event_name,
    e.user_id,
    u.user_type
FROM event e
INNER JOIN user u ON u.user_id = e.user_id;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS mv;
