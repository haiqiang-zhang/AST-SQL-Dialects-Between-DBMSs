select count() from tbl where _partition_value = ('2021-04-01', 1, 2) settings max_rows_to_read = 1;
create table tbl2(i int) engine MergeTree order by i;
insert into tbl2 values (1);
drop table tbl;
drop table tbl2;
