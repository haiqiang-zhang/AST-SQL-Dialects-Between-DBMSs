create table t1 (c int primary key) engine=innodb;
create table t2 (c int) engine=myisam;
create table t3 (c int) engine=myisam;
insert into t1 (c) values (1);
