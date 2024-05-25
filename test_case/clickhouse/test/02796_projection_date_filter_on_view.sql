ALTER TABLE fx_1m
ADD PROJECTION fx_5m (
    SELECT
        symbol,
        toStartOfInterval(dt_close, INTERVAL 300 SECOND) AS dt_close,
        argMin(open, dt_close),
        max(high),
        min(low),
        argMax(close, dt_close),
        sum(volume) volume
    GROUP BY symbol, dt_close
);
ALTER TABLE fx_1m MATERIALIZE PROJECTION fx_5m SETTINGS mutations_sync = 2;
CREATE VIEW fx_5m AS
SELECT
    symbol,
    toStartOfInterval(dt_close, INTERVAL 300 SECOND) AS dt_close,
    argMin(open, dt_close) open,
    max(high) high,
    min(low) low,
    argMax(close, dt_close) close,
    sum(volume) volume
FROM fx_1m
GROUP BY symbol, dt_close;
INSERT INTO fx_1m
SELECT
    'EURUSD',
    toDateTime64('2022-12-12 12:00:00', 3, 'UTC') + number,
    number + randCanonical(),
    number + randCanonical(),
    number + randCanonical(),
    number + randCanonical(),
    number + randCanonical()
FROM numbers(1000000);
DROP TABLE fx_5m;
DROP TABLE fx_1m;
