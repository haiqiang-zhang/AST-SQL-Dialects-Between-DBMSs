SET allow_suspicious_low_cardinality_types=1;
SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS single_column_bloom_filter;
CREATE TABLE single_column_bloom_filter (u64 UInt64, i32 Int32, i64 UInt64, INDEX idx (i32) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY u64 SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO single_column_bloom_filter SELECT number AS u64, number AS i32, number AS i64 FROM system.numbers LIMIT 100;
SELECT COUNT() FROM single_column_bloom_filter WHERE i32 = 1 SETTINGS max_rows_to_read = 6;
WITH (1, 2) AS liter_prepared_set SELECT COUNT() FROM single_column_bloom_filter WHERE i32 IN liter_prepared_set SETTINGS max_rows_to_read = 6;
DROP TABLE IF EXISTS single_column_bloom_filter;
DROP TABLE IF EXISTS bloom_filter_types_test;
CREATE TABLE bloom_filter_types_test (order_key   UInt64, i8 Int8, i16 Int16, i32 Int32, i64 Int64, u8 UInt8, u16 UInt16, u32 UInt32, u64 UInt64, f32 Float32, f64 Float64, date Date, date_time DateTime('Asia/Istanbul'), str String, fixed_string FixedString(5), INDEX idx (i8, i16, i32, i64, u8, u16, u32, u64, f32, f64, date, date_time, str, fixed_string) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_types_test SELECT number AS order_key, toInt8(number) AS i8, toInt16(number) AS i16, toInt32(number) AS i32, toInt64(number) AS i64, toUInt8(number) AS u8, toUInt16(number) AS u16, toUInt32(number) AS u32, toUInt64(number) AS u64, toFloat32(number) AS f32, toFloat64(number) AS f64, toDate(number, 'Asia/Istanbul') AS date, toDateTime(number, 'Asia/Istanbul') AS date_time, toString(number) AS str, toFixedString(toString(number), 5) AS fixed_string FROM system.numbers LIMIT 100;
DROP TABLE IF EXISTS bloom_filter_types_test;
DROP TABLE IF EXISTS bloom_filter_array_types_test;
CREATE TABLE bloom_filter_array_types_test (order_key   Array(UInt64), i8 Array(Int8), i16 Array(Int16), i32 Array(Int32), i64 Array(Int64), u8 Array(UInt8), u16 Array(UInt16), u32 Array(UInt32), u64 Array(UInt64), f32 Array(Float32), f64 Array(Float64), date Array(Date), date_time Array(DateTime('Asia/Istanbul')), str Array(String), fixed_string Array(FixedString(5)), INDEX idx (i8, i16, i32, i64, u8, u16, u32, u64, f32, f64, date, date_time, str, fixed_string) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_array_types_test SELECT groupArray(number) AS order_key, groupArray(toInt8(number)) AS i8, groupArray(toInt16(number)) AS i16, groupArray(toInt32(number)) AS i32, groupArray(toInt64(number)) AS i64, groupArray(toUInt8(number)) AS u8, groupArray(toUInt16(number)) AS u16, groupArray(toUInt32(number)) AS u32, groupArray(toUInt64(number)) AS u64, groupArray(toFloat32(number)) AS f32, groupArray(toFloat64(number)) AS f64, groupArray(toDate(number, 'Asia/Istanbul')) AS date, groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time, groupArray(toString(number)) AS str, groupArray(toFixedString(toString(number), 5)) AS fixed_string FROM (SELECT number FROM system.numbers LIMIT 15);
INSERT INTO bloom_filter_array_types_test SELECT groupArray(number) AS order_key, groupArray(toInt8(number)) AS i8, groupArray(toInt16(number)) AS i16, groupArray(toInt32(number)) AS i32, groupArray(toInt64(number)) AS i64, groupArray(toUInt8(number)) AS u8, groupArray(toUInt16(number)) AS u16, groupArray(toUInt32(number)) AS u32, groupArray(toUInt64(number)) AS u64, groupArray(toFloat32(number)) AS f32, groupArray(toFloat64(number)) AS f64, groupArray(toDate(number, 'Asia/Istanbul')) AS date, groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time, groupArray(toString(number)) AS str, groupArray(toFixedString(toString(number), 5)) AS fixed_string FROM (SELECT number FROM system.numbers WHERE number >= 5 LIMIT 15);
INSERT INTO bloom_filter_array_types_test SELECT groupArray(number) AS order_key, groupArray(toInt8(number)) AS i8, groupArray(toInt16(number)) AS i16, groupArray(toInt32(number)) AS i32, groupArray(toInt64(number)) AS i64, groupArray(toUInt8(number)) AS u8, groupArray(toUInt16(number)) AS u16, groupArray(toUInt32(number)) AS u32, groupArray(toUInt64(number)) AS u64, groupArray(toFloat32(number)) AS f32, groupArray(toFloat64(number)) AS f64, groupArray(toDate(number, 'Asia/Istanbul')) AS date, groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time, groupArray(toString(number)) AS str, groupArray(toFixedString(toString(number), 5)) AS fixed_string FROM (SELECT number FROM system.numbers WHERE number >= 10 LIMIT 15);
DROP TABLE IF EXISTS bloom_filter_array_types_test;
DROP TABLE IF EXISTS bloom_filter_null_types_test;
CREATE TABLE bloom_filter_null_types_test (order_key UInt64, i8 Nullable(Int8), i16 Nullable(Int16), i32 Nullable(Int32), i64 Nullable(Int64), u8 Nullable(UInt8), u16 Nullable(UInt16), u32 Nullable(UInt32), u64 Nullable(UInt64), f32 Nullable(Float32), f64 Nullable(Float64), date Nullable(Date), date_time Nullable(DateTime('Asia/Istanbul')), str Nullable(String), fixed_string Nullable(FixedString(5)), INDEX idx (i8, i16, i32, i64, u8, u16, u32, u64, f32, f64, date, date_time, str, fixed_string) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_null_types_test SELECT number AS order_key, toInt8(number) AS i8, toInt16(number) AS i16, toInt32(number) AS i32, toInt64(number) AS i64, toUInt8(number) AS u8, toUInt16(number) AS u16, toUInt32(number) AS u32, toUInt64(number) AS u64, toFloat32(number) AS f32, toFloat64(number) AS f64, toDate(number, 'Asia/Istanbul') AS date, toDateTime(number, 'Asia/Istanbul') AS date_time, toString(number) AS str, toFixedString(toString(number), 5) AS fixed_string FROM system.numbers LIMIT 100;
INSERT INTO bloom_filter_null_types_test SELECT 0 AS order_key, NULL AS i8, NULL AS i16, NULL AS i32, NULL AS i64, NULL AS u8, NULL AS u16, NULL AS u32, NULL AS u64, NULL AS f32, NULL AS f64, NULL AS date, NULL AS date_time, NULL AS str, NULL AS fixed_string;
DROP TABLE IF EXISTS bloom_filter_null_types_test;
DROP TABLE IF EXISTS bloom_filter_lc_null_types_test;
CREATE TABLE bloom_filter_lc_null_types_test (order_key UInt64, str LowCardinality(Nullable(String)), fixed_string LowCardinality(Nullable(FixedString(5))), INDEX idx (str, fixed_string) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_lc_null_types_test SELECT number AS order_key, toString(number) AS str, toFixedString(toString(number), 5) AS fixed_string FROM system.numbers LIMIT 100;
INSERT INTO bloom_filter_lc_null_types_test SELECT 0 AS order_key, NULL AS str, NULL AS fixed_string;
DROP TABLE IF EXISTS bloom_filter_lc_null_types_test;
DROP TABLE IF EXISTS bloom_filter_array_lc_null_types_test;
CREATE TABLE bloom_filter_array_lc_null_types_test (
    order_key   Array(LowCardinality(Nullable(UInt64))),

    i8 Array(LowCardinality(Nullable(Int8))),
    i16 Array(LowCardinality(Nullable(Int16))),
    i32 Array(LowCardinality(Nullable(Int32))),
    i64 Array(LowCardinality(Nullable(Int64))),
    u8 Array(LowCardinality(Nullable(UInt8))),
    u16 Array(LowCardinality(Nullable(UInt16))),
    u32 Array(LowCardinality(Nullable(UInt32))),
    u64 Array(LowCardinality(Nullable(UInt64))),
    f32 Array(LowCardinality(Nullable(Float32))),
    f64 Array(LowCardinality(Nullable(Float64))),

    date Array(LowCardinality(Nullable(Date))),
    date_time Array(LowCardinality(Nullable(DateTime('Asia/Istanbul')))),

    str Array(LowCardinality(Nullable(String))),
    fixed_string Array(LowCardinality(Nullable(FixedString(5)))),
    INDEX idx (i8, i16, i32, i64, u8, u16, u32, u64, f32, f64, date, date_time, str, fixed_string)
    TYPE bloom_filter GRANULARITY 1)
ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi', allow_nullable_key = 1;
INSERT INTO bloom_filter_array_lc_null_types_test
SELECT groupArray(number) AS order_key,
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
INSERT INTO bloom_filter_array_lc_null_types_test SELECT groupArray(number) AS order_key, groupArray(toInt8(number)) AS i8, groupArray(toInt16(number)) AS i16, groupArray(toInt32(number)) AS i32, groupArray(toInt64(number)) AS i64, groupArray(toUInt8(number)) AS u8, groupArray(toUInt16(number)) AS u16, groupArray(toUInt32(number)) AS u32, groupArray(toUInt64(number)) AS u64, groupArray(toFloat32(number)) AS f32, groupArray(toFloat64(number)) AS f64, groupArray(toDate(number, 'Asia/Istanbul')) AS date, groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time, groupArray(toString(number)) AS str, groupArray(toFixedString(toString(number), 5)) AS fixed_string FROM (SELECT number FROM system.numbers WHERE number >= 5 LIMIT 15);
INSERT INTO bloom_filter_array_lc_null_types_test SELECT groupArray(number) AS order_key, groupArray(toInt8(number)) AS i8, groupArray(toInt16(number)) AS i16, groupArray(toInt32(number)) AS i32, groupArray(toInt64(number)) AS i64, groupArray(toUInt8(number)) AS u8, groupArray(toUInt16(number)) AS u16, groupArray(toUInt32(number)) AS u32, groupArray(toUInt64(number)) AS u64, groupArray(toFloat32(number)) AS f32, groupArray(toFloat64(number)) AS f64, groupArray(toDate(number, 'Asia/Istanbul')) AS date, groupArray(toDateTime(number, 'Asia/Istanbul')) AS date_time, groupArray(toString(number)) AS str, groupArray(toFixedString(toString(number), 5)) AS fixed_string FROM (SELECT number FROM system.numbers WHERE number >= 10 LIMIT 15);
INSERT INTO bloom_filter_array_lc_null_types_test SELECT n AS order_key, n AS i8, n AS i16, n AS i32, n AS i64, n AS u8, n AS u16, n AS u32, n AS u64, n AS f32, n AS f64, n AS date, n AS date_time, n AS str, n AS fixed_string FROM (SELECT [NULL] AS n);
INSERT INTO bloom_filter_array_lc_null_types_test SELECT [NULL, n] AS order_key, [NULL, toInt8(n)] AS i8, [NULL, toInt16(n)] AS i16, [NULL, toInt32(n)] AS i32, [NULL, toInt64(n)] AS i64, [NULL, toUInt8(n)] AS u8, [NULL, toUInt16(n)] AS u16, [NULL, toUInt32(n)] AS u32, [NULL, toUInt64(n)] AS u64, [NULL, toFloat32(n)] AS f32, [NULL, toFloat64(n)] AS f64, [NULL, toDate(n, 'Asia/Istanbul')] AS date, [NULL, toDateTime(n, 'Asia/Istanbul')] AS date_time, [NULL, toString(n)] AS str, [NULL, toFixedString(toString(n), 5)] AS fixed_string FROM (SELECT 100 as n);
DROP TABLE IF EXISTS bloom_filter_array_lc_null_types_test;
DROP TABLE IF EXISTS bloom_filter_array_offsets_lc_str;
CREATE TABLE bloom_filter_array_offsets_lc_str (order_key int, str Array(LowCardinality(String)), INDEX idx str TYPE bloom_filter(1.) GRANULARITY 1024) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 1024, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_array_offsets_lc_str SELECT number AS i, if(i%2, ['value'], []) FROM system.numbers LIMIT 10000;
SELECT count() FROM bloom_filter_array_offsets_lc_str WHERE has(str, 'value');
DROP TABLE IF EXISTS bloom_filter_array_offsets_lc_str;
DROP TABLE IF EXISTS bloom_filter_array_offsets_str;
CREATE TABLE bloom_filter_array_offsets_str (order_key int, str Array(String), INDEX idx str TYPE bloom_filter(1.) GRANULARITY 1024) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 1024, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_array_offsets_str SELECT number AS i, if(i%2, ['value'], []) FROM system.numbers LIMIT 10000;
DROP TABLE IF EXISTS bloom_filter_array_offsets_str;
DROP TABLE IF EXISTS bloom_filter_array_offsets_i;
CREATE TABLE bloom_filter_array_offsets_i (order_key int, i Array(int), INDEX idx i TYPE bloom_filter(1.) GRANULARITY 1024) ENGINE = MergeTree() ORDER BY order_key SETTINGS index_granularity = 1024, index_granularity_bytes = '10Mi';
INSERT INTO bloom_filter_array_offsets_i SELECT number AS i, if(i%2, [99999], []) FROM system.numbers LIMIT 10000;
DROP TABLE IF EXISTS bloom_filter_array_offsets_i;
DROP TABLE IF EXISTS test_bf_indexOf;
CREATE TABLE test_bf_indexOf ( `id` int, `ary` Array(LowCardinality(Nullable(String))), INDEX idx_ary ary TYPE bloom_filter(0.01) GRANULARITY 1) ENGINE = MergeTree() ORDER BY id SETTINGS index_granularity = 1;
INSERT INTO test_bf_indexOf VALUES (1, ['value1', 'value2']);
INSERT INTO test_bf_indexOf VALUES (2, ['value3']);
DROP TABLE IF EXISTS test_bf_indexOf;
