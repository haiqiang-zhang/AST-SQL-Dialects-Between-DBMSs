drop table if exists dist_01670;
drop table if exists data_01670;
create table data_01670 (key Int) engine=Null();
system stop distributed sends dist_01670;
drop table data_01670;
