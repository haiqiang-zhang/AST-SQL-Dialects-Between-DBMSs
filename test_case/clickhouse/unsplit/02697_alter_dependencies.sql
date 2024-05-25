CREATE TABLE mv_source (a Int64, insert_time DateTime) ENGINE = MergeTree() ORDER BY insert_time;
CREATE TABLE mv_target (a Int64, insert_time DateTime) ENGINE = MergeTree() ORDER BY insert_time;
CREATE MATERIALIZED VIEW source_to_target to mv_target as Select * from mv_source where a not in (Select sleepEachRow(0.1) from numbers(50));
ALTER TABLE mv_source MODIFY TTL insert_time + toIntervalDay(1);
SYSTEM FLUSH LOGS;
