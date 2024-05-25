ALTER TABLE video_log
    ADD PROJECTION p_norm
    (
        SELECT
            datetime,
            device_id,
            bytes,
            duration
        ORDER BY device_id
    );
ALTER TABLE video_log
    MATERIALIZE PROJECTION p_norm
SETTINGS mutations_sync = 1;
ALTER TABLE video_log
    ADD PROJECTION p_agg
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
ALTER TABLE video_log
    MATERIALIZE PROJECTION p_agg
SETTINGS mutations_sync = 1;
DROP TABLE video_log;
DROP TABLE video_log_result__fuzz_0;
DROP TABLE rng;
