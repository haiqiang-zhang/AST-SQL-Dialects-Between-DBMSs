set use_structure_from_insertion_table_in_table_functions = 1;
drop table if exists test_02249;
create table test_02249 (x UInt32, y String) engine=Memory();
