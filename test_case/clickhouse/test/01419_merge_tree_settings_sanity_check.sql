DROP TABLE IF EXISTS mytable_local;
CREATE TABLE mytable_local
(
    created          DateTime,
    eventday         Date,
    user_id          UInt32
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(eventday)
ORDER BY (eventday, user_id);
DROP TABLE mytable_local;
