CREATE TABLE source
(
    `ts` DateTime('UTC'),
    `n` Int32
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(ts)
ORDER BY tuple();
INSERT INTO source values ('2021-12-31 23:00:00', 0);
