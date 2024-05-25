set use_structure_from_insertion_table_in_table_functions=2;
insert into test select *, _file, _path from file(02483_data.LineAsString);
select line, _file from test;
drop table test;
