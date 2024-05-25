insert into function file('test_02244', 'TSV', 'x String, y UInt32') select 'Hello, world!', 42 settings engine_file_truncate_on_insert=1;
