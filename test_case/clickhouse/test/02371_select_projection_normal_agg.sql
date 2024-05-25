ALTER TABLE video_log ADD PROJECTION p_norm
(
    SELECT
        datetime,
        device_id,
        bytes,
        duration
    ORDER BY device_id
);
ALTER TABLE video_log MATERIALIZE PROJECTION p_norm settings mutations_sync=1;
ALTER TABLE video_log ADD PROJECTION p_agg
(
    SELECT
        toStartOfHour(datetime) AS hour,
        domain,
        sum(bytes),
        avg(duration)
    GROUP BY
        hour,
        domain
);
ALTER TABLE video_log MATERIALIZE PROJECTION p_agg settings mutations_sync=1;
SELECT
    equals(sum_bytes1, sum_bytes2),
    equals(avg_duration1, avg_duration2)
FROM
(
    SELECT
        toStartOfHour(datetime) AS hour,
        sum(bytes) AS sum_bytes1,
        avg(duration) AS avg_duration1
    FROM video_log
    WHERE (toDate(hour) = '2022-07-22') AND (device_id = '100') --(device_id = '100') Make sure it's not good and doesn't go into prewhere.
    GROUP BY hour
)
LEFT JOIN
(
    SELECT
        `hour`,
        `sum_bytes` AS sum_bytes2,
        `avg_duration` AS avg_duration2
    FROM video_log_result
)
USING (hour) settings joined_subquery_requires_alias=0;
DROP TABLE IF EXISTS video_log;
DROP TABLE IF EXISTS rng;
DROP TABLE IF EXISTS video_log_result;
