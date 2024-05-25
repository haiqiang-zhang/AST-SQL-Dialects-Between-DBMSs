CREATE TABLE hits
(
    `date` Date,
    `data` Array(UInt32)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(date)
ORDER BY date;
INSERT INTO hits values('2024-01-01', [1, 2, 3]);
