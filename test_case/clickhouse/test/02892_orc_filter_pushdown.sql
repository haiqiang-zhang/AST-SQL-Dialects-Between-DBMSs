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
