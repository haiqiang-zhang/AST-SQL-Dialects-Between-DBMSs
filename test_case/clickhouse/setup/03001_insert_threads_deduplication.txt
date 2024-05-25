DROP TABLE IF EXISTS landing SYNC;
DROP TABLE IF EXISTS landing_dist SYNC;
DROP TABLE IF EXISTS ds SYNC;
CREATE TABLE landing
(
    timestamp DateTime64(3),
    status String,
    id String
)
ENGINE = MergeTree()
ORDER BY timestamp;
