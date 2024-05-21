SELECT '-- toStartOfInterval';
SELECT
    toDateTime('2024-01-02 00:00:00', 'UTC') dt,
    toStartOfInterval(dt, INTERVAL 1 WEEK), -- Monday, Jan 01
    toStartOfInterval(dt, INTERVAL 2 WEEK);
