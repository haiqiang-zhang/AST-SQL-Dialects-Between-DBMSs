set engine_file_truncate_on_insert = 1;
set optimize_or_like_chain = 0;
set max_block_size = 100000;
set max_insert_threads = 1;
SET session_timezone = 'UTC';
set allow_experimental_analyzer=0;
insert into function file('02892.orc')
    -- Use negative numbers to test sign extension for signed types and lack of sign extension for
    -- unsigned types.
    with 5000 - number as n
select
    number,
    intDiv(n, 11)::UInt8 as u8,
    n::UInt16 u16,
    n::UInt32 as u32,
    n::UInt64 as u64,
    intDiv(n, 11)::Int8 as i8,
    n::Int16 i16,
    n::Int32 as i32,
    n::Int64 as i64,

    toDate32(n*500000) as date32,
    toDateTime64(n*1e6, 3) as dt64_ms,
    toDateTime64(n*1e6, 6) as dt64_us,
    toDateTime64(n*1e6, 9) as dt64_ns,
    toDateTime64(n*1e6, 0) as dt64_s,
    toDateTime64(n*1e6, 2) as dt64_cs,
    (n/1000)::Float32 as f32,
    (n/1000)::Float64 as f64,
    n::String as s,
    n::String::FixedString(9) as fs,
    n::Decimal32(3)/1234 as d32,
    n::Decimal64(10)/12345678 as d64,
    n::Decimal128(20)/123456789012345 as d128
    from numbers(10000);
desc file('02892.orc');
select count(), sum(number) from file('02892.orc') where indexHint(u8 in (10, 15, 250));
select count(1), min(u8), max(u8) from file('02892.orc') where u8 in (10, 15, 250);
insert into function file('02892.orc') select
    number,
    if(number%234 == 0, NULL, number) as sometimes_null,
    toNullable(number) as never_null,
    if(number%345 == 0, number::String, NULL) as mostly_null,
    toLowCardinality(if(number%234 == 0, NULL, number)) as sometimes_null_lc,
    toLowCardinality(toNullable(number)) as never_null_lc,
    toLowCardinality(if(number%345 == 0, number::String, NULL)) as mostly_null_lc
    from numbers(1000);
insert into function file('02892.orc') select
    number,
    if(number%234 == 0, NULL, number + 100) as positive_or_null,
    if(number%234 == 0, NULL, -number - 100) as negative_or_null,
    if(number%234 == 0, NULL, 'I am a string') as string_or_null
    from numbers(1000);
