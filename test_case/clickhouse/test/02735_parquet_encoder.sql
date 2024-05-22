set engine_file_truncate_on_insert=1;
set allow_suspicious_low_cardinality_types=1;
-- Do this for all kinds of data types: primitive, Nullable(primitive), Array(primitive),
-- Array(Nullable(primitive)), Array(Array(primitive)), Map(primitive, primitive), etc.

drop table if exists basic_types_02735;
create temporary table basic_types_02735 as select * from generateRandom('
    u8 UInt8,
    u16 UInt16,
    u32 UInt32,
    u64 UInt64,
    i8 Int8,
    i16 Int16,
    i32 Int32,
    i64 Int64,
    date Date,
    date32 Date32,
    datetime DateTime,
    datetime64 DateTime64,
    enum8 Enum8(''x'' = 1, ''y'' = 2, ''z'' = 3),
    enum16 Enum16(''xx'' = 1000, ''yy'' = 2000, ''zz'' = 3000),
    float32 Float32,
    float64 Float64,
    str String,
    fstr FixedString(12),
    u128 UInt128,
    u256 UInt256,
    i128 Int128,
    i256 Int256,
    decimal32 Decimal32(3),
    decimal64 Decimal64(10),
    decimal128 Decimal128(20),
    decimal256 Decimal256(40),
    ipv4 IPv4,
    ipv6 IPv6') limit 10101;
insert into function file(basic_types_02735.parquet) select * from basic_types_02735;
desc file(basic_types_02735.parquet);
select (select sum(cityHash64(*)) from basic_types_02735) - (select sum(cityHash64(*)) from file(basic_types_02735.parquet));
drop table basic_types_02735;
drop table if exists nullables_02735;
create temporary table nullables_02735 as select * from generateRandom('
    u16 Nullable(UInt16),
    i64 Nullable(Int64),
    datetime64 Nullable(DateTime64),
    enum8 Nullable(Enum8(''x'' = 1, ''y'' = 2, ''z'' = 3)),
    float64 Nullable(Float64),
    str Nullable(String),
    fstr Nullable(FixedString(12)),
    i256 Nullable(Int256),
    decimal256 Nullable(Decimal256(40)),
    ipv6 Nullable(IPv6)') limit 10000;
insert into function file(nullables_02735.parquet) select * from nullables_02735;
select (select sum(cityHash64(*)) from nullables_02735) - (select sum(cityHash64(*)) from file(nullables_02735.parquet));
drop table nullables_02735;
--       the next two blocks can be simplified: arrays_out_02735 intermediate table is not needed,
--       a.csv and b.csv are not needed.

drop table if exists arrays_02735;
drop table if exists arrays_out_02735;
create table arrays_02735 engine = Memory as select * from generateRandom('
    u32 Array(UInt32),
    i8 Array(Int8),
    datetime Array(DateTime),
    enum16 Array(Enum16(''xx'' = 1000, ''yy'' = 2000, ''zz'' = 3000)),
    float32 Array(Float32),
    str Array(String),
    fstr Array(FixedString(12)),
    u128 Array(UInt128),
    decimal64 Array(Decimal64(10)),
    ipv4 Array(IPv4),
    msi Map(String, Int16),
    tup Tuple(FixedString(3), Array(String), Map(Int8, Date))') limit 10000;
insert into function file(arrays_02735.parquet) select * from arrays_02735;
create temporary table arrays_out_02735 as arrays_02735;
insert into arrays_out_02735 select * from file(arrays_02735.parquet);
select (select sum(cityHash64(*)) from arrays_02735) - (select sum(cityHash64(*)) from arrays_out_02735);
drop table arrays_02735;
drop table if exists madness_02735;
insert into function file(squash_02735.parquet) select '012345' union all select '543210' settings max_block_size = 1;
select num_columns, num_rows, num_row_groups from file(squash_02735.parquet, ParquetMetadata);
insert into function file(long_string_02735.parquet) select toString(range(number * 2000)) from numbers(2);
select tupleElement(tupleElement(row_groups[1], 'columns'), 'statistics') from file(long_string_02735.parquet, ParquetMetadata);
drop table if exists other_encoders_02735;
create temporary table other_encoders_02735 as select number, number*2 from numbers(10000);
insert into function file(single_thread_02735.parquet) select * from other_encoders_02735 settings max_threads = 1;
select sum(cityHash64(*)) from file(single_thread_02735.parquet);
insert into function file(datetime64_02735.parquet) select
    toDateTime64(number / 1e3, 3) as ms,
    toDateTime64(number / 1e6, 6) as us,
    toDateTime64(number / 1e9, 9) as ns,
    toDateTime64(number / 1e2, 2) as cs,
    toDateTime64(number, 0) as s,
    toDateTime64(number / 1e7, 7) as dus
    from numbers(2000);
desc file(datetime64_02735.parquet);
select sum(cityHash64(*)) from file(datetime64_02735.parquet);
