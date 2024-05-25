SELECT current_value - previous_value
FROM (
    SELECT event, value as current_value FROM system.events WHERE event like 'FailedInsertQuery'
) AS previous
ALL LEFT JOIN (
    SELECT event, value as previous_value FROM current_failed_query_metrics
) AS current
on previous.event = current.event;
SELECT current_value - previous_value
FROM (
    SELECT event, value as current_value FROM system.events WHERE event like 'FailedInsertQuery'
) AS previous
ALL LEFT JOIN (
    SELECT event, value as previous_value FROM current_failed_query_metrics
) AS current
on previous.event = current.event;
SELECT current_value - previous_value
FROM (
    SELECT event, value as current_value FROM system.events WHERE event like 'FailedSelectQuery'
) AS previous
ALL LEFT  JOIN (
    SELECT event, value as previous_value FROM current_failed_query_metrics
) AS current
on previous.event = current.event;
SELECT current_value - previous_value
FROM (
    SELECT event, value as current_value FROM system.events WHERE event like 'FailedSelectQuery'
) AS previous
ALL LEFT JOIN (
    SELECT event, value as previous_value FROM current_failed_query_metrics
) AS current
on previous.event = current.event;
DROP TABLE current_failed_query_metrics;
DROP TABLE to_insert;
