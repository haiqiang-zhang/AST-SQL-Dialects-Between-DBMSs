drop table if exists src;
create table src( A Int64, B String, C String) Engine=MergeTree order by A SETTINGS min_bytes_for_wide_part=0;
insert into src values(1, 'one', 'test');
alter table src detach partition tuple();
alter table src modify column B Nullable(String);
alter table src attach partition tuple();
alter table src update C = 'test1' where 1 settings mutations_sync=2;
