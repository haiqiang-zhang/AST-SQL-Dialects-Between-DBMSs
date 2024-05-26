insert into function file(02417_data.jsonObjectEachRow) select number, 'Hello' as str, range(number) as arr from numbers(3) settings engine_file_truncate_on_insert=1;
