drop table if exists t1;
create table t1 (a varchar(10), key(a)) charset utf8mb4;
insert into t1 values ("a"),("abc"),("abcd"),("hello"),("test");
