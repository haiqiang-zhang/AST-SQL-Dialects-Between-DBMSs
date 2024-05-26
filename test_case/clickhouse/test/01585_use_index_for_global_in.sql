select * from xp where i in (select * from numbers(2));
select * from xp where i global in (select * from numbers(2));
set max_rows_to_read = 6;
drop table if exists xp;
drop table if exists xp_d;
