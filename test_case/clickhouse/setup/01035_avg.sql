SET allow_experimental_bigint_types=1;
CREATE TABLE IF NOT EXISTS test_01035_avg (
    i8 Int8         DEFAULT i64,
    i16 Int16       DEFAULT i64,
    i32 Int32       DEFAULT i64,
    i64 Int64       DEFAULT if(u64 % 2 = 0, toInt64(u64), toInt64(-u64)),
    i128 Int128     DEFAULT i64,
    i256 Int256     DEFAULT i64,

    u8 UInt8        DEFAULT u64,
    u16 UInt16      DEFAULT u64,
    u32 UInt32      DEFAULT u64,
    u64 UInt64,
    u128 UInt128    DEFAULT u64,
    u256 UInt256    DEFAULT u64,

    f32 Float32     DEFAULT u64,
    f64 Float64     DEFAULT u64,

    d32 Decimal32(4)    DEFAULT toDecimal32(i32 / 1000, 4),
    d64 Decimal64(18)   DEFAULT toDecimal64(u64 / 1000000, 8),
    d128 Decimal128(20) DEFAULT toDecimal128(i128 / 100000, 20),
    d256 Decimal256(40) DEFAULT toDecimal256(i256 / 100000, 40)
) ENGINE = MergeTree() ORDER BY i64 SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';