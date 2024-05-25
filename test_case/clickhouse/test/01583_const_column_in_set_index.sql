SET max_rows_to_read = 12;
select * from insub where i in (select toInt32(3) from numbers(10));
drop table if exists insub;
