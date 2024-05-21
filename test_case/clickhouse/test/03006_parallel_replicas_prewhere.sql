DROP POLICY IF EXISTS url_na_log_policy0 ON url_na_log;
DROP TABLE IF EXISTS url_na_log;
CREATE TABLE url_na_log
(
    `SiteId` UInt32,
    `DateVisit` Date
)
ENGINE = MergeTree
PRIMARY KEY SiteId
ORDER BY (SiteId, DateVisit)
SETTINGS index_granularity = 1000, min_bytes_for_wide_part = 0;
INSERT INTO url_na_log
SETTINGS max_insert_block_size = 200000
SELECT
    209,
    CAST('2022-08-09', 'Date') + toIntervalDay(intDiv(number, 10000))
FROM numbers(130000)
SETTINGS max_insert_block_size = 200000;
DROP TABLE url_na_log;
