drop table if exists t1;
create table t1 (b text not null);
insert t1 values ('aaaaaa bbbbbb cccccc');
insert t1 values ('bbbbbb cccccc');
insert t1 values ('aaaaaa cccccc');
drop table t1;
