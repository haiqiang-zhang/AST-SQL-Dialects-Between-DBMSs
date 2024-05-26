set flatten_nested = 1;
insert into function file(02405_data.avro) select [(1, 'aa'), (2, 'bb')]::Nested(x UInt32, y String) as nested settings engine_file_truncate_on_insert=1;
