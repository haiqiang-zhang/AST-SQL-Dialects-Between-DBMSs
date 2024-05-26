DROP TABLE IF EXISTS current_failed_query_metrics;
DROP TABLE IF EXISTS to_insert;
CREATE TABLE current_failed_query_metrics (event LowCardinality(String), value UInt64) ENGINE = Memory();
INSERT INTO current_failed_query_metrics 
SELECT event, value
FROM system.events
WHERE event in ('FailedQuery', 'FailedInsertQuery', 'FailedSelectQuery');
CREATE TABLE to_insert (value UInt64) ENGINE = Memory();
