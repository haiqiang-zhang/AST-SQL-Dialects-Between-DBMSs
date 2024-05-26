insert into function file(02416_data.json) select number::UInt32 as n, 'Hello' as s, range(number) as a from numbers(3) settings engine_file_truncate_on_insert=1;
