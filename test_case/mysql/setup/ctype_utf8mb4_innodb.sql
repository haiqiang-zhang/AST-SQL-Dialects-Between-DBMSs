create table t1 (c varchar(30) character set utf8mb4, unique(c(10))) engine=innodb;
insert into t1 values ('1'),('2'),('3'),('x'),('y'),('z');
insert into t1 values ('aaaaaaaaaa');
insert into t1 values (repeat('b',20));
