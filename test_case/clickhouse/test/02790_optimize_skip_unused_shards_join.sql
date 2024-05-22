DROP TABLE IF EXISTS outer;
DROP TABLE IF EXISTS inner;
DROP TABLE IF EXISTS outer_distributed;
DROP TABLE IF EXISTS inner_distributed;
CREATE TABLE IF NOT EXISTS outer
(
    `id` UInt64,
    `organization_id` UInt64,
    `version` UInt64
)
ENGINE = ReplacingMergeTree(version)
PARTITION BY organization_id % 8
ORDER BY (organization_id, id);
CREATE TABLE inner
(
    `id` UInt64,
    `outer_id` UInt64,
    `organization_id` UInt64,
    `version` UInt64,
    `date` Date
)
ENGINE = ReplacingMergeTree(version)
PARTITION BY toYYYYMM(date)
ORDER BY (organization_id, outer_id);
