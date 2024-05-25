insert into function file(data_02313.avro) select tuple(number, 'String')::Tuple(a UInt32, b String) as t from numbers(3) settings engine_file_truncate_on_insert=1;
