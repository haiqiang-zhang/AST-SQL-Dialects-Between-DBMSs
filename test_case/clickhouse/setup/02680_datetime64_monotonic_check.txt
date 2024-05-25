DROP TABLE IF EXISTS 02680_datetime64_monotonic_check;
DROP TABLE IF EXISTS 02680_datetime_monotonic_check_lc;
CREATE TABLE 02680_datetime64_monotonic_check (`t` DateTime64(3), `x` Nullable(Decimal(18, 14)))
ENGINE = MergeTree
PARTITION BY toYYYYMMDD(t)
ORDER BY x SETTINGS allow_nullable_key = 1;
INSERT INTO 02680_datetime64_monotonic_check VALUES (toDateTime64('2023-03-13 00:00:00', 3, 'Asia/Jerusalem'), 123);
