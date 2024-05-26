desc file('02841.parquet');
select count(), sum(number) from file('02841.parquet') where indexHint(u8 in (10, 15, 250));
select count() from file('02841.parquet') where indexHint(s > '');
