drop table if exists data;
create table data (key Int) engine=Memory();
select * from data order by key;
drop table data;
