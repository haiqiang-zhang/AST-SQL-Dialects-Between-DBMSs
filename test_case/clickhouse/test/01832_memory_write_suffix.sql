drop table if exists data_01832;
-- will be written (since it does not reset the block).
create table data_01832 (key Int) Engine=Memory;
insert into data_01832 values (1);
select * from data_01832;
drop table data_01832;
