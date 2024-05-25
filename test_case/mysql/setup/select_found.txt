drop table if exists t1,t2;
create table t1 (a int not null auto_increment, b int not null, primary key(a));
insert into t1 (b) values (2),(3),(5),(5),(5),(6),(7),(9);
