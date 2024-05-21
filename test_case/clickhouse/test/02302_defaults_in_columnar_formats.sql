insert into function file(data_02302.parquet) select 1 as x settings engine_file_truncate_on_insert=1;
insert into function file(data_02302.orc) select 1 as x settings engine_file_truncate_on_insert=1;
insert into function file(data_02302.arrow) select 1 as x settings engine_file_truncate_on_insert=1;
