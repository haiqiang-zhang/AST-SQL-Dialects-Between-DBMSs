create table data_02491 (key Int) engine=MergeTree() order by tuple();
insert into data_02491 values (1);
optimize table data_02491 final;
truncate table data_02491;
system flush logs;
drop table data_02491;
