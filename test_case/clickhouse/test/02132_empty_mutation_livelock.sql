select count() from a8x;
set mutations_sync=1;
alter table a8x update number=0 WHERE number=-3;
drop table if exists a8x;
