create table t1(a int, b varchar(20));
create table t2(a int, b varchar(20));
insert into t1 values(1, 'a'), (2, 'b'), (3, 'c'), (3, 'c'), (4, 'c');
insert into t2 values(2, 'd'), (3, 'e'), (4, 'f'), (4, 'f'), (5, 'e'),
                      (6, 'g'), (7, 'h');
