drop table if exists t1;
create table t1 (text1 varchar(32) not NULL, KEY key1 (text1)) charset latin1;
insert into t1 values ('teststring'), ('nothing'), ('teststring\t');
