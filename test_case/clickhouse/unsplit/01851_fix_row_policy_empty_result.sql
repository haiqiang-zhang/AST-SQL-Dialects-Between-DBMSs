drop table if exists tbl;
create table tbl (s String, i int) engine MergeTree order by i;
insert into tbl values ('123', 123);
drop row policy if exists filter on tbl;
select * from tbl prewhere s = '123' where i = 123;
drop table tbl;
