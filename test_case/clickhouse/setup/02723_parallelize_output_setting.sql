insert into function file(data_02723.csv) select number from numbers(5) settings engine_file_truncate_on_insert=1;
set max_threads=2;
set parallelize_output_from_storages=1;
