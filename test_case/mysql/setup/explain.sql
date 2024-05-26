drop table if exists t1;
create table t1 (id int not null, str char(10), unique(str)) charset utf8mb4;
insert into t1 values (1, null),(2, null),(3, "foo"),(4, "bar");
