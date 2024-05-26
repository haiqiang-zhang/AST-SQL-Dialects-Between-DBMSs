drop table if exists t1,t2,t3,t4;
create table t1 (a int not null,b int not null,c int not null, primary key(a,b))
partition by list (b*a)
(partition x1 values in (1),
 partition x2 values in (3, 11, 5, 7),
 partition x3 values in (16, 8, 5+19, 70-43));
