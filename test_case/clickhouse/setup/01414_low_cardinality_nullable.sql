SET allow_suspicious_low_cardinality_types=1;
DROP TABLE IF EXISTS lc_nullable;
CREATE TABLE lc_nullable (
    order_key   Array(LowCardinality(Nullable(UInt64))),

    i8  Array(LowCardinality(Nullable(Int8))),
    i16 Array(LowCardinality(Nullable(Int16))),
    i32 Array(LowCardinality(Nullable(Int32))),
    i64 Array(LowCardinality(Nullable(Int64))),
    u8  Array(LowCardinality(Nullable(UInt8))),
    u16 Array(LowCardinality(Nullable(UInt16))),
    u32 Array(LowCardinality(Nullable(UInt32))),
    u64 Array(LowCardinality(Nullable(UInt64))),
    f32 Array(LowCardinality(Nullable(Float32))),
    f64 Array(LowCardinality(Nullable(Float64))),

    date Array(LowCardinality(Nullable(Date))),
    date_time Array(LowCardinality(Nullable(DateTime('Asia/Istanbul')))),

    str Array(LowCardinality(Nullable(String))),
    fixed_string Array(LowCardinality(Nullable(FixedString(5))))
) ENGINE = MergeTree() ORDER BY order_key SETTINGS allow_nullable_key = 1;
INSERT INTO lc_nullable SELECT
    groupArray(number) AS order_key,
    groupArray(toInt8(number)) AS i8,
    groupArray(toInt16(number)) AS i16,
    groupArray(toInt32(number)) AS i32,
    groupArray(toInt64(number)) AS i64,
    groupArray(toUInt8(number)) AS u8,
    groupArray(toUInt16(number)) AS u16,
    groupArray(toUInt32(number)) AS u32,
    groupArray(toUInt64(number)) AS u64,
    groupArray(toFloat32(number)) AS f32,
    groupArray(toFloat64(number)) AS f64,
    groupArray(toDate(number, 'Asia/Istanbul')) AS date,
    groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time,
    groupArray(toString(number)) AS str,
    groupArray(toFixedString(toString(number), 5)) AS fixed_string
    FROM (SELECT number FROM system.numbers LIMIT 15);
INSERT INTO lc_nullable SELECT
    groupArray(num) AS order_key,
    groupArray(toInt8(num)) AS i8,
    groupArray(toInt16(num)) AS i16,
    groupArray(toInt32(num)) AS i32,
    groupArray(toInt64(num)) AS i64,
    groupArray(toUInt8(num)) AS u8,
    groupArray(toUInt16(num)) AS u16,
    groupArray(toUInt32(num)) AS u32,
    groupArray(toUInt64(num)) AS u64,
    groupArray(toFloat32(num)) AS f32,
    groupArray(toFloat64(num)) AS f64,
    groupArray(toDate(num, 'Asia/Istanbul')) AS date,
    groupArray(toDateTime(num, 'Asia/Istanbul')) AS date_time,
    groupArray(toString(num)) AS str,
    groupArray(toFixedString(toString(num), 5)) AS fixed_string
    FROM (SELECT negate(number) as num FROM system.numbers LIMIT 15);
INSERT INTO lc_nullable SELECT
    groupArray(number) AS order_key,
    groupArray(toInt8(number)) AS i8,
    groupArray(toInt16(number)) AS i16,
    groupArray(toInt32(number)) AS i32,
    groupArray(toInt64(number)) AS i64,
    groupArray(toUInt8(number)) AS u8,
    groupArray(toUInt16(number)) AS u16,
    groupArray(toUInt32(number)) AS u32,
    groupArray(toUInt64(number)) AS u64,
    groupArray(toFloat32(number)) AS f32,
    groupArray(toFloat64(number)) AS f64,
    groupArray(toDate(number, 'Asia/Istanbul')) AS date,
    groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time,
    groupArray(toString(number)) AS str,
    groupArray(toFixedString(toString(number), 5)) AS fixed_string
    FROM (SELECT number FROM system.numbers WHERE number >= 5 LIMIT 15);
INSERT INTO lc_nullable SELECT
    groupArray(number) AS order_key,
    groupArray(toInt8(number)) AS i8,
    groupArray(toInt16(number)) AS i16,
    groupArray(toInt32(number)) AS i32,
    groupArray(toInt64(number)) AS i64,
    groupArray(toUInt8(number)) AS u8,
    groupArray(toUInt16(number)) AS u16,
    groupArray(toUInt32(number)) AS u32,
    groupArray(toUInt64(number)) AS u64,
    groupArray(toFloat32(number)) AS f32,
    groupArray(toFloat64(number)) AS f64,
    groupArray(toDate(number, 'Asia/Istanbul')) AS date,
    groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time,
    groupArray(toString(number)) AS str,
    groupArray(toFixedString(toString(number), 5)) AS fixed_string
    FROM (SELECT number FROM system.numbers WHERE number >= 10 LIMIT 15);
INSERT INTO lc_nullable SELECT
    n AS order_key,
    n AS i8,
    n AS i16,
    n AS i32,
    n AS i64,
    n AS u8,
    n AS u16,
    n AS u32,
    n AS u64,
    n AS f32,
    n AS f64,
    n AS date,
    n AS date_time,
    n AS str,
    n AS fixed_string
    FROM (SELECT [NULL] AS n);
INSERT INTO lc_nullable SELECT
    [NULL, n] AS order_key,
    [NULL, toInt8(n)] AS i8,
    [NULL, toInt16(n)] AS i16,
    [NULL, toInt32(n)] AS i32,
    [NULL, toInt64(n)] AS i64,
    [NULL, toUInt8(n)] AS u8,
    [NULL, toUInt16(n)] AS u16,
    [NULL, toUInt32(n)] AS u32,
    [NULL, toUInt64(n)] AS u64,
    [NULL, toFloat32(n)] AS f32,
    [NULL, toFloat64(n)] AS f64,
    [NULL, toDate(n, 'Asia/Istanbul')] AS date,
    [NULL, toDateTime(n, 'Asia/Istanbul')] AS date_time,
    [NULL, toString(n)] AS str,
    [NULL, toFixedString(toString(n), 5)] AS fixed_string
    FROM (SELECT 100 as n);
