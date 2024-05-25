DROP TABLE IF EXISTS derived_metrics_local;
CREATE TABLE derived_metrics_local
(
  timestamp DateTime,
  bytes UInt64
)
ENGINE=SummingMergeTree()
PARTITION BY toYYYYMMDD(timestamp)
ORDER BY (toStartOfHour(timestamp), timestamp)
TTL toStartOfHour(timestamp) + INTERVAL 1 HOUR GROUP BY toStartOfHour(timestamp)
SET bytes=max(bytes);
INSERT INTO derived_metrics_local values('2020-01-01 00:00:00', 1);
INSERT INTO derived_metrics_local values('2020-01-01 00:01:00', 3);
INSERT INTO derived_metrics_local values('2020-01-01 00:02:00', 2);
