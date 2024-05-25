drop table if exists tab;
create table tab (id UUID, value UInt32) engine = MergeTree PARTITION BY id order by tuple();
insert into tab values ('61f0c404-5cb3-11e7-907b-a6006ad3dba0', 1), ('61f0c404-5cb3-11e7-907b-a6006ad3dba0', 2);
