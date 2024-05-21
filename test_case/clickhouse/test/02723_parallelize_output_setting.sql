insert into function file(data_02723.csv) select number from numbers(5) settings engine_file_truncate_on_insert=1;
set max_threads=2;
set parallelize_output_from_storages=1;
select startsWith(trimLeft(explain),'Resize') as resize from (explain pipeline select * from file(data_02723.csv)) where resize;
set parallelize_output_from_storages=0;
select startsWith(trimLeft(explain),'Resize') as resize from (explain pipeline select * from file(data_02723.csv)) where resize;
set parallelize_output_from_storages=1;
select match(arrayStringConcat(groupArray(explain), ''), '.*Resize 1 Ã¢ÂÂ 2 *URL 0 Ã¢ÂÂ 1 *$') from (explain pipeline select x, count() from url('https://example.com', Parquet, 'x Int64') group by x order by count() limit 10);
