drop table if exists test;
create table test (number UInt64) engine=File('Parquet');
insert into test select * from numbers(10);
insert into test select * from numbers(10, 10) settings engine_file_allow_create_multiple_files=1;
