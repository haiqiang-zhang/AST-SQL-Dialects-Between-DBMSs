insert into function file(data_02314.csv) select number, number + 1 from numbers(5) settings engine_file_truncate_on_insert=1;
insert into function file(data_02314.csv) select number, number + 1, number + 2 from numbers(5);
insert into function file(data_02314.tsv) select number, number + 1 from numbers(5) settings engine_file_truncate_on_insert=1;
insert into function file(data_02314.tsv) select number, number + 1, number + 2 from numbers(5);
