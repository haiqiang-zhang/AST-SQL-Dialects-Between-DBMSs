insert into function file(02454_data.jsonobjecteachrow) select number, concat('name_', toString(number)) as name from numbers(3) settings engine_file_truncate_on_insert=1;
