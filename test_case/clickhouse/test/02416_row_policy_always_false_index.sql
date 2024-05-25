drop row policy if exists filter on tbl;
set max_rows_to_read = 0;
select * from tbl;
drop table tbl;
